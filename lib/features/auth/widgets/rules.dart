import 'package:app/shared/theme/theme.dart';
import 'package:flutter/material.dart';

class AuthRules extends StatelessWidget {
  const AuthRules({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w400,
            color: theme.custom.mutedForeground,
          ),
          children: [
            TextSpan(text: 'Авторизовываясь вы автоматически принимаете '),
            TextSpan(
              text: 'условия соглашения ',
              style: TextStyle(color: theme.custom.accent),
            ),
            TextSpan(text: 'и '),
            TextSpan(
              text: 'конфеденциальности',
              style: TextStyle(color: theme.custom.accent),
            ),
          ],
        ),
      ),
    );
  }
}
