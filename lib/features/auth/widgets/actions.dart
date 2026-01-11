import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:app/shared/theme/theme.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

class AuthActions extends StatelessWidget {
  const AuthActions({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.only(top: 12, right: 16),
      child: Row(
        spacing: 12,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ThemeSwitcher(
            builder: (context) {
              final isDarkTheme = theme.brightness == Brightness.dark;
              return FButton.icon(
                onPress: () {
                  ThemeSwitcher.of(context).changeTheme(
                    theme: isDarkTheme
                        ? lightTheme.toTheme()
                        : darkTheme.toTheme(),
                    isReversed: !isDarkTheme,
                  );
                },
                child: Icon(
                  isDarkTheme
                      ? FluentIcons.weather_moon_24_filled
                      : FluentIcons.weather_sunny_24_filled,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
