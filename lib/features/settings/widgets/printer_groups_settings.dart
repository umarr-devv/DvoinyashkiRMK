import 'package:app/blocs/blocs.dart';
import 'package:app/models/group.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';
import 'package:printing/printing.dart';

/// Widget for assigning a printer to each kitchen production group.
///
/// [SettingsState.printerGroups] is `Map<String, GroupScheme>` where:
/// - key   = [GroupScheme.refKey] of the kitchen group
/// - value = [GroupScheme] that encodes the selected printer
///           (refKey = printer.url, name = printer.name, groupKey = null)
///
/// A single printer can be assigned to multiple groups.
class PrinterGroupsSettings extends StatelessWidget {
  const PrinterGroupsSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Printer>>(
      future: Printing.listPrinters(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox(
            height: 48,
            child: Align(
              alignment: Alignment.centerLeft,
              child: CircularProgressIndicator.adaptive(),
            ),
          );
        }

        final printers = snapshot.data!;

        return BlocBuilder<DataCubit, DataState>(
          builder: (context, dataState) {
            return BlocBuilder<SettingsCubit, SettingsState>(
              builder: (context, settingsState) {
                final cubit = context.read<SettingsCubit>();
                final groups = dataState.groups;
                final printerGroups = settingsState.printerGroups ?? {};

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 16,
                  children: [
                    _PrinterGroupsHeader(),
                    if (groups.isEmpty)
                      Text(
                        'Группы кухни не загружены',
                        style: Theme.of(context).textTheme.bodySmall,
                      )
                    else
                      ...groups.map(
                        (group) => _GroupPrinterRow(
                          group: group,
                          printers: printers,
                          selectedPrinter: printerGroups[group.refKey],
                          onChanged: (printer) {
                            final updated = Map<String, GroupScheme>.from(
                              printerGroups,
                            );
                            if (printer != null) {
                              updated[group.refKey] = GroupScheme(
                                refKey: printer.url,
                                name: printer.name,
                                groupKey: null,
                              );
                            } else {
                              updated.remove(group.refKey);
                            }
                            cubit.setSettings(printerGroups: updated);
                          },
                          onClear: () {
                            final updated = Map<String, GroupScheme>.from(
                              printerGroups,
                            )..remove(group.refKey);
                            cubit.setSettings(printerGroups: updated);
                          },
                        ),
                      ),
                  ],
                );
              },
            );
          },
        );
      },
    );
  }
}

class _PrinterGroupsHeader extends StatelessWidget {
  const _PrinterGroupsHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 4,
      children: [
        Text(
          'Принтеры для кухни',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        Text(
          'Назначьте принтер каждой группе кухни. '
          'Один принтер может обслуживать несколько групп.',
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}

class _GroupPrinterRow extends StatelessWidget {
  const _GroupPrinterRow({
    required this.group,
    required this.printers,
    required this.onChanged,
    required this.onClear,
    this.selectedPrinter,
  });

  final GroupScheme group;
  final List<Printer> printers;

  /// The [GroupScheme] stored in [SettingsState.printerGroups] for this group,
  /// encoding the selected printer (refKey = url, name = printer name).
  final GroupScheme? selectedPrinter;

  final ValueChanged<Printer?> onChanged;
  final VoidCallback onClear;

  /// Finds the [Printer] matching the stored [GroupScheme.refKey] (= printer url).
  Printer? get _resolvedPrinter {
    if (selectedPrinter == null) return null;
    try {
      return printers.firstWhere((p) => p.url == selectedPrinter!.refKey);
    } catch (_) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final resolved = _resolvedPrinter;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      spacing: 8,
      children: [
        SizedBox(
          width: 380,
          child: FSelect<Printer>(
            label: Text(group.name),
            hint: 'Не назначен',
            control: FSelectControl.lifted(
              value: resolved,
              onChange: onChanged,
            ),
            items: {for (final p in printers) p.name: p},
          ),
        ),
        if (resolved != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 2),
            child: FButton.icon(
              style: FButtonStyle.outline(),
              onPress: onClear,
              child: const Icon(Icons.close, size: 16),
            ),
          ),
      ],
    );
  }
}

