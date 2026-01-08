import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:app/features/auth/widgets/widgets.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeSwitchingArea(
      child: Scaffold(
        body: Stack(
          children: [
            AuthActions(),
            Center(
              child: SizedBox(
                width: 420,
                child: Column(
                  spacing: 24,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [AuthLogo(), AuthForm(), AuthRules()],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
