import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:shimmer/shimmer.dart';
import 'package:ustahub/application2/payment_bloc_and_data/bloc/payment_bloc.dart';
import 'package:ustahub/infrastructure/services/enum_status/status_enum.dart';
import 'package:ustahub/presentation/components/universal_appbar.dart';
import 'package:ustahub/presentation/styles/theme.dart';
import 'package:ustahub/presentation/styles/theme_wrapper.dart';

class PaymentDetailPage extends StatefulWidget {
  final String paymentId;

  const PaymentDetailPage({super.key, required this.paymentId});

  @override
  State<PaymentDetailPage> createState() => _PaymentDetailPageState();
}

class _PaymentDetailPageState extends State<PaymentDetailPage> {
  @override
  void initState() {
    super.initState();
    context.read<PaymentBloc>().add(
      GetPaymentDetailEvent(paymentId: widget.paymentId),
    );
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
    if (dateStr == null) return "—";
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

  IconData _getStatusIcon(String? status) {
    switch (status) {
      case 'completed':
        return Icons.check_circle;
      case 'pending':
        return Icons.schedule;
      case 'failed':
      case 'cancelled':
        return Icons.cancel;
      default:
        return Icons.info;
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
                title: "payment_details".tr(),
                showBackButton: true,
                centerTitle: true,
                backgroundColor: colors.primary500,
              ),
              Expanded(
                child: BlocBuilder<PaymentBloc, PaymentState>(
                  builder: (context, state) {
                    if (state.detailStatus == Status2.loading) {
                      return _buildShimmer();
                    }

                    if (state.detailStatus == Status2.error) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(state.errorMessage ?? "error".tr()),
                            Gap(16.h),
                            TextButton(
                              onPressed: () {
                                context.read<PaymentBloc>().add(
                                  GetPaymentDetailEvent(
                                    paymentId: widget.paymentId,
                                  ),
                                );
                              },
                              child: Text("retry".tr()),
                            ),
                          ],
                        ),
                      );
                    }

                    final data = state.detailData;
                    if (data == null) return const SizedBox.shrink();

                    final statusColor = _getStatusColor(data.status, colors);

                    return SingleChildScrollView(
                      padding: EdgeInsets.all(16.w),
                      child: Column(
                        children: [
                          // Status karta
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(24.w),
                            decoration: BoxDecoration(
                              color: colors.shade0,
                              borderRadius: BorderRadius.circular(20.r),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.05),
                                  blurRadius: 12,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Container(
                                  width: 64.w,
                                  height: 64.w,
                                  decoration: BoxDecoration(
                                    color: statusColor.withValues(alpha: 0.1),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    _getStatusIcon(data.status),
                                    color: statusColor,
                                    size: 32.sp,
                                  ),
                                ),
                                Gap(16.h),
                                Text(
                                  "${_formatAmount(data.amount)} ${data.currency ?? ""}",
                                  style: TextStyle(
                                    fontSize: 32.sp,
                                    fontWeight: FontWeight.w800,
                                    color: colors.neutral800,
                                  ),
                                ),
                                Gap(8.h),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 16.w,
                                    vertical: 6.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: statusColor.withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(20.r),
                                  ),
                                  child: Text(
                                    (data.status ?? "").toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w700,
                                      color: statusColor,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Gap(16.h),

                          // Tafsilotlar
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(20.w),
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
                            child: Column(
                              children: [
                                _buildDetailRow(
                                  "payment_type_label".tr(),
                                  (data.paymentType ?? "").toUpperCase(),
                                  colors,
                                  fonts,
                                ),
                                _divider(colors),
                                _buildDetailRow(
                                  "payment_provider_label".tr(),
                                  (data.paymentProvider ?? "").toUpperCase(),
                                  colors,
                                  fonts,
                                ),
                                _divider(colors),
                                _buildDetailRow(
                                  "payment_date".tr(),
                                  _formatDate(data.paidAt),
                                  colors,
                                  fonts,
                                ),
                                _divider(colors),
                                _buildDetailRow(
                                  "payment_id_label".tr(),
                                  data.id?.substring(0, 8) ?? "—",
                                  colors,
                                  fonts,
                                ),
                              ],
                            ),
                          ),
                        ],
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

  Widget _buildDetailRow(
    String label,
    String value,
    CustomColorSet colors,
    FontSet fonts,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: fonts.paragraphP2Regular.copyWith(
              color: colors.neutral500,
            ),
          ),
          Text(value, style: fonts.paragraphP2Bold),
        ],
      ),
    );
  }

  Widget _divider(CustomColorSet colors) {
    return Divider(height: 1, color: colors.neutral100);
  }

  Widget _buildShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 180.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.r),
              ),
            ),
            Gap(16.h),
            Container(
              width: double.infinity,
              height: 200.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
