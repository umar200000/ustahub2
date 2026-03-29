import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:shimmer/shimmer.dart';
import 'package:ustahub/application2/payment_bloc_and_data/bloc/payment_bloc.dart';
import 'package:ustahub/application2/payment_bloc_and_data/data/model/payment_model.dart';
import 'package:ustahub/infrastructure/services/enum_status/status_enum.dart';
import 'package:ustahub/presentation/components/universal_appbar.dart';
import 'package:ustahub/presentation/pages/payment_history/payment_detail_page.dart';
import 'package:ustahub/presentation/styles/theme.dart';
import 'package:ustahub/presentation/styles/theme_wrapper.dart';

class PaymentHistoryPage extends StatefulWidget {
  const PaymentHistoryPage({super.key});

  @override
  State<PaymentHistoryPage> createState() => _PaymentHistoryPageState();
}

class _PaymentHistoryPageState extends State<PaymentHistoryPage> {
  @override
  void initState() {
    super.initState();
    context.read<PaymentBloc>().add(const GetPaymentHistoryEvent());
  }

  String _formatAmount(String? amount) {
    if (amount == null) return "0";
    final parts = amount.split('.');
    final intPart = parts[0];
    final buffer = StringBuffer();
    for (int i = 0; i < intPart.length; i++) {
      if (i > 0 && (intPart.length - i) % 3 == 0) {
        buffer.write(' ');
      }
      buffer.write(intPart[i]);
    }
    return buffer.toString();
  }

  String _formatDate(String? dateStr) {
    if (dateStr == null) return "";
    try {
      final date = DateTime.parse(dateStr);
      return "${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year}  ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}";
    } catch (_) {
      return dateStr;
    }
  }

  Color _getStatusColor(String? status, CustomColorSet colors) {
    switch (status) {
      case 'completed':
        return const Color(0xFF4CAF50);
      case 'pending':
        return const Color(0xFFFF9800);
      case 'failed':
      case 'cancelled':
        return colors.red500;
      default:
        return colors.neutral500;
    }
  }

  IconData _getProviderIcon(String? provider) {
    switch (provider) {
      case 'payme':
        return Icons.credit_card;
      case 'click':
        return Icons.touch_app;
      case 'cash':
        return Icons.money;
      default:
        return Icons.payment;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return Scaffold(
          backgroundColor: colors.neutral100,
          body: Column(
            children: [
              UniversalAppBar(
                title: "payment_history".tr(),
                showBackButton: true,
                centerTitle: true,
                backgroundColor: colors.primary500,
              ),
              Expanded(
                child: BlocBuilder<PaymentBloc, PaymentState>(
                  builder: (context, state) {
                    if (state.historyStatus == Status2.loading) {
                      return _buildShimmer();
                    }

                    if (state.historyStatus == Status2.error) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.error_outline,
                              size: 48.sp,
                              color: colors.neutral400,
                            ),
                            Gap(16.h),
                            Text(
                              state.errorMessage ?? "error".tr(),
                              style: fonts.paragraphP2Regular.copyWith(
                                color: colors.neutral600,
                              ),
                            ),
                            Gap(16.h),
                            TextButton(
                              onPressed: () {
                                context.read<PaymentBloc>().add(
                                  const GetPaymentHistoryEvent(),
                                );
                              },
                              child: Text("retry".tr()),
                            ),
                          ],
                        ),
                      );
                    }

                    if (state.historyItems.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.receipt_long_outlined,
                              size: 64.sp,
                              color: colors.neutral300,
                            ),
                            Gap(16.h),
                            Text(
                              "no_payments".tr(),
                              style: fonts.paragraphP1Bold.copyWith(
                                color: colors.neutral500,
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    return RefreshIndicator(
                      onRefresh: () async {
                        context.read<PaymentBloc>().add(
                          const GetPaymentHistoryEvent(),
                        );
                      },
                      child: ListView.separated(
                        padding: EdgeInsets.all(16.w),
                        itemCount: state.historyItems.length,
                        separatorBuilder: (_, __) => Gap(10.h),
                        itemBuilder: (context, index) {
                          final item = state.historyItems[index];
                          return _buildPaymentCard(
                            item,
                            colors,
                            fonts,
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPaymentCard(
    PaymentHistoryItem item,
    CustomColorSet colors,
    FontSet fonts,
  ) {
    final statusColor = _getStatusColor(item.status, colors);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => PaymentDetailPage(paymentId: item.id ?? ""),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: colors.shade0,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Icon
            Container(
              width: 48.w,
              height: 48.w,
              decoration: BoxDecoration(
                color: statusColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(14.r),
              ),
              child: Icon(
                _getProviderIcon(item.paymentProvider),
                color: statusColor,
                size: 22.sp,
              ),
            ),
            SizedBox(width: 14.w),

            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          (item.paymentProvider ?? "").toUpperCase(),
                          style: fonts.paragraphP2Bold,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        "${_formatAmount(item.amount)} ${item.currency ?? ""}",
                        style: fonts.paragraphP1Bold.copyWith(
                          color: colors.neutral800,
                        ),
                      ),
                    ],
                  ),
                  Gap(6.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _formatDate(item.createdAt),
                        style: fonts.paragraphP3Regular.copyWith(
                          color: colors.neutral500,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: statusColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Text(
                          (item.status ?? "").toUpperCase(),
                          style: TextStyle(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w700,
                            color: statusColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(width: 8.w),
            Icon(
              Icons.arrow_forward_ios,
              size: 14.sp,
              color: colors.neutral300,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.separated(
        padding: EdgeInsets.all(16.w),
        itemCount: 5,
        separatorBuilder: (_, __) => Gap(10.h),
        itemBuilder: (_, __) => Container(
          height: 80.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
          ),
        ),
      ),
    );
  }
}
