import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:ustahub/presentation/components/universal_appbar.dart';
import 'package:ustahub/presentation/styles/theme_wrapper.dart';

class MapSelectionPage extends StatefulWidget {
  const MapSelectionPage({super.key});

  @override
  State<MapSelectionPage> createState() => _MapSelectionPageState();
}

class _MapSelectionPageState extends State<MapSelectionPage>
    with WidgetsBindingObserver {
  LatLng _currentPosition = const LatLng(41.311081, 69.240562); // Toshkent
  LatLng? _userRealLocation;
  final MapController _mapController = MapController();
  String _address = "";
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _address = "loading_address".tr();
    WidgetsBinding.instance.addObserver(this);
    _determinePosition();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _mapController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _determinePosition();
    }
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      if (mounted) {
        await _showLocationServiceDialog();
      }
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() => _isLoading = false);
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      if (mounted) {
        await _showPermissionDeniedDialog();
      }
      setState(() => _isLoading = false);
      return;
    }

    try {
      Position position = await Geolocator.getCurrentPosition();
      if (mounted) {
        setState(() {
          _userRealLocation = LatLng(position.latitude, position.longitude);
          _currentPosition = _userRealLocation!;
          _isLoading = false;
        });
        _getAddress(_currentPosition);
        _mapController.move(_currentPosition, 18.0);
      }
    } catch (e) {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _showLocationServiceDialog() async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          title: Text("location_disabled_title".tr()),
          content: Text("location_disabled_desc".tr()),
          actions: [
            TextButton(
              child: Text("cancel".tr()),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text("settings".tr()),
              onPressed: () async {
                await Geolocator.openLocationSettings();
                if (mounted) Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showPermissionDeniedDialog() async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          title: Text("permission_denied_title".tr()),
          content: Text("permission_denied_desc".tr()),
          actions: [
            TextButton(
              child: Text("cancel".tr()),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text("settings".tr()),
              onPressed: () async {
                await Geolocator.openAppSettings();
                if (mounted) Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _getAddress(LatLng position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        if (mounted) {
          setState(() {
            _address = "${place.street}, ${place.locality}";
          });
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _address = "cannot_determine_address".tr();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return Scaffold(
          backgroundColor: colors.shade0,
          body: Stack(
            children: [
              Column(
                children: [
                  UniversalAppBar(
                    title: "select_on_map".tr(),
                    centerTitle: true,
                    showBackButton: true,
                  ),
                  Expanded(
                    child: FlutterMap(
                      mapController: _mapController,
                      options: MapOptions(
                        initialCenter: _currentPosition,
                        initialZoom: 18.0,
                        onPositionChanged: (position, hasGesture) {
                          if (position.center != null) {
                            _currentPosition = position.center!;
                          }
                        },
                        onMapEvent: (event) {
                          if (event is MapEventMoveEnd) {
                            _getAddress(_currentPosition);
                          }
                        },
                      ),
                      children: [
                        TileLayer(
                          urlTemplate:
                              'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                          userAgentPackageName: 'com.ustahub.app',
                        ),
                        if (_userRealLocation != null)
                          MarkerLayer(
                            markers: [
                              Marker(
                                point: _userRealLocation!,
                                width: 40.w,
                                height: 40.w,
                                child: Icon(
                                  Icons.my_location,
                                  color: colors.blue500,
                                  size: 24.sp,
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ],
              ),

              // Custom Center Pin
              Center(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 35.h),
                  child: Icon(
                    Icons.location_on,
                    size: 45.sp,
                    color: colors.blue500,
                  ),
                ),
              ),

              // Address Info Card
              Positioned(
                bottom: 30.h + MediaQuery.of(context).padding.bottom,
                left: 20.w,
                right: 20.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // GPS Button
                    GestureDetector(
                      onTap: _determinePosition,
                      child: Container(
                        padding: EdgeInsets.all(12.r),
                        decoration: BoxDecoration(
                          color: colors.shade0,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.gps_fixed,
                          color: colors.blue500,
                          size: 24.sp,
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    // Address Details
                    Container(
                      padding: EdgeInsets.all(20.w),
                      decoration: BoxDecoration(
                        color: colors.shade0,
                        borderRadius: BorderRadius.circular(24.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.location_on_outlined,
                                color: colors.blue500,
                                size: 20.sp,
                              ),
                              SizedBox(width: 8.w),
                              Expanded(
                                child: Text(
                                  _address.isEmpty
                                      ? "loading_address".tr()
                                      : _address,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: fonts.paragraphP2SemiBold.copyWith(
                                    color: colors.neutral800,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20.h),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context, {
                                  'address': _address,
                                  'lat': _currentPosition.latitude,
                                  'lng': _currentPosition.longitude,
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: colors.blue500,
                                foregroundColor: colors.shade0,
                                padding: EdgeInsets.symmetric(vertical: 16.h),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16.r),
                                ),
                                elevation: 0,
                              ),
                              child: Text(
                                "ready".tr(),
                                style: fonts.paragraphP2Bold.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              if (_isLoading)
                Container(
                  color: Colors.black.withOpacity(0.3),
                  child: const Center(child: CircularProgressIndicator()),
                ),
            ],
          ),
        );
      },
    );
  }
}
