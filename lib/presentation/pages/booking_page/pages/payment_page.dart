import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ustahub/application2/booking_bloc_and_data/bloc/booking_bloc.dart';
import 'package:ustahub/application2/card_bloc_and_data/bloc/card_bloc.dart';
import 'package:ustahub/application2/payment_bloc_and_data/bloc/payment_bloc.dart';
import 'package:ustahub/infrastructure/services/enum_status/status_enum.dart';
import 'package:ustahub/presentation/pages/booking_page/pages/booking_success_page.dart';
import 'package:ustahub/presentation/pages/my_card/presentation/pages/add_card_page.dart';
import 'package:ustahub/presentation/styles/theme.dart';
import 'package:ustahub/presentation/styles/theme_wrapper.dart';

class PaymentPage extends StatefulWidget {
  final String bookingId;
  final String serviceName;

  const PaymentPage({
    super.key,
    required this.bookingId,
    required this.serviceName,
  });

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

enum PaymentMethod { card, cash }

class _PaymentPageState extends State<PaymentPage> {
  PaymentMethod _selectedMethod = PaymentMethod.card;
  static const int _price = 50000;

  @override
  void initState() {
    super.initState();
    context.read<CardBloc>().add(const GetCardsEvent());
  }

  String _formatPrice(int price) {
    final str = price.toString();
    final buffer = StringBuffer();
    for (int i = 0; i < str.length; i++) {
      if (i > 0 && (str.length - i) % 3 == 0) {
        buffer.write(' ');
      }
      buffer.write(str[i]);
    }
    return buffer.toString();
  }

  void _onPay() {
    if (_selectedMethod == PaymentMethod.card) {
      context.read<PaymentBloc>().add(
        CreatePaymentEvent(
          bookingId: widget.bookingId,
          paymentProvider: "payme",
        ),
      );
    } else {
      // Cash — to'g'ridan-to'g'ri success
      context.read<PaymentBloc>().add(
        CreatePaymentEvent(
          bookingId: widget.bookingId,
          paymentProvider: "cash",
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return Scaffold(
          backgroundColor: colors.neutral100,
          appBar: AppBar(
            backgroundColor: colors.shade0,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text(
              "payment".tr(),
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            centerTitle: true,
          ),
          body: BlocConsumer<PaymentBloc, PaymentState>(
            listenWhen: (prev, curr) => prev.status != curr.status,
            listener: (context, state) {
              if (state.status == Status2.success) {
                context.read<BookingBloc>().add(
                  const GetBookingsListEvent(isRefresh: true),
                );
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const BookingSuccessPage(),
                  ),
                );
              } else if (state.status == Status2.error) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.errorMessage ?? "error".tr()),
                    backgroundColor: Colors.red,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              }
            },
            builder: (context, paymentState) {
              return Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.all(16.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Service info
                          Container(
                            width: double.infinity,
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "service_name".tr(),
                                  style: fonts.paragraphP3Regular.copyWith(
                                    color: colors.neutral500,
                                  ),
                                ),
                                Gap(4.h),
                                Text(
                                  widget.serviceName,
                                  style: fonts.paragraphP1Bold,
                                ),
                                Gap(12.h),
                                Divider(height: 1, color: colors.neutral200),
                                Gap(12.h),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "amount_to_pay".tr(),
                                      style: fonts.paragraphP2Regular.copyWith(
                                        color: colors.neutral500,
                                      ),
                                    ),
                                    Text(
                                      "${_formatPrice(_price)} ${"sum".tr()}",
                                      style: fonts.paragraphP1Bold.copyWith(
                                        color: colors.primary500,
                                        fontSize: 20.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Gap(20.h),

                          // Payment method
                          Text(
                            "payment_method".tr(),
                            style: GoogleFonts.poppins(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Gap(12.h),

                          // Card option
                          _buildPaymentOption(
                            icon: Icons.credit_card,
                            title: "pay_by_card".tr(),
                            subtitle: "pay_by_card_desc".tr(),
                            isSelected: _selectedMethod == PaymentMethod.card,
                            onTap: () {
                              setState(() {
                                _selectedMethod = PaymentMethod.card;
                              });
                            },
                            colors: colors,
                            fonts: fonts,
                          ),
                          Gap(12.h),

                          // Cash option
                          _buildPaymentOption(
                            icon: Icons.money,
                            title: "pay_by_cash".tr(),
                            subtitle: "pay_by_cash_desc".tr(),
                            isSelected: _selectedMethod == PaymentMethod.cash,
                            onTap: () {
                              setState(() {
                                _selectedMethod = PaymentMethod.cash;
                              });
                            },
                            colors: colors,
                            fonts: fonts,
                          ),
                          Gap(20.h),

                          // Card warning / add card
                          if (_selectedMethod == PaymentMethod.card)
                            BlocBuilder<CardBloc, CardState>(
                              builder: (context, cardState) {
                                if (cardState.listStatus == Status2.loading) {
                                  return const SizedBox.shrink();
                                }

                                if (cardState.cards.isEmpty) {
                                  return Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.all(16.w),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFFFF3E0),
                                      borderRadius:
                                          BorderRadius.circular(12.r),
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.warning_amber_rounded,
                                              color: const Color(0xFFFF9800),
                                              size: 24.sp,
                                            ),
                                            SizedBox(width: 12.w),
                                            Expanded(
                                              child: Text(
                                                "no_card_warning".tr(),
                                                style: fonts
                                                    .paragraphP2Regular
                                                    .copyWith(
                                                  color:
                                                      const Color(0xFFE65100),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Gap(12.h),
                                        SizedBox(
                                          width: double.infinity,
                                          child: OutlinedButton.icon(
                                            onPressed: () async {
                                              await Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (_) =>
                                                      const AddCardPage(),
                                                ),
                                              );
                                              if (mounted) {
                                                context.read<CardBloc>().add(
                                                  const GetCardsEvent(),
                                                );
                                              }
                                            },
                                            icon: const Icon(Icons.add),
                                            label: Text("add_card".tr()),
                                            style: OutlinedButton.styleFrom(
                                              foregroundColor:
                                                  const Color(0xFFE65100),
                                              side: const BorderSide(
                                                color: Color(0xFFFF9800),
                                              ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  12.r,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }

                                // Karta bor — birinchi kartani ko'rsatish
                                final card = cardState.cards.first;
                                return Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all(16.w),
                                  decoration: BoxDecoration(
                                    color: colors.shade0,
                                    borderRadius: BorderRadius.circular(12.r),
                                    border:
                                        Border.all(color: colors.primary500),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.check_circle,
                                        color: colors.primary500,
                                        size: 20.sp,
                                      ),
                                      SizedBox(width: 12.w),
                                      Text(
                                        "${(card.cardType ?? "").toUpperCase()}  ${card.cardNumber ?? ""}",
                                        style: fonts.paragraphP2Bold,
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                        ],
                      ),
                    ),
                  ),

                  // Pay button
                  Container(
                    padding: EdgeInsets.fromLTRB(
                      16.w,
                      12.h,
                      16.w,
                      12.h + MediaQuery.of(context).padding.bottom,
                    ),
                    decoration: BoxDecoration(
                      color: colors.shade0,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 12,
                          offset: const Offset(0, -4),
                        ),
                      ],
                    ),
                    child: BlocBuilder<CardBloc, CardState>(
                      builder: (context, cardState) {
                        final canPay = _selectedMethod == PaymentMethod.cash ||
                            cardState.cards.isNotEmpty;
                        final isLoading =
                            paymentState.status == Status2.loading;

                        return GestureDetector(
                          onTap: canPay && !isLoading ? _onPay : null,
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(vertical: 16.h),
                            decoration: BoxDecoration(
                              color: canPay
                                  ? colors.primary500
                                  : colors.neutral300,
                              borderRadius: BorderRadius.circular(16.r),
                              boxShadow: canPay
                                  ? [
                                      BoxShadow(
                                        color: colors.primary500
                                            .withValues(alpha: 0.3),
                                        blurRadius: 12,
                                        offset: const Offset(0, 4),
                                      ),
                                    ]
                                  : null,
                            ),
                            child: Center(
                              child: isLoading
                                  ? SizedBox(
                                      width: 24.w,
                                      height: 24.w,
                                      child:
                                          const CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 2.5,
                                      ),
                                    )
                                  : Text(
                                      "${"pay".tr()} ${_formatPrice(_price)} ${"sum".tr()}",
                                      style:
                                          fonts.paragraphP1Bold.copyWith(
                                        color: Colors.white,
                                      ),
                                    ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildPaymentOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool isSelected,
    required VoidCallback onTap,
    required CustomColorSet colors,
    required FontSet fonts,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: colors.shade0,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isSelected ? colors.primary500 : colors.neutral200,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: colors.primary500.withValues(alpha: 0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Row(
          children: [
            Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: isSelected
                    ? colors.primary500.withValues(alpha: 0.1)
                    : colors.neutral100,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                icon,
                color: isSelected ? colors.primary500 : colors.neutral500,
                size: 22.sp,
              ),
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: fonts.paragraphP2Bold),
                  Gap(2.h),
                  Text(
                    subtitle,
                    style: fonts.paragraphP3Regular.copyWith(
                      color: colors.neutral500,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 22.w,
              height: 22.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color:
                      isSelected ? colors.primary500 : colors.neutral300,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 12.w,
                        height: 12.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: colors.primary500,
                        ),
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
