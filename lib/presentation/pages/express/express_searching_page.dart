import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ustahub/application2/express_bloc_and_data/bloc/express_bloc.dart';
import 'package:ustahub/application2/express_bloc_and_data/data/model/express_model.dart';
import 'package:ustahub/application2/express_bloc_and_data/service/express_client_socket.dart';
import 'package:ustahub/infrastructure/services/shared_perf/shared_pref_service.dart';
import 'package:ustahub/infrastructure2/init/injection.dart';
import 'package:ustahub/presentation/styles/style.dart';

class ExpressSearchingPage extends StatefulWidget {
  final String categoryName;

  const ExpressSearchingPage({super.key, required this.categoryName});

  @override
  State<ExpressSearchingPage> createState() => _ExpressSearchingPageState();
}

class _ExpressSearchingPageState extends State<ExpressSearchingPage>
    with TickerProviderStateMixin {
  late final AnimationController _pulseController;
  late final Animation<double> _pulseAnimation;

  ExpressClientSocket? _socket;
  StreamSubscription? _socketSub;
  Timer? _pollTimer;

  /// WS yoki polling tomonidan bitta marta ishlov berish uchun flag
  bool _handled = false;

  /// WS ulanish boshlangan bo'lsa — takroriy connect qilmaymiz
  bool _wsConnecting = false;

  @override
  void initState() {
    super.initState();

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 0.92, end: 1.08).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    // Sahifa birinchi chiqqanda state ni tekshiramiz.
    // Agar session allaqachon bor va searching bo'lsa — WS + polling boshlaylik.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final s = context.read<ExpressClientBloc>().state;
      debugPrint(
        '[SearchPage] initState check: status=${s.status} sessionId=${s.session?.sessionId}',
      );
      if (s.status == ExpressSearchStatus.searching &&
          s.session?.sessionId != null) {
        _startWsAndPolling(s.session!.sessionId!);
      }
      // noMasters yoki matched holati — BlocBuilder o'zi ko'rsatadi
    });
  }

  // ─── WS + polling ──────────────────────────────────────────────────────────

  void _startWsAndPolling(String sessionId) {
    if (_wsConnecting || _handled) return;
    _wsConnecting = true;
    _connectWs(sessionId);
    _startPolling(sessionId);
  }

  void _connectWs(String sessionId) {
    final token = sl<SharedPrefService>().getTokenModel()?.accessToken ?? '';
    if (token.isEmpty) {
      debugPrint('[SearchPage] ⚠ token bo\'sh — WS ulanmaydi');
      return;
    }

    _socket = ExpressClientSocket(accessToken: token, sessionId: sessionId);
    _socketSub = _socket!.events.listen(
      _handleWsMessage,
      onError: (e) => debugPrint('[SearchPage] WS error: $e'),
    );
    _socket!.connect();
  }

  void _handleWsMessage(Map<String, dynamic> msg) {
    if (_handled || !mounted) return;
    final type = msg['type']?.toString();
    debugPrint('[SearchPage] WS message → type=$type');

    switch (type) {
      case 'status':
        // {"type":"status","status":"connected","search_status":"searching"}
        // Bu ulanish tasdiqi. Hech narsa qilmaymiz.
        debugPrint('[SearchPage] WS connected status=${msg["search_status"]}');
        break;

      case 'search_status':
        // {"type":"search_status","session_id":"...","status":"searching|exhausted|matched|canceled"}
        // Server: agar WS ulanishdan oldin sessiya hal bo'lgan bo'lsa shu keladi.
        final statusVal = msg['status']?.toString();
        debugPrint('[SearchPage] WS search_status: $statusVal');
        if (statusVal == 'exhausted' || statusVal == 'canceled') {
          _handled = true;
          _cleanup();
          if (mounted) {
            context.read<ExpressClientBloc>().add(ExpressNoMastersEvent());
          }
        } else if (statusVal == 'matched') {
          // Sessiya allaqachon matched — WS ni yopamiz, lekin polling davom etsin.
          // Polling 3 soniyada matched+booking ma'lumotlarini olib keladi.
          _socketSub?.cancel();
          _socket?.dispose();
          _socket = null;
          debugPrint('[SearchPage] WS search_status=matched → WS closed, polling continues');
        }
        break;

      case 'express_matched':
        _handled = true;
        _cleanup();
        final matched = ExpressMatchedModel.fromJson(msg);
        debugPrint(
          '[SearchPage] ✅ express_matched: master=${matched.masterName}',
        );
        if (mounted) {
          context
              .read<ExpressClientBloc>()
              .add(ExpressMatchedEvent(matched: matched));
        }
        break;

      case 'express_no_masters':
        _handled = true;
        _cleanup();
        debugPrint('[SearchPage] ❌ express_no_masters via WS');
        if (mounted) {
          context.read<ExpressClientBloc>().add(ExpressNoMastersEvent());
        }
        break;

      default:
        debugPrint('[SearchPage] WS unknown type=$type msg=$msg');
    }
  }

  void _startPolling(String sessionId) {
    _pollTimer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (_handled || !mounted) {
        _pollTimer?.cancel();
        return;
      }
      context.read<ExpressClientBloc>().add(
            PollExpressStatusEvent(sessionId: sessionId),
          );
    });
  }

  // ─── cancel ────────────────────────────────────────────────────────────────

  void _cancelSearch() {
    debugPrint('[SearchPage] user cancelled search');
    final sessionId =
        context.read<ExpressClientBloc>().state.session?.sessionId;
    if (sessionId != null) {
      context.read<ExpressClientBloc>().add(
            CancelExpressSearchEvent(sessionId: sessionId),
          );
    }
    _cleanup();
    if (mounted) Navigator.pop(context);
  }

  void _cleanup() {
    debugPrint('[SearchPage] cleanup');
    _pollTimer?.cancel();
    _socketSub?.cancel();
    _socket?.dispose();
    _socket = null;
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _cleanup();
    super.dispose();
  }

  // ─── build ────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _cancelSearch();
      },
      child: BlocListener<ExpressClientBloc, ExpressClientState>(
        // Session yangi kelganda YOKI status o'zgarganda ushlaymiz
        listenWhen: (prev, curr) {
          final sessionArrived =
              prev.session?.sessionId == null &&
              curr.session?.sessionId != null;
          final statusChanged = prev.status != curr.status;
          return sessionArrived || statusChanged;
        },
        listener: (context, state) {
          debugPrint(
            '[SearchPage] BlocListener: status=${state.status} '
            'sessionId=${state.session?.sessionId}',
          );

          // Session yangi keldi VA hali searching holatida — WS + polling boshlaylik
          if (state.session?.sessionId != null &&
              state.status == ExpressSearchStatus.searching &&
              !_handled) {
            _startWsAndPolling(state.session!.sessionId!);
          }

          // Terminal holatlar — tozalaymiz
          if (state.status == ExpressSearchStatus.matched && !_handled) {
            _handled = true;
            _cleanup();
          }
          if (state.status == ExpressSearchStatus.noMasters && !_handled) {
            _handled = true;
            _cleanup();
          }
        },
        child: Scaffold(
          backgroundColor: const Color(0xFF1A1D2E),
          body: BlocBuilder<ExpressClientBloc, ExpressClientState>(
            builder: (context, state) {
              if (state.status == ExpressSearchStatus.matched &&
                  state.matched != null) {
                return _buildMatchedView(state.matched!);
              }
              if (state.status == ExpressSearchStatus.noMasters) {
                return _buildNoMastersView();
              }
              if (state.status == ExpressSearchStatus.error) {
                return _buildErrorView(state.errorMessage);
              }
              return _buildSearchingView(state);
            },
          ),
        ),
      ),
    );
  }

  // ─── views ────────────────────────────────────────────────────────────────

  Widget _buildSearchingView(ExpressClientState state) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          children: [
            SizedBox(height: 60.h),
            AnimatedBuilder(
              animation: _pulseAnimation,
              builder: (_, child) => Transform.scale(
                scale: _pulseAnimation.value,
                child: child,
              ),
              child: Container(
                width: 160.w,
                height: 160.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Style.primary500.withValues(alpha: 0.12),
                ),
                child: Center(
                  child: Container(
                    width: 100.w,
                    height: 100.w,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Style.primary500,
                    ),
                    child: Icon(
                      Icons.flash_on_rounded,
                      color: Colors.white,
                      size: 44.sp,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 40.h),
            Text(
              'express_searching_title'.tr(),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 22.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              widget.categoryName,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Style.primary500,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              'express_searching_subtitle'.tr(),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white60,
                fontSize: 14.sp,
              ),
            ),
            SizedBox(height: 32.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                3,
                (i) => _DotIndicator(delay: i * 250),
              ),
            ),
            const Spacer(),
            TextButton(
              onPressed: _cancelSearch,
              child: Text(
                'express_cancel'.tr(),
                style: TextStyle(color: Colors.white54, fontSize: 14.sp),
              ),
            ),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }

  Widget _buildMatchedView(ExpressMatchedModel matched) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100.w,
              height: 100.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Style.primary500.withValues(alpha: 0.15),
              ),
              child: Icon(
                Icons.check_circle_rounded,
                color: Style.primary500,
                size: 60.sp,
              ),
            ),
            SizedBox(height: 28.h),
            Text(
              'express_matched_title'.tr(),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'express_matched_subtitle'.tr(),
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white60, fontSize: 14.sp),
            ),
            SizedBox(height: 32.h),
            Container(
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Column(
                children: [
                  if (matched.masterName != null)
                    _buildInfoRow(
                      icon: Icons.person_rounded,
                      label: 'express_master_name'.tr(),
                      value: matched.masterName!,
                    ),
                  if (matched.masterPhone != null) ...[
                    Divider(height: 20.h, color: Colors.white12),
                    _buildInfoRow(
                      icon: Icons.phone_rounded,
                      label: 'express_master_phone'.tr(),
                      value: matched.masterPhone!,
                    ),
                  ],
                ],
              ),
            ),
            SizedBox(height: 40.h),
            SizedBox(
              width: double.infinity,
              height: 52.h,
              child: ElevatedButton(
                onPressed: () {
                  context
                      .read<ExpressClientBloc>()
                      .add(ResetExpressClientEvent());
                  Navigator.of(context).popUntil((r) => r.isFirst);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Style.primary500,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'express_done'.tr(),
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 15.sp,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNoMastersView() {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100.w,
              height: 100.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.red.withValues(alpha: 0.12),
              ),
              child: Icon(
                Icons.person_off_rounded,
                color: Colors.red.shade300,
                size: 52.sp,
              ),
            ),
            SizedBox(height: 28.h),
            Text(
              'express_no_masters_title'.tr(),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 22.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              'express_no_masters_subtitle'.tr(),
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white60, fontSize: 14.sp),
            ),
            SizedBox(height: 40.h),
            SizedBox(
              width: double.infinity,
              height: 52.h,
              child: ElevatedButton(
                onPressed: () {
                  // Faqat qidiruv natijasini tozalaymiz — viloyat/tuman/kategoriya saqlanib qoladi
                  context
                      .read<ExpressClientBloc>()
                      .add(ClearSearchResultEvent());
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Style.primary500,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'express_try_again'.tr(),
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 15.sp,
                  ),
                ),
              ),
            ),
            SizedBox(height: 12.h),
            TextButton(
              onPressed: () {
                context
                    .read<ExpressClientBloc>()
                    .add(ResetExpressClientEvent());
                Navigator.of(context).popUntil((r) => r.isFirst);
              },
              child: Text(
                'express_back_home'.tr(),
                style: TextStyle(color: Colors.white54, fontSize: 14.sp),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorView(String? message) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline_rounded,
                color: Colors.red.shade300, size: 72.sp),
            SizedBox(height: 20.h),
            Text(
              message ?? 'Xatolik yuz berdi',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white70, fontSize: 14.sp),
            ),
            SizedBox(height: 32.h),
            TextButton(
              onPressed: () {
                // Xatolikda ham ro'yxatlarni saqlab, faqat natijani tozalaymiz
                context
                    .read<ExpressClientBloc>()
                    .add(ClearSearchResultEvent());
                Navigator.pop(context);
              },
              child: Text(
                'express_back'.tr(),
                style: TextStyle(color: Style.primary500, fontSize: 14.sp),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: Style.primary500.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Icon(icon, color: Style.primary500, size: 18.sp),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Text(
            label,
            style: TextStyle(color: Colors.white54, fontSize: 13.sp),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

// ─── Dot loading indicator ────────────────────────────────────────────────────

class _DotIndicator extends StatefulWidget {
  final int delay;
  const _DotIndicator({required this.delay});

  @override
  State<_DotIndicator> createState() => _DotIndicatorState();
}

class _DotIndicatorState extends State<_DotIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    Future.delayed(Duration(milliseconds: widget.delay), () {
      if (mounted) _ctrl.repeat(reverse: true);
    });
    _anim = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _anim,
      builder: (context, child) => Container(
        width: 10.w,
        height: 10.w,
        margin: EdgeInsets.symmetric(horizontal: 4.w),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Style.primary500.withValues(alpha: _anim.value),
        ),
      ),
    );
  }
}
