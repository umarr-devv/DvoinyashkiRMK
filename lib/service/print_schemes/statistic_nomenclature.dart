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
  pw.Widget build() {
    return pw.Theme(
      data: pw.ThemeData(
        defaultTextStyle: pw.TextStyle(font: font, fontSize: 8),
      ),
      child: pw.Padding(
        padding: const pw.EdgeInsets.symmetric(vertical: 16, horizontal: 4),
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
            pw.Table(
              border: pw.TableBorder.all(width: 0.5),
              children: [
                pw.TableRow(
                  children: [
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(4),
                      child: pw.Text(
                        'Название',
                        style: pw.TextStyle(
                          font: font,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(4),
                      child: pw.Text(
                        'Характеристика',
                        style: pw.TextStyle(
                          font: font,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(4),
                      child: pw.Text(
                        'Кол-во',
                        style: pw.TextStyle(
                          font: font,
                          fontWeight: pw.FontWeight.bold,
                        ),
                        textAlign: pw.TextAlign.right,
                      ),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(4),
                      child: pw.Text(
                        'Сумма',
                        style: pw.TextStyle(
                          font: font,
                          fontWeight: pw.FontWeight.bold,
                        ),
                        textAlign: pw.TextAlign.right,
                      ),
                    ),
                  ],
                ),
                ...items.map((item) {
                  final nomenclature = dataState.nomenclatures
                      .firstWhereLogTypeOrNull(
                        (i) => i.refKey == item.nomenclatureKey,
                      );
                  final characteristic = dataState.characteristics
                      .firstWhereLogTypeOrNull(
                        (i) => i.refKey == item.characteristicKey,
                      );

                  return pw.TableRow(
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Text(nomenclature?.name ?? ''),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Text(characteristic?.description ?? ''),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Text(
                          NumberFormat.currency(
                            symbol: '',
                          ).format(item.totalQuantity),
                          textAlign: pw.TextAlign.right,
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Text(
                          NumberFormat.currency(
                            symbol: '',
                          ).format(item.totalSum),
                          textAlign: pw.TextAlign.right,
                        ),
                      ),
                    ],
                  );
                }),
              ],
            ),
            pw.SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
