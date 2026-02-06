import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ustahub/application2/register_bloc_and_data/bloc/register_bloc.dart';
import 'package:ustahub/infrastructure/services/enum_status/status_enum.dart';
import 'package:ustahub/presentation/pages/auth/widgets/auth_button.dart';
import 'package:ustahub/presentation/pages/auth/widgets/custom_text_field.dart';
import 'package:ustahub/presentation/routes/routes.dart';
import 'package:ustahub/presentation/styles/theme_wrapper.dart';

import '../../../application2/auth_bloc_and_data/bloc/auth_bloc.dart';
import '../../../infrastructure2/init/injection.dart';
import '../../styles/theme.dart';

class Register2Page extends StatefulWidget {
  const Register2Page({super.key});

  @override
  State<Register2Page> createState() => _Register2PageState();
}

class _Register2PageState extends State<Register2Page> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  DateTime _selectedDate = DateTime(1995, 5, 15);
  final registerBloc = sl<RegisterBloc>();
  final authBloc = sl<AuthBloc>();

  bool _isPhoneError = false;
  bool _isFirstNameEmpty = false;
  bool _isLastNameEmpty = false;
  bool _isDobEmpty = false;

  void _showDatePicker(
    BuildContext context,
    CustomColorSet colors,
    FontSet fonts,
  ) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => Container(
        height: 300.h,
        color: colors.darkMode800,
        child: Column(
          children: [
            Container(
              height: 200.h,
              child: CupertinoTheme(
                data: CupertinoThemeData(
                  textTheme: CupertinoTextThemeData(
                    dateTimePickerTextStyle: TextStyle(
                      color: colors.shade0,
                      fontSize: 18.sp,
                    ),
                  ),
                ),
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime: _selectedDate,
                  onDateTimeChanged: (DateTime newDate) {
                    setState(() {
                      _selectedDate = newDate;
                    });
                  },
                ),
              ),
            ),
            CupertinoButton(
              child: Text("OK", style: TextStyle(color: colors.blue500)),
              onPressed: () {
                _dobController.text = DateFormat(
                  'dd-MM-yyyy',
                ).format(_selectedDate);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: registerBloc,
      child: BlocConsumer<RegisterBloc, RegisterState>(
        listener: (context, state) {
          if (ModalRoute.of(context)?.isCurrent != true) return;
          if (state.status == Status2.success &&
              state.statusUser == Status2.success) {
            Navigator.pushAndRemoveUntil(
              context,
              AppRoutes.main(),
              (route) => false,
            );
          }
        },
        builder: (context, state) {
          return ThemeWrapper(
            builder: (context, colors, fonts, icons, controller) => Scaffold(
              backgroundColor: colors.darkMode900,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back, color: colors.shade0),
                  onPressed: () => Navigator.pop(context),
                ),
                title: Text(
                  "registration".tr(),
                  style: fonts.subheadingRegular.copyWith(color: colors.shade0),
                ),
              ),
              body: SingleChildScrollView(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  children: [
                    CustomTextField(
                      controller: _firstNameController,
                      hintText: "first_name".tr(),
                      keyboardType: TextInputType.name,
                      error: _isFirstNameEmpty,
                    ),
                    16.h.verticalSpace,
                    CustomTextField(
                      controller: _lastNameController,
                      hintText: "last_name".tr(),
                      keyboardType: TextInputType.name,
                      error: _isLastNameEmpty,
                    ),
                    16.h.verticalSpace,
                    CustomTextField(
                      controller: _dobController,
                      hintText: "date_of_birth".tr(),
                      readOnly: true,
                      onTap: () => _showDatePicker(context, colors, fonts),
                      error: _isDobEmpty,
                    ),
                    if (state.status == Status2.error)
                      Padding(
                        padding: EdgeInsets.only(top: 20.h),
                        child: Text(
                          state.errorMessage!,
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    40.h.verticalSpace,
                    AuthButton(
                      color: colors.blue500,
                      onTap: () {
                        if (state.status == Status2.success &&
                            state.statusUser == Status2.error) {
                          if (state.statusUser == Status2.error) {
                            registerBloc.add(GetUserProfileEvent());
                          }
                          return;
                        }
                        final String phoneDigits =
                            authBloc.state.authPhoneNumber!.data!.phone!;
                        setState(() {
                          _isFirstNameEmpty = _firstNameController.text.isEmpty;
                          _isLastNameEmpty = _lastNameController.text.isEmpty;
                          _isDobEmpty = _dobController.text.isEmpty;
                        });
                        if (!_isPhoneError &&
                            !_isFirstNameEmpty &&
                            !_isLastNameEmpty &&
                            !_isDobEmpty) {
                          registerBloc.add(
                            CompleteRegistrationEvent(
                              phone: phoneDigits,
                              firstName: _firstNameController.text,
                              lastName: _lastNameController.text,
                              dateOfBirth: DateFormat(
                                "yyyy-MM-dd",
                              ).format(_selectedDate),
                            ),
                          );
                        }
                      },
                      textColor: colors.shade0,
                      title: "continue".tr(),
                      child:
                          state.status == Status2.loading ||
                              state.statusUser == Status2.loading
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
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
