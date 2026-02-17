import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';

class MapSelectionPage extends StatefulWidget {
  const MapSelectionPage({super.key});

  @override
  State<MapSelectionPage> createState() => _MapSelectionPageState();
}

class _MapSelectionPageState extends State<MapSelectionPage>
    with WidgetsBindingObserver {
  LatLng _currentPosition = const LatLng(41.311081, 69.240562); // Toshkent
  LatLng? _userRealLocation; // Foydalanuvchining aniq turgan joyi
  final MapController _mapController = MapController();
  String _address = "Manzil yuklanmoqda...";
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
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
    // Sozlamalardan qaytganda lokatsiyani qayta tekshirish
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
        // Zoom darajasini 15.0 dan 18.0 ga o'zgartirdik (yaqinroq ko'rsatish uchun)
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
          title: const Text("Lokatsiya o'chirilgan"),
          content: const Text(
            "Iltimos, manzilni aniqlash uchun qurilmangizda lokatsiyani yoqing.",
          ),
          actions: [
            TextButton(
              child: const Text("Bekor qilish"),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text("Sozlamalar"),
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
          title: const Text("Ruxsat berilmagan"),
          content: const Text(
            "Ilova lokatsiyadan foydalanish uchun ruxsatga ega emas. Iltimos, sozlamalardan ruxsat bering.",
          ),
          actions: [
            TextButton(
              child: const Text("Bekor qilish"),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text("Sozlamalar"),
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
            _address = "${place.street}, ${place.locality}, ${place.country}";
          });
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _address = "Manzilni aniqlab bo'lmadi";
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Manzilni tanlang",
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context, {
                'address': _address,
                'lat': _currentPosition.latitude,
                'lng': _currentPosition.longitude,
              });
            },
            child: Text(
              "Tayyor",
              style: GoogleFonts.poppins(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _currentPosition,
              initialZoom: 18.0, // Boshlang'ich zoomni ham yaqinroq qildik
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
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.ustahub.app',
              ),
              if (_userRealLocation != null)
                MarkerLayer(
                  markers: [
                    Marker(
                      point: _userRealLocation!,
                      width: 40.w,
                      height: 40.w,
                      child: const Icon(
                        Icons.my_location,
                        color: Colors.blue,
                        size: 30,
                      ),
                    ),
                  ],
                ),
            ],
          ),
          // Markazdagi qizil marker (tanlanayotgan joy)
          const Center(
            child: Icon(Icons.location_on, size: 45, color: Colors.red),
          ),
          // Manzil ko'rsatgichi
          Positioned(
            bottom: 10.h + MediaQuery.of(context).padding.bottom,
            left: 20.w,
            right: 20.w,
            child: Container(
              padding: EdgeInsets.all(15.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Text(
                _address,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp,
                ),
              ),
            ),
          ),
          // Turgan joyga qaytish tugmasi
          Positioned(
            right: 20.w,
            bottom: 80.h + MediaQuery.of(context).padding.bottom,
            child: FloatingActionButton(
              mini: true,
              backgroundColor: Colors.white,
              onPressed: _determinePosition,
              child: const Icon(Icons.gps_fixed, color: Colors.blue),
            ),
          ),
          if (_isLoading) const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}
