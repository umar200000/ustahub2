import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ustahub/application2/register_bloc_and_data/bloc/register_bloc.dart';
import 'package:ustahub/infrastructure/services/enum_status/status_enum.dart';
import 'package:ustahub/infrastructure/services/toast/toast_service.dart';
import 'package:ustahub/presentation/styles/theme_wrapper.dart';

import '../../../../infrastructure2/init/injection.dart';

class UserInformationPage extends StatefulWidget {
  const UserInformationPage({super.key});

  @override
  State<UserInformationPage> createState() => _UserInformationPageState();
}

class _UserInformationPageState extends State<UserInformationPage> {
  final bloc = sl<RegisterBloc>();

  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;

  @override
  void initState() {
    super.initState();
    firstNameController = TextEditingController(
      text: bloc.state.userProfile?.firstName ?? '',
    );
    lastNameController = TextEditingController(
      text: bloc.state.userProfile?.lastName ?? '',
    );
    emailController = TextEditingController(
      text: bloc.state.userProfile?.email ?? '',
    );
    phoneController = TextEditingController(
      text: bloc.state.userProfile?.phone ?? '',
    );
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  void _saveChanges() {
    final name = firstNameController.text.trim();
    final lastName = lastNameController.text.trim();
    final email = emailController.text.trim();

    if (name.isEmpty) {
      ToastService.error(
        context: context,
        title: "Xato",
        description: "Ism bo'sh bo'lishi mumkin emas",
      );
      return;
    }
    if (lastName.isEmpty) {
      ToastService.error(
        context: context,
        title: "Xato",
        description: "Familya bo'sh bo'lishi mumkin emas",
      );
      return;
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (email.isEmpty) {
      ToastService.error(
        context: context,
        title: "Xatolik",
        description: "Emailni kiriting",
      );
      return;
    } else if (!emailRegex.hasMatch(email)) {
      ToastService.error(
        context: context,
        title: "Xatolik",
        description: "Email formati noto'g'ri",
      );
      return;
    }

    bloc.add(UpdateUserProfile(name, lastName, email));
  }

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return BlocProvider.value(
          value: bloc,
          child: BlocConsumer<RegisterBloc, RegisterState>(
            listener: (context, state) {
              if (state.statusUser == Status2.success) {
                ToastService.success(
                  context: context,
                  title: "Muvaffaqiyatli",
                  description: "Ma'lumotlar saqlandi!",
                );
                Navigator.pop(context);
              }
              if (state.statusUser == Status2.error) {
                ToastService.error(
                  context: context,
                  title: "Xatolik",
                  description:
                      state.errorMessage ?? "Kutilmagan xato yuz berdi",
                );
              }
            },
            builder: (context, state) {
              return Scaffold(
                backgroundColor: const Color(0xFFF8F9FB),
                appBar: AppBar(
                  scrolledUnderElevation: 0,
                  backgroundColor: Colors.white,
                  elevation: 0.5,
                  leading: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.black87,
                      size: 20.sp,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                  title: Text(
                    'Profil ma\'lumotlari',
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  centerTitle: true,
                ),
                body: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Column(
                          children: [
                            SizedBox(height: 10.h),
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(vertical: 16.h),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20.r),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.04),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    width: 100.w,
                                    height: 100.w,
                                    decoration: BoxDecoration(
                                      color: colors.blue500.withOpacity(0.1),
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: colors.blue500.withOpacity(0.2),
                                        width: 2,
                                      ),
                                    ),
                                    child: Icon(
                                      Icons.person_rounded,
                                      size: 55.sp,
                                      color: colors.blue500,
                                    ),
                                  ),
                                  SizedBox(height: 12.h),
                                  Text(
                                    '${state.userProfile?.firstName ?? ''} ${state.userProfile?.lastName ?? ''}',
                                    style: TextStyle(
                                      fontSize: 19.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 16.h),
                            Container(
                              padding: EdgeInsets.all(20.r),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20.r),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.04),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildEditableField(
                                    label: 'Ism',
                                    controller: firstNameController,
                                    icon: Icons.person_outline,
                                    enabled:
                                        state.statusUser != Status2.loading,
                                    colors: colors,
                                  ),
                                  SizedBox(height: 16.h),
                                  _buildEditableField(
                                    label: 'Familiya',
                                    controller: lastNameController,
                                    icon: Icons.person_outline,
                                    enabled:
                                        state.statusUser != Status2.loading,
                                    colors: colors,
                                  ),
                                  SizedBox(height: 16.h),
                                  _buildEditableField(
                                    label: 'Email manzili',
                                    controller: emailController,
                                    icon: Icons.alternate_email_rounded,
                                    enabled:
                                        state.statusUser != Status2.loading,
                                    keyboardType: TextInputType.emailAddress,
                                    colors: colors,
                                  ),
                                  SizedBox(height: 16.h),
                                  _buildEditableField(
                                    label: 'Telefon raqam',
                                    controller: phoneController,
                                    icon: Icons.phone_android_rounded,
                                    enabled: false,
                                    colors: colors,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 100.h),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 20.h),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 10,
                            offset: const Offset(0, -2),
                          ),
                        ],
                      ),
                      child: SafeArea(
                        top: false,
                        child: SizedBox(
                          width: double.infinity,
                          height: 54.h,
                          child: ElevatedButton(
                            onPressed: state.statusUser == Status2.loading
                                ? null
                                : _saveChanges,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: colors.blue500,
                              foregroundColor: Colors.white,
                              disabledBackgroundColor: colors.blue500
                                  .withOpacity(0.5),
                              elevation: 0,
                              shadowColor: colors.blue500.withOpacity(0.4),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.r),
                              ),
                            ),
                            child: state.statusUser == Status2.loading
                                ? SizedBox(
                                    height: 24.w,
                                    width: 24.w,
                                    child: const CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2.5,
                                    ),
                                  )
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'O\'zgarishlarni saqlash',
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                                    ],
                                  ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildEditableField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    required bool enabled,
    required dynamic colors,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 4.w, bottom: 6.h),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
              color: Colors.grey[600],
            ),
          ),
        ),
        TextFormField(
          controller: controller,
          enabled: enabled,
          keyboardType: keyboardType,
          style: TextStyle(
            fontSize: 15.sp,
            color: enabled ? Colors.black87 : Colors.grey[500],
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
            isDense: true,
            filled: true,
            fillColor: enabled ? Colors.white : Colors.grey[50],
            prefixIcon: Icon(
              icon,
              color: enabled ? colors.blue500 : Colors.grey[400],
              size: 20.sp,
            ),
            suffixIcon: !enabled
                ? Icon(Icons.lock_rounded, color: Colors.grey[300], size: 18.sp)
                : null,
            contentPadding: EdgeInsets.symmetric(
              vertical: 16.h,
              horizontal: 12.w,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: Colors.grey.shade200),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: Colors.grey.shade200),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: colors.blue500, width: 1.5),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: Colors.grey.shade100),
            ),
            hintText: '$label kiriting',
            hintStyle: TextStyle(fontSize: 14.sp, color: Colors.grey[400]),
          ),
        ),
      ],
    );
  }
}
