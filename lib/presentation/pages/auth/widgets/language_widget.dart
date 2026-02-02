import 'dart:ui';

import 'package:flutter/material.dart';

class LanguageSelectorWidget extends StatelessWidget {
  final String selectedLang;
  final Function(String, Locale) onLanguageChanged;
  final dynamic colors;
  final dynamic fonts;

  const LanguageSelectorWidget({
    super.key,
    required this.selectedLang,
    required this.onLanguageChanged,
    required this.colors,
    required this.fonts,
  });

  @override
  Widget build(BuildContext context) {
    final languages = [
      ('EN', 'English', const Locale('en', 'US')),
      ('RU', 'Русский', const Locale('ru', 'RU')),
      ('UZ', "O'zbek", const Locale('uz', 'UZ')),
    ];

    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
          decoration: BoxDecoration(
            color: colors.shade100.withOpacity(0.18),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: colors.shade0.withOpacity(0.25),
              width: 1.2,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: languages.map((lang) {
              final isSelected = selectedLang == lang.$1;
              return GestureDetector(
                onTap: () => onLanguageChanged(lang.$1, lang.$3),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? colors.shade0.withOpacity(0.25)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    lang.$1,
                    style: fonts.paragraphP3Medium.copyWith(
                      color: isSelected
                          ? colors.shade0
                          : colors.shade0.withOpacity(0.7),
                      fontWeight: isSelected
                          ? FontWeight.w700
                          : FontWeight.w500,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
