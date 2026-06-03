import 'package:app/features/settings/tabs/withdraw_tab.dart';
import 'package:app/features/settings/widgets/printer_groups_settings.dart';
import 'package:app/features/settings/widgets/widgets.dart';
import 'package:flutter/material.dart';

class SettingsBase extends StatelessWidget {
  const SettingsBase({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          TabBar(
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            tabs: [
              Tab(text: 'Основное'),
              Tab(text: 'Выемка'),
              Tab(text: 'Принтеры'),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  padding: const EdgeInsets.only(
                    top: 24,
                    bottom: 128,
                    left: 16,
                    right: 16,
                  ),
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
                ),
                SettingsWithdrawTab(),
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  padding: const EdgeInsets.only(
                    top: 24,
                    bottom: 128,
                    left: 16,
                    right: 16,
                  ),
                  child: PrinterGroupsSettings(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
