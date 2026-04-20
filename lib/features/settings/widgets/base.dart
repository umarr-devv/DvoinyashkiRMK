import 'package:app/features/settings/widgets/widgets.dart';
import 'package:flutter/material.dart';

class SettingsBase extends StatelessWidget {
  const SettingsBase({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      padding: const EdgeInsets.only(bottom: 128),
      child: Column(
        spacing: 24,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CashRegisterSelect(),
          AuthorSelect(),
          StoreSelect(),
          SubdivisionSelect(),
          PrinterSelect(),
          ScaleSlider(),
          FontScaleSlider(),
          Row(),
        ],
      ),
    );
  }
}
