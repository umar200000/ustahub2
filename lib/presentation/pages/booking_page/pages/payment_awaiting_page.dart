import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:ustahub/application2/booking_bloc_and_data/bloc/booking_bloc.dart';
import 'package:ustahub/application2/payment_bloc_and_data/bloc/payment_bloc.dart';
import 'package:ustahub/infrastructure/services/enum_status/status_enum.dart';
import 'package:ustahub/presentation/pages/booking_page/pages/booking_success_page.dart';
import 'package:ustahub/presentation/styles/theme_wrapper.dart';

enum _FailedStep { preApply, apply }

class PaymentAwaitingPage extends StatefulWidget {
  final String paymentId;
  final String cardId;

  const PaymentAwaitingPage({
    super.key,
    required this.paymentId,
    required this.cardId,
  });

  @override
  State<PaymentAwaitingPage> createState() => _PaymentAwaitingPageState();
}

class _PaymentAwaitingPageState extends State<PaymentAwaitingPage> {
  bool _applyDispatched = false;
  _FailedStep? _failedStep;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _startPreApply();
    });
  }

  void _startPreApply() {
    setState(() => _failedStep = null);
    context.read<PaymentBloc>().add(
      PreApplyPaymentEvent(
        paymentId: widget.paymentId,
        cardId: widget.cardId,
      ),
    );
  }

  void _startApply() {
    setState(() => _failedStep = null);
    _applyDispatched = true;
    context.read<PaymentBloc>().add(
      ApplyPaymentEvent(paymentId: widget.paymentId),
    );
  }

  void _onRetry() {
    if (_failedStep == _FailedStep.preApply) {
      _startPreApply();
    } else if (_failedStep == _FailedStep.apply) {
      _startApply();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return Scaffold(
          backgroundColor: colors.shade0,
          appBar: AppBar(
            backgroundColor: colors.shade0,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: colors.neutral800),
              onPressed: () => Navigator.maybePop(context),
            ),
          ),
          body: MultiBlocListener(
            listeners: [
              // Pre-apply success → avtomatik apply chaqiramiz
              BlocListener<PaymentBloc, PaymentState>(
                listenWhen: (prev, curr) =>
                    prev.preApplyStatus != curr.preApplyStatus,
                listener: (context, state) {
                  if (state.preApplyStatus == Status2.success &&
                      !_applyDispatched) {
                    _startApply();
                  } else if (state.preApplyStatus == Status2.error) {
                    setState(() => _failedStep = _FailedStep.preApply);
                    _showError(state.errorMessage);
                  }
                },
              ),
              // Apply success → BookingSuccessPage
              BlocListener<PaymentBloc, PaymentState>(
                listenWhen: (prev, curr) =>
                    prev.applyStatus != curr.applyStatus,
                listener: (context, state) {
                  if (state.applyStatus == Status2.success) {
                    context.read<BookingBloc>().add(
                      const GetBookingsListEvent(isRefresh: true),
                    );
                    Future.delayed(const Duration(milliseconds: 200), () {
                      if (!mounted) return;
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const BookingSuccessPage(),
                        ),
                      );
                    });
                  } else if (state.applyStatus == Status2.error) {
                    setState(() => _failedStep = _FailedStep.apply);
                    _showError(state.errorMessage);
                  }
                },
              ),
            ],
            child: BlocBuilder<PaymentBloc, PaymentState>(
              builder: (context, state) {
                final isError = _failedStep != null;

                return SafeArea(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 96.w,
                          height: 96.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isError
                                ? colors.red500.withValues(alpha: 0.1)
                                : colors.primary500.withValues(alpha: 0.1),
                          ),
                          child: isError
                              ? Icon(
                                  Icons.error_outline,
                                  size: 48.sp,
                                  color: colors.red500,
                                )
                              : Padding(
                                  padding: EdgeInsets.all(24.w),
                                  child: CircularProgressIndicator(
                                    color: colors.primary500,
                                    strokeWidth: 3.5,
                                  ),
                                ),
                        ),
                        Gap(28.h),
                        Text(
                          isError
                              ? "error".tr()
                              : "payment_processing".tr(),
                          style: fonts.headingH4Bold.copyWith(
                            color: colors.neutral800,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Gap(10.h),
                        Text(
                          isError
                              ? (state.errorMessage ?? "error".tr())
                              : "payment_processing_desc".tr(),
                          textAlign: TextAlign.center,
                          style: fonts.paragraphP2Regular.copyWith(
                            color: colors.neutral500,
                            height: 1.5,
                          ),
                        ),
                        if (isError) ...[
                          Gap(28.h),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              onPressed: _onRetry,
                              icon: const Icon(Icons.refresh),
                              label: Text(
                                "try_again".tr(),
                                style: fonts.paragraphP1Bold.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: colors.primary500,
                                foregroundColor: Colors.white,
                                padding: EdgeInsets.symmetric(vertical: 16.h),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14.r),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  void _showError(String? message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message ?? "error".tr()),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
