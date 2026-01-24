import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forui/forui.dart';

class CustomThemeData {
  CustomThemeData({required this.brightness});

  final Brightness brightness;

  final font = 'Manrope';

  Color by({required Color light, required Color dark}) {
    return brightness == Brightness.light ? light : dark;
  }

  Color get accent => Color(0xffa67dd9);

  Color get secondaryAccent =>
      by(light: Color(0xff948FFF), dark: Color(0xFFA19CFF));

  Color get transparent => Color(0x00000000);

  Color get barrier => by(light: Color(0x33000000), dark: Color(0x7A000000));

  Color get background => by(light: Color(0xFFFFFFFF), dark: Color(0xFF09090B));

  Color get foreground => by(light: Color(0xFF09090B), dark: Color(0xFFFAFAFA));

  Color get primary => by(light: Color(0xFF18181B), dark: Color(0xFFFAFAFA));

  Color get primaryForeground =>
      by(light: Color(0xFFFAFAFA), dark: Color(0xFF18181B));

  Color get secondary => by(light: Color(0xFFF4F4F5), dark: Color(0xFF27272A));

  Color get secondaryForeground =>
      by(light: Color(0xC018181B), dark: Color(0xC0FAFAFA));

  Color get muted => by(light: Color(0xFFF4F4F5), dark: Color(0xFF27272A));

  Color get mutedForeground =>
      by(light: Color(0xFF71717A), dark: Color(0xFFA1A1AA));

  Color get destructive =>
      by(light: Color(0xFFEF4444), dark: Color(0xFF7F1D1D));

  Color get destructiveForeground =>
      by(light: Color(0xFFFAFAFA), dark: Color(0xFFFAFAFA));

  Color get error => by(light: Color(0xFFEF4444), dark: Color(0xFF7F1D1D));

  Color get errorForeground =>
      by(light: Color(0xFFFAFAFA), dark: Color(0xFFFAFAFA));

  Color get success => by(light: Color(0xFF16A34A), dark: Color(0xFF007e33));

  Color get info => by(light: Color(0xff0d6efd), dark: Color(0xff0a58ca));

  Color get actionForeground =>
      by(light: Color(0xFFFAFAFA), dark: Color(0xFFFAFAFA));

  Color get destructiveTextForeground => Color(0xFFEF4444);

  Color get border => by(light: Color(0xFFE4E4E7), dark: Color(0xFF27272A));

  Color get textSelect => foreground.withValues(alpha: 0.075);

  Color get rowOddColor => background.withValues(alpha: 0.5);

  Color get rowEvenColor => muted.withValues(alpha: 0.75);

  Color get gold => Color(0xffe8b904);

  Color get silver => Color(0xffc6c6c6);

  Color get bronze => Color(0xffd08d4c);

  ThemeData toTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      primaryColor: primary,
      scaffoldBackgroundColor: background,
      fontFamily: font,
      textSelectionTheme: TextSelectionThemeData(selectionColor: textSelect),
      dataTableTheme: DataTableThemeData(
        headingTextStyle: TextStyle(
          color: mutedForeground,
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
        dataTextStyle: TextStyle(
          color: foreground,
          fontSize: 15,
          fontWeight: FontWeight.w400,
        ),
        dividerThickness: 0,
      ),
      dividerColor: border,
    );
  }

  FThemeData toFTheme() {
    return FThemeData(
      typography: FTypography(defaultFontFamily: font),
      colors: FColors(
        brightness: brightness,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        barrier: barrier,
        background: background,
        foreground: foreground,
        primary: primary,
        primaryForeground: primaryForeground,
        secondary: secondary,
        secondaryForeground: secondaryForeground,
        muted: muted,
        mutedForeground: mutedForeground,
        destructive: destructive,
        destructiveForeground: destructiveForeground,
        error: error,
        errorForeground: errorForeground,
        border: border,
      ),
    );
  }
}

extension ThemeExtension on ThemeData {
  CustomThemeData get custom => CustomThemeData(brightness: brightness);
}

final lightTheme = CustomThemeData(brightness: Brightness.light);
final darkTheme = CustomThemeData(brightness: Brightness.dark);
