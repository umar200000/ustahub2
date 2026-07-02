import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:ustahub/application2/register_bloc_and_data/bloc/register_bloc.dart';
import 'package:ustahub/infrastructure/services/notification_provider.dart';
import 'package:ustahub/presentation/pages/notification_page/notification_page.dart';
import 'package:ustahub/presentation/styles/theme_wrapper.dart';

import '../../../components/animation_effect.dart';

class HomeAppBar extends StatefulWidget {
  final bool showShadow;

  const HomeAppBar({super.key, this.showShadow = false});

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar> with WidgetsBindingObserver {
  bool _locationEnabled = false;
  String _locationText = 'Joylashuv aniqlanmoqda...';
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _checkLocation();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // Re-check when user returns from Settings or permission dialog
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _checkLocation();
    }
  }

  Future<void> _checkLocation() async {
    if (!mounted) return;
    setState(() => _loading = true);

    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      if (mounted) {
        setState(() {
          _locationEnabled = false;
          _locationText = 'GPS o\'chirilgan';
          _loading = false;
        });
      }
      return;
    }

    final permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      if (mounted) {
        setState(() {
          _locationEnabled = false;
          _locationText = 'Joylashuvga ruxsat yo\'q';
          _loading = false;
        });
      }
      return;
    }

    // Permission granted — get current position
    try {
      final pos = await Geolocator.getCurrentPosition(
        locationSettings:
            const LocationSettings(accuracy: LocationAccuracy.low),
      ).timeout(const Duration(seconds: 8));
      final address = await _reverseGeocode(pos.latitude, pos.longitude);
      if (mounted) {
        setState(() {
          _locationEnabled = true;
          _locationText = address;
          _loading = false;
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() {
          _locationEnabled = true;
          _locationText = 'Joylashuv aniqlandi';
          _loading = false;
        });
      }
    }
  }

  Future<String> _reverseGeocode(double lat, double lng) async {
    try {
      final placemarks = await placemarkFromCoordinates(lat, lng);
      if (placemarks.isNotEmpty) {
        final p = placemarks.first;
        final parts = <String>[];
        if (p.subLocality != null && p.subLocality!.isNotEmpty) {
          parts.add(p.subLocality!);
        } else if (p.locality != null && p.locality!.isNotEmpty) {
          parts.add(p.locality!);
        }
        if (p.administrativeArea != null &&
            p.administrativeArea!.isNotEmpty) {
          parts.add(p.administrativeArea!);
        }
        return parts.isNotEmpty ? parts.join(', ') : 'Joylashuv aniqlandi';
      }
    } catch (_) {}
    return 'Joylashuv aniqlandi';
  }

  Future<void> _requestLocation() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      // GPS o'chirilgan — dialog orqali yoqishni taklif qil
      if (!mounted) return;
      await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
          title: Row(
            children: [
              const Icon(Icons.location_off_rounded, color: Colors.orange),
              SizedBox(width: 8.w),
              const Text('GPS o\'chirilgan'),
            ],
          ),
          content: const Text(
            'Yaqin atrofdagi xizmatlarni ko\'rish uchun qurilmangizda GPS ni yoqing.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Bekor qilish'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
                Geolocator.openLocationSettings();
              },
              child: const Text('GPS yoqish'),
            ),
          ],
        ),
      );
      return;
    }

    final permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.deniedForever) {
      // Muddatsiz rad etilgan — sozlamalarni ochish
      if (!mounted) return;
      await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
          title: Row(
            children: [
              const Icon(Icons.location_disabled, color: Colors.red),
              SizedBox(width: 8.w),
              const Text('Ruxsat yo\'q'),
            ],
          ),
          content: const Text(
            'Joylashuv ruxsati rad etilgan. Ilovalar sozlamalaridan ruxsat bering.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Bekor qilish'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
                Geolocator.openAppSettings();
              },
              child: const Text('Sozlamalar'),
            ),
          ],
        ),
      );
      return;
    }

    // So'rash mumkin
    final result = await Geolocator.requestPermission();
    if (result == LocationPermission.whileInUse ||
        result == LocationPermission.always) {
      await _checkLocation();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: colors.shade0,
            boxShadow: widget.showShadow
                ? [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.06),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              child: Row(
                children: [
                  // User info section
                  Expanded(
                    child: BlocBuilder<RegisterBloc, RegisterState>(
                      builder: (context, state) {
                        final user = state.userProfile;
                        final firstName = user?.firstName ?? 'Guest';
                        final lastName = user?.lastName ?? 'User';

                        return Row(
                          children: [
                            // Profile avatar
                            Container(
                              width: 44.w,
                              height: 44.w,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color:
                                    colors.blue500.withValues(alpha: 0.1),
                                border: Border.all(
                                  color:
                                      colors.blue500.withValues(alpha: 0.3),
                                  width: 2,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  firstName.isNotEmpty
                                      ? firstName[0].toUpperCase()
                                      : 'G',
                                  style: fonts.paragraphP1Bold.copyWith(
                                    color: colors.blue500,
                                    fontSize: 18.sp,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 12.w),
                            // Name and location
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    '$firstName $lastName',
                                    style: fonts.paragraphP2Bold.copyWith(
                                      color: colors.shade100,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 2.h),
                                  AnimationButtonEffect(
                                    onTap: _locationEnabled
                                        ? null
                                        : _requestLocation,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        if (_loading)
                                          SizedBox(
                                            width: 10.w,
                                            height: 10.w,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 1.5,
                                              color: colors.neutral500,
                                            ),
                                          )
                                        else ...[
                                          Container(
                                            width: 7.w,
                                            height: 7.w,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: _locationEnabled
                                                  ? const Color(0xFF22C55E)
                                                  : const Color(0xFFA0A0A0),
                                            ),
                                          ),
                                          SizedBox(width: 4.w),
                                          Icon(
                                            _locationEnabled
                                                ? Icons.location_on
                                                : Icons.location_off_outlined,
                                            size: 13.sp,
                                            color: _locationEnabled
                                                ? const Color(0xFF22C55E)
                                                : colors.neutral500,
                                          ),
                                        ],
                                        SizedBox(width: 3.w),
                                        Expanded(
                                          child: Text(
                                            _locationText,
                                            style: fonts.paragraphP3Regular
                                                .copyWith(
                                              color: _locationEnabled
                                                  ? colors.shade100
                                                      .withValues(alpha: 0.75)
                                                  : colors.neutral500,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        if (!_locationEnabled &&
                                            !_loading) ...[
                                          SizedBox(width: 2.w),
                                          Icon(
                                            Icons.chevron_right,
                                            size: 14.sp,
                                            color: colors.neutral500,
                                          ),
                                        ],
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),

                  // Notification button
                  Consumer<NotificationProvider>(
                    builder: (context, provider, _) {
                      return AnimationButtonEffect(
                        onTap: () {
                          provider.markAllAsRead();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const NotificationPage(),
                            ),
                          );
                        },
                        child: SizedBox(
                          width: 44.w,
                          height: 44.w,
                          child: Stack(
                            children: [
                              Container(
                                width: 44.w,
                                height: 44.w,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: colors.neutral100,
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.notifications_none_outlined,
                                    color: colors.shade100,
                                    size: 24.sp,
                                  ),
                                ),
                              ),
                              if (provider.unreadCount > 0)
                                Positioned(
                                  right: 0,
                                  top: 0,
                                  child: Container(
                                    padding: EdgeInsets.all(4.r),
                                    decoration: const BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle,
                                    ),
                                    constraints: BoxConstraints(
                                      minWidth: 18.w,
                                      minHeight: 18.w,
                                    ),
                                    child: Center(
                                      child: Text(
                                        provider.unreadCount > 9
                                            ? '9+'
                                            : '${provider.unreadCount}',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
