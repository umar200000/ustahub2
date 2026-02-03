import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ustahub/application2/auth_bloc_and_data/bloc/auth_bloc.dart';
import 'package:ustahub/infrastructure/services/enum_status/status_enum.dart';
import 'package:ustahub/presentation/pages/auth/widgets/pin_put_widget.dart';
import 'package:ustahub/presentation/pages/auth/widgets/uz_phone_formatter.dart';
import 'package:ustahub/presentation/styles/theme_wrapper.dart';

import '../../../../infrastructure2/init/injection.dart';
import 'auth_button.dart';

class EnterPhoneNumberBox extends StatefulWidget {
  const EnterPhoneNumberBox({super.key});

  @override
  State<EnterPhoneNumberBox> createState() => _EnterPhoneNumberBoxState();
}

class _EnterPhoneNumberBoxState extends State<EnterPhoneNumberBox> {
  final TextEditingController _controller = TextEditingController();
  final authBloc = sl<AuthBloc>();
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void showPinPutWidget(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return const PinPutWidget();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: authBloc,
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (ModalRoute.of(context)?.isCurrent != true) return;
          if (state.phoneStatus == Status2.success) {
            showPinPutWidget(context);
          } else if (state.phoneStatus == Status2.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? "Xatolik"),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: ThemeWrapper(
          builder: (context, colors, fonts, icons, controller) => Container(
            width: double.infinity,
            padding: EdgeInsets.only(
              left: 20.w,
              right: 20.w,
              top: 16.h,
              bottom:
                  MediaQuery.of(context).viewInsets.bottom +
                  MediaQuery.of(context).padding.bottom,
            ),
            decoration: BoxDecoration(
              color: colors.darkMode800,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: colors.shade0.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                24.h.verticalSpace,
                Text(
                  'enter_phone_number'.tr(),
                  style: fonts.subheadingRegular.copyWith(
                    color: colors.shade0,
                    fontSize: 22.sp,
                  ),
                ),
                24.h.verticalSpace,
                Container(
                  decoration: BoxDecoration(
                    color: colors.darkMode700,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: colors.shade0.withOpacity(0.1)),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Row(
                    children: [
                      Text(
                        "+998 ",
                        style: fonts.paragraphP2SemiBold.copyWith(
                          color: colors.shade0,
                          fontSize: 18.sp,
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          autofocus: true,
                          keyboardType: TextInputType.phone,
                          inputFormatters: [UzPhoneFormatter()],
                          style: fonts.paragraphP2SemiBold.copyWith(
                            color: colors.shade0,
                            fontSize: 18.sp,
                          ),
                          decoration: InputDecoration(
                            hintText: "(_ _) _ _ _  _ _  _ _",
                            hintStyle: fonts.paragraphP2SemiBold.copyWith(
                              color: colors.shade0.withOpacity(0.3),
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                24.h.verticalSpace,
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    final isLoading = state.phoneStatus == Status2.loading;
                    return AuthButton(
                      color: colors.blue500,
                      onTap: isLoading
                          ? () {}
                          : () {
                              final phoneNumber =
                                  "+998${_controller.text.replaceAll(' ', '')}";

                              if (phoneNumber.length == 13) {
                                authBloc.add(
                                  EnterPhoneNumberEvent(
                                    phoneNumber: phoneNumber,
                                  ),
                                );
                              }
                            },
                      textColor: colors.shade0,
                      title: "continue".tr(),
                      child: isLoading
                          ? Center(
                              child: SizedBox(
                                width: 24.r,
                                height: 24.r,
                                child: CircularProgressIndicator(
                                  color: colors.shade0,
                                  strokeWidth: 2,
                                ),
                              ),
                            )
                          : null,
                    );
                  },
                ),
                24.h.verticalSpace,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
