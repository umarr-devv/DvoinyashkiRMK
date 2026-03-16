import 'package:app/blocs/blocs.dart';
import 'package:app/service/print.dart';
import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:talker_flutter/talker_flutter.dart';

class PrintStatisticNomenclatureScheme extends PrintScheme {
  PrintStatisticNomenclatureScheme({
    required this.items,
    required this.dataState,
  });

  final List<StatisticItemData> items;
  final DataState dataState;

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
                'Статистика по номенклатуре',
                style: pw.TextStyle(
                  font: font,
                  fontSize: 12,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
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
            3: pw.Alignment.centerRight,
          },
          headers: ['Название', 'Характеристика', 'Кол-во', 'Сумма'],
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
              nomenclature?.name ?? '',
              characteristic?.description ?? '',
              NumberFormat.currency(symbol: '').format(item.totalQuantity),
              NumberFormat.currency(symbol: '').format(item.totalSum),
            ];
          }).toList(),
        ),
      ),
      pw.SizedBox(height: 24),
    ];
  }
}
