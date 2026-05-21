import 'package:app/blocs/blocs.dart';
import 'package:app/service/print.dart';
import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:talker_flutter/talker_flutter.dart';

class PrintStatisticCategoryScheme extends PrintScheme {
  PrintStatisticCategoryScheme({required this.items, required this.dataState});

  final Map<String?, List<StatisticItemData>> items;
  final DataState dataState;

  @override
  List<pw.Widget> build() {
    return [
      pw.Theme(
        data: pw.ThemeData(
          defaultTextStyle: pw.TextStyle(font: font, fontSize: 8),
        ),
        child: pw.Padding(
          padding: const pw.EdgeInsets.symmetric(horizontal: 2),
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
        padding: const pw.EdgeInsets.symmetric(horizontal: 2),
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
          headers: ['Название', 'Кол-во', 'Сумма'],
          data: items.entries.map((item) {
            final key = item.key;
            final value = item.value;

            final totalQuantity = value.fold(
              0.0,
              (a, b) => a + b.totalQuantity,
            );
            final totalSum = value.fold(0.0, (a, b) => a + b.totalSum);
            final group = dataState.groups.firstWhereLogTypeOrNull(
              (i) => i.refKey == key,
            );
            return [
              group?.name ?? '',
              NumberFormat.currency(symbol: '').format(totalQuantity),
              NumberFormat.currency(symbol: '').format(totalSum),
            ];
          }).toList(),
        ),
      ),
      pw.SizedBox(height: 24),
    ];
  }
}
