import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:app/features/settings/widgets/widgets.dart';
import 'package:app/shared/widgets/widgets.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

@RoutePage()
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeSwitchingArea(
      child: Scaffold(
        body: Column(
          children: [
            WindowBar(),
            Expanded(
              child: FScaffold(
                header: SettingsHeader(),
                footer: SettingsFooter(),
                child: SettingsBase(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
