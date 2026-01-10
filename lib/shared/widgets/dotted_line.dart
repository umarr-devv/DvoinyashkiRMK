import 'package:app/shared/theme/theme.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';

class CustomDottedLine extends StatelessWidget {
  const CustomDottedLine({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
      child: DottedLine(
        lineThickness: 1,
        dashGapLength: 4,
        dashLength: 8,
        dashColor: theme.custom.border,
      ),
    );
  }
}
