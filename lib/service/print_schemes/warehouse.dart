import 'package:app/blocs/blocs.dart';
import 'package:app/models/models.dart';
import 'package:app/service/print.dart';
import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:talker_flutter/talker_flutter.dart';

class PrintWarehouseScheme extends PrintScheme {
  PrintWarehouseScheme({
    required this.items,
    required this.dataState,
    required this.store,
  });

  final List<WarehouseItemScheme> items;
  final DataState dataState;
  final StructureUnitScheme? store;

  @override
  List<pw.Widget> build() {
    return [
      pw.Theme(
        data: pw.ThemeData(
          defaultTextStyle: pw.TextStyle(font: font, fontSize: 8),
        ),
        child: pw.Padding(
          padding: const pw.EdgeInsets.symmetric(horizontal: 4),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Image(logo, width: 128),
              pw.SizedBox(height: 16),
              pw.Text(
                'Остатки на складе',
                style: pw.TextStyle(
                  font: font,
                  fontSize: 12,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              if (store != null) pw.Text('Магазин: ${store!.description}'),
              pw.Text(
                'Дата печати: ${DateFormat('dd.MM.yyyy HH:mm:ss').format(DateTime.now())}',
              ),
              pw.SizedBox(height: 16),
            ],
          ),
        ),
      ),
      pw.Padding(
        padding: const pw.EdgeInsets.symmetric(horizontal: 4),
        child: pw.TableHelper.fromTextArray(
          border: pw.TableBorder.all(width: 0.5),
          cellStyle: pw.TextStyle(font: font, fontSize: 8),
          headerStyle: pw.TextStyle(
            font: font,
            fontSize: 8,
            fontWeight: pw.FontWeight.bold,
          ),
          cellAlignments: {
            0: pw.Alignment.centerLeft,
            1: pw.Alignment.centerLeft,
            2: pw.Alignment.centerRight,
          },
          headers: ['Название', 'Характеристика', 'Кол-во'],
          data: items.map((item) {
            final nomenclature = dataState.nomenclatures
                .firstWhereLogTypeOrNull(
                  (i) => i.refKey == item.nomenclatureKey,
                );
            final characteristic = dataState.characteristics
                .firstWhereLogTypeOrNull(
                  (i) => i.refKey == item.characteristicKey,
                );
            return [
              nomenclature?.description ?? '',
              characteristic?.description ?? '',
              NumberFormat.decimalPattern().format(item.quantity),
            ];
          }).toList(),
        ),
      ),
      pw.SizedBox(height: 24),
    ];
  }
}
