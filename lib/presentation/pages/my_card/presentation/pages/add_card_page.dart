import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:ustahub/application2/card_bloc_and_data/bloc/card_bloc.dart';
import 'package:ustahub/infrastructure/services/enum_status/status_enum.dart';
import 'package:ustahub/presentation/components/universal_appbar.dart';
import 'package:ustahub/presentation/pages/auth/widgets/auth_button.dart';
import 'package:ustahub/presentation/pages/auth/widgets/custom_text_field.dart';
import 'package:ustahub/presentation/styles/theme_wrapper.dart';
import 'package:ustahub/utils/extensions.dart';

import 'card_pin_put_page.dart';

class AddCardPage extends StatefulWidget {
  final bool fromPayment;
  const AddCardPage({super.key, this.fromPayment = false});

  @override
  State<AddCardPage> createState() => _AddCardPageState();
}

class _AddCardPageState extends State<AddCardPage> {
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryController = TextEditingController();

  @override
  void dispose() {
    _cardNumberController.dispose();
    _expiryController.dispose();
    super.dispose();
  }

  void _onAddCard() {
    final cardNumber = _cardNumberController.text.replaceAll(' ', '');
    final expiry = _expiryController.text;

    if (cardNumber.length < 16) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("enter_card_number".tr()),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    if (expiry.length < 5) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("enter_expiry".tr()),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    context.read<CardBloc>().add(
      BindCardEvent(cardNumber: cardNumber, expiry: expiry),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return Scaffold(
          backgroundColor: colors.shade0,
          body: BlocConsumer<CardBloc, CardState>(
            listener: (context, state) {
              if (ModalRoute.of(context)?.isCurrent != true) return;
              if (state.bindStatus == Status2.success) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CardPinPutPage(
                      transactionId: state.transactionId!,
                      phone: state.phone ?? "",
                      fromPayment: widget.fromPayment,
                    ),
                  ),
                );
              } else if (state.bindStatus == Status2.error) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.errorMessage ?? "error".tr()),
                    backgroundColor: Colors.red,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              }
            },
            builder: (context, state) {
              return Column(
                children: [
                  UniversalAppBar(
                    title: "add_card".tr(),
                    showBackButton: true,
                    centerTitle: true,
                    backgroundColor: colors.primary500,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(
                        horizontal: 24.w,
                        vertical: 32.h,
                      ),
                      child: Column(
                        children: [
                          CustomTextField(
                            controller: _cardNumberController,
                            hintText: "0000 0000 0000 0000",
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(16),
                              CardNumberFormatter(),
                            ],
                            prefix: Padding(
                              padding: EdgeInsets.only(right: 8.w),
                              child: Icon(
                                Icons.credit_card,
                                color: Colors.black87,
                                size: 24.sp,
                              ),
                            ),
                          ),
                          Gap(20.h),
                          CustomTextField(
                            controller: _expiryController,
                            hintText: "MM/YY",
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(4),
                              CardMMYYFormatter(),
                            ],
                          ),
                          Gap(60.h),
                          AuthButton(
                            title: "add_card".tr(),
                            onTap: state.bindStatus == Status2.loading
                                ? null
                                : _onAddCard,
                            color: colors.primary500,
                            textColor: colors.shade0,
                            child: state.bindStatus == Status2.loading
                                ? SizedBox(
                                    width: 24.w,
                                    height: 24.w,
                                    child: const CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2.5,
                                    ),
                                  )
                                : null,
                          ),
                        ],
                      ),
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
}
