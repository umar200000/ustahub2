part of 'theme.dart';

class CustomColorSet {
  final Color transparent;
  final Color neutral50;
  final Color neutral100;
  final Color neutral200;
  final Color neutral300;
  final Color neutral400;
  final Color neutral500;
  final Color neutral600;
  final Color neutral700;
  final Color neutral800;

  final Color primary500;

  final Color yellow500;

  final Color shade100;
  final Color shade0;

  final Color red500;

  final Color blue500;

  final Color darkMode50;
  final Color darkMode100;
  final Color darkMode200;
  final Color darkMode300;
  final Color darkMode400;
  final Color darkMode500;
  final Color darkMode600;
  final Color darkMode700;
  final Color darkMode800;
  final Color darkMode900;

  final LinearGradient grey;
  final LinearGradient red;
  final LinearGradient texture;
  final LinearGradient mainGradient;

  final List<BoxShadow> shadowS;
  final List<BoxShadow> shadowM;
  final List<BoxShadow> shadowMM;
  final List<BoxShadow> shadowSSSS;
  final List<BoxShadow> shadowMMMM;

  CustomColorSet._({
    required this.transparent,
    //
    required this.neutral50,
    required this.neutral100,
    required this.neutral200,
    required this.neutral300,
    required this.neutral400,
    required this.neutral500,
    required this.neutral600,
    required this.neutral700,
    required this.neutral800,
    //
    required this.primary500,
    //
    required this.yellow500,
    //
    required this.shade100,
    required this.shade0,
    //
    required this.darkMode50,
    required this.darkMode100,
    required this.darkMode200,
    required this.darkMode300,
    required this.darkMode400,
    required this.darkMode500,
    required this.darkMode600,
    required this.darkMode700,
    required this.darkMode800,
    required this.darkMode900,
    //
    required this.grey,
    required this.red,
    required this.texture,
    required this.mainGradient,
    required this.shadowS,
    required this.shadowSSSS,
    required this.shadowM,
    required this.shadowMM,
    required this.shadowMMMM,
    //
    required this.red500,
    //
    required this.blue500,
  });

  factory CustomColorSet._create(CustomThemeMode mode) {
    const transparent = Style.transparent;

    final neutral50 = mode.isLight ? Style.neutral50 : Style.darkMode50;
    final neutral100 = mode.isLight ? Style.neutral100 : Style.darkMode100;
    final neutral200 = mode.isLight ? Style.neutral200 : Style.darkMode200;
    final neutral300 = mode.isLight ? Style.neutral300 : Style.darkMode300;
    final neutral400 = mode.isLight ? Style.neutral400 : Style.darkMode400;
    final neutral500 = mode.isLight ? Style.neutral500 : Style.darkMode500;
    final neutral600 = mode.isLight ? Style.neutral600 : Style.darkMode600;
    final neutral700 = mode.isLight ? Style.neutral700 : Style.darkMode600;
    final neutral800 = mode.isLight ? Style.neutral800 : Style.darkMode800;

    const primary500 = Style.primary500;

    const yellow500 = Style.yellow500;

    const red500 = Style.red500;

    const shade100 = Style.shade100;
    const shade0 = Style.shade0;

    final blue500 = Style.blue500;

    const mainGradient = Style.mainGradient;

    const darkMode50 = Style.darkMode50;
    const darkMode100 = Style.darkMode100;
    const darkMode200 = Style.darkMode200;
    const darkMode300 = Style.darkMode300;
    const darkMode400 = Style.darkMode400;
    const darkMode500 = Style.darkMode500;
    const darkMode600 = Style.darkMode600;
    const darkMode700 = Style.darkMode700;
    const darkMode800 = Style.darkMode800;
    const darkMode900 = Style.darkMode900;

    const grey = Style.grey;
    const red = Style.red;
    const texture = Style.texture;

    const shadowS = Style.shadowS;
    const shadowSSSS = Style.shadowSSSS;
    const shadowM = Style.shadowM;
    const shadowMM = Style.shadowMM;
    const shadowMMMM = Style.shadowMMMM;

    return CustomColorSet._(
      transparent: transparent,
      neutral50: neutral50,
      neutral100: neutral100,
      neutral200: neutral200,
      neutral300: neutral300,
      neutral400: neutral400,
      neutral500: neutral500,
      neutral600: neutral600,
      neutral700: neutral700,
      neutral800: neutral800,
      //
      primary500: primary500,
      //
      yellow500: yellow500,
      //
      shade0: shade0,
      shade100: shade100,
      //
      darkMode50: darkMode50,
      darkMode100: darkMode100,
      darkMode200: darkMode200,
      darkMode300: darkMode300,
      darkMode400: darkMode400,
      darkMode500: darkMode500,
      darkMode600: darkMode600,
      darkMode700: darkMode700,
      darkMode800: darkMode800,
      darkMode900: darkMode900,
      //
      grey: grey,
      red: red,
      texture: texture,
      mainGradient: mainGradient,
      //
      shadowS: shadowS,
      shadowSSSS: shadowSSSS,
      shadowM: shadowM,
      shadowMM: shadowMM,
      shadowMMMM: shadowMMMM,
      //
      red500: red500,
      blue500: blue500,
    );
  }

  static CustomColorSet createOrUpdate(CustomThemeMode mode) {
    return CustomColorSet._create(mode);
  }
}
