import 'package:flutter/material.dart';

class CustomThemeData {
  CustomThemeData({required this.brightness});

  final Brightness brightness;

  final font = 'Manrope';

  Color by({required Color light, required Color dark}) {
    return brightness == Brightness.light ? light : dark;
  }

  Color get primaryColor => Color(0xff6200ee);

  Color get primaryBackground {
    return by(light: const Color(0xFFffffff), dark: const Color(0xFF000000));
  }

  Color get secondaryBackground {
    return by(light: const Color(0xFFeeeff0), dark: const Color(0xFF181818));
  }

  Color get primaryForeground {
    return by(light: const Color(0xFF000000), dark: const Color(0xFFFFFFFF));
  }

  Color get secondaryForeground => primaryForeground.withValues(alpha: 0.75);

  ThemeData toTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      primaryColor: primaryBackground,
      scaffoldBackgroundColor: secondaryBackground,
      fontFamily: font,
      appBarTheme: AppBarTheme(
        backgroundColor: primaryBackground,
        surfaceTintColor: primaryBackground,
        iconTheme: IconThemeData(color: primaryForeground),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: primaryBackground,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
      ),
      colorScheme: ColorScheme.fromSeed(
        brightness: brightness,
        seedColor: primaryColor,
        primary: primaryBackground,
        onPrimary: primaryForeground,
        secondary: secondaryBackground,
        onSecondary: secondaryForeground,
        surface: secondaryBackground,
        onSurface: primaryForeground,
      ),
      textTheme: TextTheme(
        titleLarge: TextStyle(
          fontFamily: font,
          color: primaryForeground,
          fontWeight: FontWeight.w600,
          fontSize: 18,
        ),
        titleMedium: TextStyle(
          fontFamily: font,
          color: primaryForeground,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
        titleSmall: TextStyle(
          fontFamily: font,
          color: primaryForeground,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }
}

extension ThemeExtension on ThemeData {
  CustomThemeData get custom => CustomThemeData(brightness: brightness);
}

final lightTheme = CustomThemeData(brightness: Brightness.light).toTheme();
final darkTheme = CustomThemeData(brightness: Brightness.dark).toTheme();
