import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ustahub/presentation/pages/auth/widgets/auth_button.dart';
import 'package:ustahub/presentation/pages/auth/widgets/custom_text_field.dart';
import 'package:ustahub/presentation/pages/auth/widgets/uz_phone_formatter.dart';
import 'package:ustahub/presentation/styles/theme_wrapper.dart';

import '../../styles/theme.dart';

class Register2Page extends StatefulWidget {
  const Register2Page({super.key});

  @override
  State<Register2Page> createState() => _Register2PageState();
}

class _Register2PageState extends State<Register2Page> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  DateTime _selectedDate = DateTime(1995, 5, 15);

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
                controller: _phoneController,
                hintText: "(_ _) _ _ _  _ _  _ _",
                keyboardType: TextInputType.phone,
                inputFormatters: [UzPhoneFormatter()],
                prefix: Text(
                  "+998 ",
                  style: fonts.paragraphP2SemiBold.copyWith(
                    color: colors.shade0,
                    fontSize: 16.sp,
                  ),
                ),
              ),
              16.h.verticalSpace,
              CustomTextField(
                controller: _firstNameController,
                hintText: "first_name".tr(),
                keyboardType: TextInputType.name,
              ),
              16.h.verticalSpace,
              CustomTextField(
                controller: _lastNameController,
                hintText: "last_name".tr(),
                keyboardType: TextInputType.name,
              ),
              16.h.verticalSpace,
              CustomTextField(
                controller: _dobController,
                hintText: "date_of_birth".tr(),
                readOnly: true,
                onTap: () => _showDatePicker(context, colors, fonts),
              ),
              40.h.verticalSpace,
              AuthButton(
                color: colors.blue500,
                onTap: () {
                  // Registration logic
                  print({
                    "phone": "+998${_phoneController.text.replaceAll(' ', '')}",
                    "first_name": _firstNameController.text,
                    "last_name": _lastNameController.text,
                    "date_of_birth": _dobController.text,
                  });
                },
                textColor: colors.shade0,
                title: "continue".tr(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
