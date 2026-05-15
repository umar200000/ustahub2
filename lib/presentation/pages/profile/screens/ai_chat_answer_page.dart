import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:ustahub/presentation/components/animation_effect.dart';
import 'package:ustahub/presentation/components/universal_appbar.dart';
import 'package:ustahub/presentation/pages/profile/data/faq_data.dart';
import 'package:ustahub/presentation/styles/theme.dart';
import 'package:ustahub/presentation/styles/theme_wrapper.dart';
import 'package:ustahub/utils/launcher.dart';

class AiChatAnswerPage extends StatelessWidget {
  final FaqItem item;

  const AiChatAnswerPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final category = faqCategoryFor(item.categoryId);
    final showSupportCard = item.categoryId == FaqCategoryId.support;

    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return Scaffold(
          backgroundColor: colors.bgSurface,
          body: Column(
            children: [
              UniversalAppBar(
                title: 'ai_chat'.tr(),
                showBackButton: true,
                centerTitle: true,
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 24.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _UserMessage(text: item.questionKey.tr(), colors: colors),
                      Gap(14.h),
                      _BotMessage(
                        text: item.answerKey.tr(),
                        category: category,
                        colors: colors,
                      ),
                      Gap(24.h),
                      if (showSupportCard) ...[
                        _ContactSupportCard(colors: colors),
                        Gap(12.h),
                      ],
                      _BackToQuestionsButton(
                        colors: colors,
                        onTap: () => Navigator.pop(context),
                      ),
                      Gap(MediaQuery.of(context).padding.bottom),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _UserMessage extends StatelessWidget {
  final String text;
  final CustomColorSet colors;

  const _UserMessage({required this.text, required this.colors});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SizedBox(width: 48.w),
        Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 280.w),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
                decoration: BoxDecoration(
                  color: colors.primary500,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.r),
                    topRight: Radius.circular(16.r),
                    bottomLeft: Radius.circular(16.r),
                    bottomRight: Radius.circular(4.r),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: colors.primary500.withValues(alpha: 0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Text(
                  text,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    height: 1.4,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _BotMessage extends StatelessWidget {
  final String text;
  final FaqCategory category;
  final CustomColorSet colors;

  const _BotMessage({
    required this.text,
    required this.category,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 38.w,
          height: 38.w,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                colors.primary500,
                colors.primary500.withValues(alpha: 0.7),
              ],
            ),
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: colors.primary500.withValues(alpha: 0.25),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Icon(
            Icons.auto_awesome_rounded,
            color: Colors.white,
            size: 20.sp,
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: Container(
            padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 14.h),
            decoration: BoxDecoration(
              color: colors.shade0,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(4.r),
                topRight: Radius.circular(16.r),
                bottomLeft: Radius.circular(16.r),
                bottomRight: Radius.circular(16.r),
              ),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 4),
                  blurRadius: 14,
                  color: Colors.black.withValues(alpha: 0.05),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'UstaBot',
                      style: TextStyle(
                        color: colors.primary500,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.2,
                      ),
                    ),
                    SizedBox(width: 6.w),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 5.w,
                        vertical: 1.h,
                      ),
                      decoration: BoxDecoration(
                        color: colors.primary500.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Text(
                        'AI',
                        style: TextStyle(
                          color: colors.primary500,
                          fontSize: 8.sp,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 6.w,
                        vertical: 2.h,
                      ),
                      decoration: BoxDecoration(
                        color: category.color.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            category.icon,
                            color: category.color,
                            size: 10.sp,
                          ),
                          SizedBox(width: 3.w),
                          Text(
                            category.nameKey.tr(),
                            style: TextStyle(
                              color: category.color,
                              fontSize: 9.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Gap(10.h),
                _FormattedAnswer(text: text, colors: colors),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _FormattedAnswer extends StatelessWidget {
  final String text;
  final CustomColorSet colors;

  const _FormattedAnswer({required this.text, required this.colors});

  @override
  Widget build(BuildContext context) {
    final lines = text.split('\n');
    final widgets = <Widget>[];
    for (var i = 0; i < lines.length; i++) {
      final line = lines[i].trim();
      if (line.isEmpty) {
        if (widgets.isNotEmpty) widgets.add(SizedBox(height: 8.h));
        continue;
      }
      widgets.add(_buildLine(line));
      if (i < lines.length - 1) widgets.add(SizedBox(height: 4.h));
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets,
    );
  }

  Widget _buildLine(String line) {
    final numberedMatch = RegExp(r'^(\d+)\.\s+(.*)').firstMatch(line);
    if (numberedMatch != null) {
      return Padding(
        padding: EdgeInsets.only(left: 2.w, top: 2.h, bottom: 2.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 22.w,
              height: 22.w,
              margin: EdgeInsets.only(top: 2.h),
              decoration: BoxDecoration(
                color: colors.primary500.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(7.r),
              ),
              alignment: Alignment.center,
              child: Text(
                numberedMatch.group(1)!,
                style: TextStyle(
                  color: colors.primary500,
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: _RichLineText(
                text: numberedMatch.group(2)!,
                colors: colors,
              ),
            ),
          ],
        ),
      );
    }
    if (line.startsWith('• ')) {
      return Padding(
        padding: EdgeInsets.only(left: 4.w, top: 2.h, bottom: 2.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 8.h),
              child: Container(
                width: 5.w,
                height: 5.w,
                decoration: BoxDecoration(
                  color: colors.primary500,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: _RichLineText(text: line.substring(2), colors: colors),
            ),
          ],
        ),
      );
    }
    return _RichLineText(text: line, colors: colors);
  }
}

class _RichLineText extends StatelessWidget {
  final String text;
  final CustomColorSet colors;

  const _RichLineText({required this.text, required this.colors});

  @override
  Widget build(BuildContext context) {
    final spans = <TextSpan>[];
    final regex = RegExp(r'\*\*(.*?)\*\*');
    var lastEnd = 0;
    for (final match in regex.allMatches(text)) {
      if (match.start > lastEnd) {
        spans.add(TextSpan(text: text.substring(lastEnd, match.start)));
      }
      spans.add(
        TextSpan(
          text: match.group(1),
          style: TextStyle(fontWeight: FontWeight.w800, color: colors.shade100),
        ),
      );
      lastEnd = match.end;
    }
    if (lastEnd < text.length) {
      spans.add(TextSpan(text: text.substring(lastEnd)));
    }
    return RichText(
      text: TextSpan(
        style: TextStyle(
          color: colors.neutral800,
          fontSize: 13.5.sp,
          fontWeight: FontWeight.w500,
          height: 1.55,
        ),
        children: spans,
      ),
    );
  }
}

class _ContactSupportCard extends StatelessWidget {
  final CustomColorSet colors;

  const _ContactSupportCard({required this.colors});

  @override
  Widget build(BuildContext context) {
    const telegramBlue = Color(0xFF0088CC);
    return AnimationButtonEffect(
      onTap: openSupportTelegram,
      scaleFactor: 0.97,
      child: Container(
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: telegramBlue.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: telegramBlue.withValues(alpha: 0.22)),
        ),
        child: Row(
          children: [
            Container(
              width: 44.w,
              height: 44.w,
              decoration: const BoxDecoration(
                color: telegramBlue,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Icon(Icons.send_rounded, color: Colors.white, size: 20.sp),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ai_chat_contact_support'.tr(),
                    style: TextStyle(
                      color: colors.shade100,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Gap(2.h),
                  Text(
                    'ai_chat_contact_support_hint'.tr(),
                    style: TextStyle(
                      color: colors.neutral600,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      height: 1.35,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 6.w),
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: telegramBlue,
              size: 14.sp,
            ),
          ],
        ),
      ),
    );
  }
}

class _BackToQuestionsButton extends StatelessWidget {
  final CustomColorSet colors;
  final VoidCallback onTap;

  const _BackToQuestionsButton({required this.colors, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return AnimationButtonEffect(
      onTap: onTap,
      scaleFactor: 0.97,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 14.h),
        decoration: BoxDecoration(
          color: colors.shade0,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: colors.neutral200),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.arrow_back_rounded,
              color: colors.neutral700,
              size: 18.sp,
            ),
            SizedBox(width: 8.w),
            Text(
              'ai_chat_back_to_questions'.tr(),
              style: TextStyle(
                color: colors.neutral700,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
