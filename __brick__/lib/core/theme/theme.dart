import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

export 'package:{{project_name}}/core/theme/theme_cubit.dart';

final Map<String, ({ThemeData light, ThemeData dark})> appThemes = {
  "MIDNIGHT_BLUE": (
    light: MidnightBlueX.light(),
    dark: MidnightBlueX.dark(),
  ),
  FlexScheme.mandyRed.name: (
    light: MandyRedX.light(),
    dark: MandyRedX.dark(),
  ),
  FlexScheme.wasabi.name: (
    light: WasabiX.light(),
    dark: WasabiX.dark(),
  ),
  FlexScheme.aquaBlue.name: (
    light: AquaBlueX.light(),
    dark: AquaBlueX.dark(),
  ),
  FlexScheme.ebonyClay.name: (
    light: EbonyClayX.light(),
    dark: EbonyClayX.dark(),
  ),
  FlexScheme.rosewood.name: (
    light: RoseWoodX.light(),
    dark: RoseWoodX.dark(),
  ),
};

extension MidnightBlueX on ThemeData {
  static ThemeData light() {
    return FlexThemeData.light(
      useMaterial3: true,
      colors: const FlexSchemeColor(
        primary: Color(0xFF00296B),
        primaryContainer: Color(0xFFA0C2ED),
        secondary: Color(0xFFD26900),
        secondaryContainer: Color(0xFFFFD270),
        tertiary: Color(0xFF5C5C95),
        tertiaryContainer: Color(0xFFC8DBF8),
      ),
      appBarElevation: 0.5,
      visualDensity: VisualDensity.standard,
      fontFamily: GoogleFonts.notoSans().fontFamily,
      // We use the nicer Material-3 Typography in both M2 and M3 mode.
      typography: Typography.material2021(platform: defaultTargetPlatform),
    );
  }

  static ThemeData dark() {
    return FlexThemeData.dark(
      useMaterial3: true,
      colors: const FlexSchemeColor(
        primary: Color(0xFFB1CFF5),
        primaryContainer: Color(0xFF3873BA),
        secondary: Color(0xFFFFD270),
        secondaryContainer: Color(0xFFD26900),
        tertiary: Color(0xFFC9CBFC),
        tertiaryContainer: Color(0xFF535393),
      ),
      appBarElevation: 0.5,
      visualDensity: VisualDensity.standard,
      fontFamily: GoogleFonts.notoSans().fontFamily,
      // We use the nicer Material-3 Typography in both M2 and M3 mode.
      typography: Typography.material2021(platform: defaultTargetPlatform),
    );
  }
}

extension MandyRedX on ThemeData {
  static ThemeData light() {
    return FlexThemeData.light(
      useMaterial3: true,
      colors: FlexColor.mandyRed.light,
      appBarElevation: 0.5,
      visualDensity: VisualDensity.standard,
      fontFamily: GoogleFonts.poppins().fontFamily,
      // We use the nicer Material-3 Typography in both M2 and M3 mode.
      typography: Typography.material2021(platform: defaultTargetPlatform),
    );
  }

  static ThemeData dark() {
    return FlexThemeData.dark(
      useMaterial3: true,
      colors: FlexColor.mandyRed.dark,
      appBarElevation: 0.5,
      visualDensity: VisualDensity.standard,
      fontFamily: GoogleFonts.poppins().fontFamily,
      // We use the nicer Material-3 Typography in both M2 and M3 mode.
      typography: Typography.material2021(platform: defaultTargetPlatform),
    );
  }
}

extension WasabiX on ThemeData {
  static ThemeData light() {
    return FlexThemeData.light(
      useMaterial3: true,
      colors: FlexColor.wasabi.light,
      appBarElevation: 0.5,
      visualDensity: VisualDensity.standard,
      fontFamily: GoogleFonts.montserrat().fontFamily,
      // We use the nicer Material-3 Typography in both M2 and M3 mode.
      typography: Typography.material2021(platform: defaultTargetPlatform),
    );
  }

  static ThemeData dark() {
    return FlexThemeData.dark(
      useMaterial3: true,
      colors: FlexColor.wasabi.dark,
      appBarElevation: 0.5,
      visualDensity: VisualDensity.standard,
      fontFamily: GoogleFonts.montserrat().fontFamily,
      // We use the nicer Material-3 Typography in both M2 and M3 mode.
      typography: Typography.material2021(platform: defaultTargetPlatform),
    );
  }
}

extension AquaBlueX on ThemeData {
  static ThemeData light() {
    return FlexThemeData.light(
      useMaterial3: true,
      colors: FlexColor.aquaBlue.light,
      appBarElevation: 0.5,
      visualDensity: VisualDensity.standard,
      fontFamily: GoogleFonts.montserrat().fontFamily,
      // We use the nicer Material-3 Typography in both M2 and M3 mode.
      typography: Typography.material2021(platform: defaultTargetPlatform),
    );
  }

  static ThemeData dark() {
    return FlexThemeData.dark(
      useMaterial3: true,
      colors: FlexColor.aquaBlue.dark,
      appBarElevation: 0.5,
      visualDensity: VisualDensity.standard,
      fontFamily: GoogleFonts.montserrat().fontFamily,
      // We use the nicer Material-3 Typography in both M2 and M3 mode.
      typography: Typography.material2021(platform: defaultTargetPlatform),
    );
  }
}

extension EbonyClayX on ThemeData {
  static ThemeData light() {
    return FlexThemeData.light(
      useMaterial3: true,
      colors: FlexColor.ebonyClay.light,
      appBarElevation: 0.5,
      visualDensity: VisualDensity.standard,
      fontFamily: GoogleFonts.montserrat().fontFamily,
      // We use the nicer Material-3 Typography in both M2 and M3 mode.
      typography: Typography.material2021(platform: defaultTargetPlatform),
    );
  }

  static ThemeData dark() {
    return FlexThemeData.dark(
      useMaterial3: true,
      colors: FlexColor.ebonyClay.dark,
      appBarElevation: 0.5,
      visualDensity: VisualDensity.standard,
      fontFamily: GoogleFonts.montserrat().fontFamily,
      // We use the nicer Material-3 Typography in both M2 and M3 mode.
      typography: Typography.material2021(platform: defaultTargetPlatform),
    );
  }
}

extension RoseWoodX on ThemeData {
  static ThemeData light() {
    return FlexThemeData.light(
      useMaterial3: true,
      colors: FlexColor.rosewood.light,
      appBarElevation: 0.5,
      visualDensity: VisualDensity.standard,
      fontFamily: GoogleFonts.montserrat().fontFamily,
      // We use the nicer Material-3 Typography in both M2 and M3 mode.
      typography: Typography.material2021(platform: defaultTargetPlatform),
    );
  }

  static ThemeData dark() {
    return FlexThemeData.dark(
      useMaterial3: true,
      colors: FlexColor.rosewood.dark,
      appBarElevation: 0.5,
      visualDensity: VisualDensity.standard,
      fontFamily: GoogleFonts.montserrat().fontFamily,
      // We use the nicer Material-3 Typography in both M2 and M3 mode.
      typography: Typography.material2021(platform: defaultTargetPlatform),
    );
  }
}
