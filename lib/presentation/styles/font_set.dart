part of 'theme.dart';

class FontSet {
  /// Headline 01
  final TextStyle headingH1Regular;
  final TextStyle headingH1Medium;
  final TextStyle headingH1SemiBold;
  final TextStyle headingH1Bold;

  /// Headline 02
  final TextStyle headingH2Regular;
  final TextStyle headingH2Medium;
  final TextStyle headingH2SemiBold;
  final TextStyle headingH2Bold;

  /// Headline 03
  final TextStyle headingH3Regular;
  final TextStyle headingH3Medium;
  final TextStyle headingH3SemiBold;
  final TextStyle headingH3Bold;

  /// Headline 04
  final TextStyle headingH4Regular;
  final TextStyle headingH4Medium;
  final TextStyle headingH4SemiBold;
  final TextStyle headingH4Bold;

  /// Headline 05
  final TextStyle headingH5Regular;
  final TextStyle headingH5Medium;
  final TextStyle headingH5SemiBold;
  final TextStyle headingH5Bold;

  /// Headline 06
  final TextStyle headingH6Regular;
  final TextStyle headingH6Medium;
  final TextStyle headingH6SemiBold;
  final TextStyle headingH6Bold;

  /// Subheading
  final TextStyle subheadingRegular;
  final TextStyle subheadingMedium;
  final TextStyle subheadingSemiBold;
  final TextStyle subheadingBold;

  /// Paragraph 01
  final TextStyle paragraphP1Regular;
  final TextStyle paragraphP1Medium;
  final TextStyle paragraphP1SemiBold;
  final TextStyle paragraphP1Bold;

  /// Paragraph 02
  final TextStyle paragraphP2Regular;
  final TextStyle paragraphP2Medium;
  final TextStyle paragraphP2SemiBold;
  final TextStyle paragraphP2Bold;

  /// Paragraph 03
  final TextStyle paragraphP3Regular;
  final TextStyle paragraphP3Medium;
  final TextStyle paragraphP3SemiBold;
  final TextStyle paragraphP3Bold;

  /// Caption
  final TextStyle captionRegular;
  final TextStyle captionMedium;
  final TextStyle captionSemiBold;
  final TextStyle captionBold;

  /// Footer
  final TextStyle footerRegular;
  final TextStyle footerMedium;
  final TextStyle footerSemiBold;
  final TextStyle footerBold;

  /// Custom Size 18 Text
  final TextStyle textSize18Regular;
  final TextStyle textSize18Medium;
  final TextStyle textSize18SemiBold;
  final TextStyle textSize18Bold;

  FontSet({
    required this.headingH1Regular,
    required this.headingH1Medium,
    required this.headingH1SemiBold,
    required this.headingH1Bold,
    required this.headingH2Regular,
    required this.headingH2Medium,
    required this.headingH2SemiBold,
    required this.headingH2Bold,
    required this.headingH3Regular,
    required this.headingH3Medium,
    required this.headingH3SemiBold,
    required this.headingH3Bold,
    required this.headingH4Regular,
    required this.headingH4Medium,
    required this.headingH4SemiBold,
    required this.headingH4Bold,
    required this.headingH5Regular,
    required this.headingH5Medium,
    required this.headingH5SemiBold,
    required this.headingH5Bold,
    required this.headingH6Regular,
    required this.headingH6Medium,
    required this.headingH6SemiBold,
    required this.headingH6Bold,
    required this.subheadingRegular,
    required this.subheadingMedium,
    required this.subheadingSemiBold,
    required this.subheadingBold,
    required this.paragraphP1Regular,
    required this.paragraphP1Medium,
    required this.paragraphP1SemiBold,
    required this.paragraphP1Bold,
    required this.paragraphP2Regular,
    required this.paragraphP2Medium,
    required this.paragraphP2SemiBold,
    required this.paragraphP2Bold,
    required this.paragraphP3Regular,
    required this.paragraphP3Medium,
    required this.paragraphP3SemiBold,
    required this.paragraphP3Bold,
    required this.captionRegular,
    required this.captionMedium,
    required this.captionSemiBold,
    required this.captionBold,
    required this.footerRegular,
    required this.footerMedium,
    required this.footerSemiBold,
    required this.footerBold,
    required this.textSize18Regular,
    required this.textSize18Medium,
    required this.textSize18SemiBold,
    required this.textSize18Bold,
  });

  static FontSet createOrUpdate(CustomColorSet colors) {
    return FontSet(
      // Headline 01 Variants
      headingH1Regular: Style.regular12(size: 48.sp),
      headingH1Medium: Style.medium14(size: 48.sp),
      headingH1SemiBold: Style.semiBold14(size: 48.sp),
      headingH1Bold: Style.bold20(size: 48.sp),

      // Headline 02 Variants
      headingH2Regular: Style.regular24(size: 40.sp),
      headingH2Medium: Style.medium20(size: 40.sp),
      headingH2SemiBold: Style.semiBold16(size: 40.sp),
      headingH2Bold: Style.bold20(size: 40.sp),

      // Headline 03 Variants
      headingH3Regular: Style.regular12(size: 32.sp),
      headingH3Medium: Style.medium14(size: 32.sp),
      headingH3SemiBold: Style.semiBold14(size: 32.sp),
      headingH3Bold: Style.bold16(size: 32.sp),

      // Headline 04 Variants
      headingH4Regular: Style.regular12(size: 28.sp),
      headingH4Medium: Style.medium14(size: 28.sp),
      headingH4SemiBold: Style.semiBold14(size: 28.sp),
      headingH4Bold: Style.bold16(size: 28.sp),

      // Headline 05 Variants
      headingH5Regular: Style.regular24(size: 24.sp),
      headingH5Medium: Style.medium14(size: 24.sp),
      headingH5SemiBold: Style.semiBold14(size: 24.sp),
      headingH5Bold: Style.bold16(size: 24.sp),

      // Headline 06 Variants
      headingH6Regular: Style.regular12(size: 20.sp),
      headingH6Medium: Style.medium20(size: 20.sp),
      headingH6SemiBold: Style.semiBold14(size: 20.sp),
      headingH6Bold: Style.bold20(size: 20.sp),

      // Subheading Variants
      subheadingRegular: Style.regular16(size: 18.sp),
      subheadingMedium: Style.medium16(size: 18.sp),
      subheadingSemiBold: Style.semiBold16(size: 18.sp),
      subheadingBold: Style.bold16(size: 18.sp),

      // Paragraph 01 Variants
      paragraphP1Regular: Style.regular16(size: 16.sp),
      paragraphP1Medium: Style.medium16(size: 16.sp),
      paragraphP1SemiBold: Style.semiBold16(size: 16.sp),
      paragraphP1Bold: Style.bold16(size: 16.sp),

      // Paragraph 02 Variants
      paragraphP2Regular: Style.regular14(size: 14.sp),
      paragraphP2Medium: Style.medium14(size: 14.sp),
      paragraphP2SemiBold: Style.semiBold14(size: 14.sp),
      paragraphP2Bold: Style.bold16(size: 14.sp),

      // Paragraph 02 Variants
      paragraphP3Regular: Style.regular14(size: 12.sp),
      paragraphP3Medium: Style.medium14(size: 12.sp),
      paragraphP3SemiBold: Style.semiBold14(size: 12.sp),
      paragraphP3Bold: Style.bold16(size: 12.sp),

      // Caption Variants
      captionRegular: Style.regular12(size: 10.sp),
      captionMedium: Style.medium14(size: 10.sp),
      captionSemiBold: Style.semiBold14(size: 10.sp),
      captionBold: Style.bold16(size: 10.sp),

      // Footer Variants
      footerRegular: Style.regular12(size: 8.sp),
      footerMedium: Style.medium14(size: 8.sp),
      footerSemiBold: Style.semiBold14(size: 8.sp),
      footerBold: Style.bold16(size: 8.sp),

      // Custom Size 18 Variants
      textSize18Regular: Style.regular12(size: 18.sp),
      textSize18Medium: Style.medium14(size: 18.sp),
      textSize18SemiBold: Style.semiBold14(size: 18.sp),
      textSize18Bold: Style.bold16(size: 18.sp),
    );
  }
}
