import 'package:flutter/material.dart';
import 'package:ustahub/presentation/styles/theme_wrapper.dart';

class PlaceholderPage extends StatelessWidget {
  final String title;

  const PlaceholderPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return Scaffold(
          backgroundColor: colors.shade0,
          appBar: AppBar(
            title: Text(title, style: fonts.headingH5SemiBold),
            backgroundColor: colors.shade0,
            elevation: 0,
            automaticallyImplyLeading: false,
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.construction_outlined,
                  size: 64,
                  color: colors.neutral400,
                ),
                const SizedBox(height: 16),
                Text(
                  '$title Page',
                  style: fonts.headingH4SemiBold?.copyWith(
                    color: colors.neutral800,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Coming soon...',
                  style: fonts.paragraphP2Regular?.copyWith(
                    color: colors.neutral600,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
