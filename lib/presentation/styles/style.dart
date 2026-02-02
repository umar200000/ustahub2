import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class Style {
  Style._();

  // NEUTRAL.
  static const Color neutral50 = Color(0xFFE8ECF3);
  static const Color neutral100 = Color.fromARGB(255, 244, 244, 244);
  static const Color neutral200 = Color(0xFFEAEAEA);
  static final Color neutral300 = const Color(0xFFFFFFFF).withOpacity(.86);
  static final Color neutral400 = const Color(0xFFFFFFFF).withOpacity(.4);
  static final Color neutral500 = const Color(0xFFA0A0A0);
  static const Color neutral600 = Color(0xFF5A5A5A);
  static const Color neutral700 = Color(0xFf5A5858);
  static final Color neutral800 = const Color(0xFF000000).withOpacity(.5);

  static const Color primary500 = Color(0xFF01CC47);

  static const Color yellow500 = Color(0xFFFFC038);

  static const Color red500 = Color(0xFFFF3300);

  static const Color blue500 = Color(0xFF2986FF);

  static const Color shade100 = Color(0xFF000000);
  static const Color shade0 = Color(0xFFFFFFFF);

  static const Color darkMode50 = Color(0xFF3D3E48);
  static const Color darkMode100 = Color(0xFF3A3B45);
  static const Color darkMode200 = Color(0xFF393944);
  static const Color darkMode300 = Color(0xFF343540);
  static const Color darkMode400 = Color(0xFF31323D);
  static const Color darkMode500 = Color(0xFF2D2E39);
  static const Color darkMode600 = Color(0xFF2A2B36);
  static const Color darkMode700 = Color(0xFF282934);
  static const Color darkMode800 = Color(0xFF242530);
  static const Color darkMode900 = Color(0xFF181925);
  static const Color transparent = Colors.transparent;

  static const LinearGradient grey = LinearGradient(
    colors: [Color(0xFF313131), Color(0xFF1F1F20)],
    begin: Alignment(.99, 1.1),
    end: Alignment(.02, -.1),
  );

  static const LinearGradient red = LinearGradient(
    colors: [Color(0xFFCE2F2B), Color(0xFFA02924)],
    begin: Alignment(.97, .03),
    end: Alignment(.06, .98),
  );

  static const mainGradient = LinearGradient(
    begin: Alignment(-0.05, -1.00),
    end: Alignment(0.05, 1),
    colors: [Color(0xff1E88E5), Color(0xff0D47A1)],
  );

  static const LinearGradient texture = LinearGradient(
    colors: [Color(0xFFFFFFFF), Color(0xFF1C0C07)],
    begin: Alignment(.57, 0),
    end: Alignment(.57, 1.87),
  );

  static const BoxShadow blueIconShadow = BoxShadow(
    color: Color(0x20696A6F),
    blurRadius: 12,
    spreadRadius: 2,
  );

  static const BoxShadow bottomShadow = BoxShadow(
    color: Color(0x20696A6F),
    blurRadius: 4,
    spreadRadius: 2,
    offset: Offset(0.0, 4.0),
  );

  static TextStyle regular24({double size = 24, Color color = shade100}) {
    return TextStyle(
      fontSize: size,
      color: color,
      fontWeight: FontWeight.w400,
      fontFamily: 'BalsamiqSans',
    );
  }

  static const List<BoxShadow> shadowS = [
    BoxShadow(
      offset: Offset(0, 6.43),
      blurRadius: 33.56,
      spreadRadius: 0,
      color: Color(0x12141415),
    ),
  ];

  static const List<BoxShadow> shadowSSSS = [
    BoxShadow(
      offset: Offset(0, 1),
      blurRadius: 1,
      spreadRadius: 1,
      color: Color(0x03141415),
    ),
    BoxShadow(
      offset: Offset(0, 2.67),
      blurRadius: 13.94,
      spreadRadius: 0,
      color: Color(0x03141415),
    ),
    BoxShadow(
      offset: Offset(0, 6.43),
      blurRadius: 33.56,
      spreadRadius: 0,
      color: Color(0x02141415),
    ),
    BoxShadow(
      offset: Offset(0, 18.95),
      blurRadius: 100,
      spreadRadius: 0,
      color: Color(0x01141415),
    ),
  ];

  static const List<BoxShadow> shadowM = [
    BoxShadow(
      offset: Offset(0, .37),
      blurRadius: 2.04,
      spreadRadius: 0,
      color: Color.fromARGB(8, 20, 20, 21),
    ),
    BoxShadow(
      offset: Offset(0, 2.67),
      blurRadius: 13.94,
      spreadRadius: 0,
      color: Color(0x12141415),
    ),
  ];

  static const List<BoxShadow> shadowMM = [
    BoxShadow(
      offset: Offset(0, .97),
      blurRadius: 5.04,
      spreadRadius: 0,
      color: Color.fromARGB(35, 20, 20, 21),
    ),
    BoxShadow(
      offset: Offset(0, 2.67),
      blurRadius: 13.94,
      spreadRadius: 0,
      color: Color(0x06141415),
    ),
  ];

  static const List<BoxShadow> shadowMMMM = [
    BoxShadow(
      offset: Offset(0, .97),
      blurRadius: 5.04,
      spreadRadius: 0,
      color: Color(0x08141415),
    ),
    BoxShadow(
      offset: Offset(0, 2.67),
      blurRadius: 13.94,
      spreadRadius: 0,
      color: Color(0x06141415),
    ),
    BoxShadow(
      offset: Offset(0, 6.43),
      blurRadius: 33.56,
      spreadRadius: 0,
      color: Color(0x04141415),
    ),
    BoxShadow(
      offset: Offset(0, 18.95),
      blurRadius: 111.32,
      spreadRadius: 0,
      color: Color(0x03141415),
    ),
  ];

  static TextStyle regular16({double size = 16, Color color = shade100}) {
    return GoogleFonts.balsamiqSans(
      fontSize: size,
      color: color,
      fontWeight: FontWeight.w400,
      letterSpacing: -0.24,
    );
  }

  static TextStyle regular14({double size = 14, Color color = shade100}) {
    return GoogleFonts.balsamiqSans(
      fontSize: size,
      color: color,
      fontWeight: FontWeight.w400,
      letterSpacing: -0.24,
    );
  }

  static TextStyle regular12({double size = 12, Color color = shade100}) {
    return GoogleFonts.balsamiqSans(
      fontSize: size,
      color: color,
      fontWeight: FontWeight.w400,
      letterSpacing: -0.24,
    );
  }

  static TextStyle medium20({double size = 20, Color color = shade100}) {
    return GoogleFonts.balsamiqSans(
      fontSize: size,
      color: color,
      fontWeight: FontWeight.w500,
      letterSpacing: -0.24,
    );
  }

  static TextStyle medium16({double size = 16, Color color = shade100}) {
    return GoogleFonts.balsamiqSans(
      fontSize: size,
      color: color,
      fontWeight: FontWeight.w500,
      letterSpacing: -0.24,
    );
  }

  static TextStyle medium14({double size = 14, Color color = shade100}) {
    return GoogleFonts.balsamiqSans(
      fontSize: size,
      color: color,
      fontWeight: FontWeight.w500,
      letterSpacing: -0.24,
    );
  }

  static TextStyle semiBold16({double size = 16, Color color = shade100}) {
    return GoogleFonts.balsamiqSans(
      fontSize: size,
      color: color,
      fontWeight: FontWeight.w600,
      letterSpacing: -0.84,
      height: 1.1,
    );
  }

  static TextStyle semiBold14({double size = 14, Color color = shade100}) {
    return GoogleFonts.balsamiqSans(
      fontSize: size,
      color: color,
      fontWeight: FontWeight.w600,
      letterSpacing: -0.24,
    );
  }

  static TextStyle bold20({double size = 20, Color color = shade100}) {
    return GoogleFonts.balsamiqSans(
      fontSize: size,
      color: color,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.24,
    );
  }

  static TextStyle bold16({double size = 16, Color color = shade100}) {
    return GoogleFonts.balsamiqSans(
      fontSize: size,
      color: color,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.24,
    );
  }

  static const SystemUiOverlayStyle light = SystemUiOverlayStyle(
    systemNavigationBarColor: shade0,
    systemNavigationBarIconBrightness: Brightness.light,
    statusBarIconBrightness: Brightness.light,
    statusBarBrightness: Brightness.dark,
  );

  /// System overlays should be drawn with a dark color. Intended for
  /// applications with a light background.
  static const SystemUiOverlayStyle dark = SystemUiOverlayStyle(
    systemNavigationBarColor: shade0,
    systemNavigationBarIconBrightness: Brightness.light,
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.light,
  );
}
