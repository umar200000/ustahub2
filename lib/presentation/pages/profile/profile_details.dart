import 'package:flutter/material.dart';
import 'package:ustahub/presentation/styles/theme_wrapper.dart';

class ProfileDetails extends StatelessWidget {
  const ProfileDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return Scaffold(backgroundColor: colors.neutral100);
      },
    );
  }
}
