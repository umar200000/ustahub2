import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ustahub/presentation/pages/auth/widgets/auth_content_box.dart';
import 'package:ustahub/presentation/pages/auth/widgets/background_grid.dart';
import 'package:ustahub/presentation/pages/auth/widgets/language_widget.dart';
import 'package:ustahub/presentation/styles/theme_wrapper.dart';

enum AuthFlowStep { initial, phoneInput, otpVerification }

class AuthOptions extends StatefulWidget {
  final bool showGuestOption;
  const AuthOptions({super.key, this.showGuestOption = true});

  @override
  State<AuthOptions> createState() => _AuthOptionsState();
}

class _AuthOptionsState extends State<AuthOptions> {
  String selectedLang = 'UZ'; // Default to UZ
  AuthFlowStep _currentStep = AuthFlowStep.initial;

  final TextEditingController _phoneController = TextEditingController();
  String? _phoneNumber;
  final List<TextEditingController> _otpControllers = List.generate(
    6,
    (_) => TextEditingController(),
  );
  final List<FocusNode> _otpFocusNodes = List.generate(6, (_) => FocusNode());
  int _otpTimerSeconds = 60;
  bool _canResend = false;
  bool _isVerifying = false;
  String codeValue = "";

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final currentLocale = context.locale;
    if (currentLocale.languageCode == 'uz') {
      selectedLang = 'UZ';
    } else if (currentLocale.languageCode == 'ru') {
      selectedLang = 'RU';
    } else if (currentLocale.languageCode == 'en') {
      selectedLang = 'EN';
    }
  }

  @override
  void dispose() {
    _phoneController.dispose();
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var node in _otpFocusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _goToPhoneInput() =>
      setState(() => _currentStep = AuthFlowStep.phoneInput);

  void _goToOtpVerification() {
    final phone = _phoneController.text.trim();
    setState(() {
      _phoneNumber = phone.startsWith('+') ? phone : '+998$phone';
      _currentStep = AuthFlowStep.otpVerification;
      _isVerifying = false;
    });
  }

  void _goBack() {
    setState(() {
      if (_currentStep == AuthFlowStep.otpVerification) {
        for (var controller in _otpControllers) {
          controller.clear();
        }
        codeValue = "";
        _currentStep = AuthFlowStep.phoneInput;
      } else if (_currentStep == AuthFlowStep.phoneInput) {
        _currentStep = AuthFlowStep.initial;
      }
    });
  }

  void _updateLanguage(String lang, Locale locale) {
    setState(() {
      selectedLang = lang;
    });
    context.setLocale(locale);
  }

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: colors.shade100,
          body: Stack(
            children: [
              Positioned.fill(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: BackgroundGrid(colors: colors),
                ),
              ),
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        colors.shade100.withOpacity(0.3),
                        colors.shade100.withOpacity(0.7),
                        colors.shade100.withOpacity(0.95),
                      ],
                      stops: const [0.0, 0.5, 0.8],
                    ),
                  ),
                ),
              ),
              SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          LanguageSelectorWidget(
                            colors: colors,
                            fonts: fonts,
                            onLanguageChanged: _updateLanguage,
                            selectedLang: selectedLang,
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    AuthContentBox(showGuestOption: widget.showGuestOption),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
