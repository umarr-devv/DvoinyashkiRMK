import 'package:app/shared/icons/icons.dart';
import 'package:app/shared/theme/theme.dart';
import 'package:flutter/material.dart';

class AuthLogo extends StatelessWidget {
  const AuthLogo({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      spacing: 12,
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomIcons.invert_icon(size: 48),
        Transform.translate(
          offset: Offset(0, 6),
          child: CustomIcons.logo(size: 32, color: theme.custom.foreground),
        ),
      ],
    );
  }
}
