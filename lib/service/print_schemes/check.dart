import 'package:app/models/models.dart';
import 'package:app/service/print.dart';
import 'package:pdf/widgets.dart' as pw;

class PrintCheckScheme extends PrintScheme {
  PrintCheckScheme({required this.check});

  final DetailCheckScheme check;

  @override
  pw.Widget build() {
    return pw.Theme(
      data: pw.ThemeData(
        defaultTextStyle: pw.TextStyle(font: font, fontSize: 10),
      ),
      child: pw.Padding(
        padding: pw.EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Image(logo, width: 128),
            pw.SizedBox(height: 32),
            pw.Text(
              'Номер чека: ${check.number}',
              style: pw.TextStyle(
                font: font,
                fontSize: 16,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.SizedBox(height: 12),
            pw.Table(
              children:
                  [
                    pw.TableRow(
                      children: [
                        pw.Text('Название'),
                        pw.Text('Цена'),
                        pw.Text('Кол-во'),
                        pw.Text('Итого'),
                      ],
                    ),
                  ] +
                  check.items.map((item) {
                    return pw.TableRow(
                      children: [
                        pw.Text(item.nomenclatureKey),
                        pw.Text(item.price.toString()),
                        pw.Text(item.quantity.toString()),
                        pw.Text(item.itemSum.toString()),
                      ],
                    );
                  }).toList(),
            ),
            pw.SizedBox(height: 12),
            pw.Text(
              'Магазин: ${check.structureUnitKey}',
              style: pw.TextStyle(
                font: font,
                fontSize: 12,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.Text(
              'Кассир: ${check.userKey}',
              style: pw.TextStyle(
                font: font,
                fontSize: 12,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            if (check.udsClient.isNotEmpty)
              pw.Text(
                'Клиент: ${check.udsClient}',
                style: pw.TextStyle(
                  font: font,
                  fontSize: 12,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            if (check.udsSumPayment.isNotEmpty)
              pw.Text(
                'UDS-баллы: ${check.udsSumPayment}',
                style: pw.TextStyle(
                  font: font,
                  fontSize: 12,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            pw.Text(
              'Сумма: ${check.documentSum}',
              style: pw.TextStyle(
                font: font,
                fontSize: 12,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.Text(
              'Дата: ${check.date}',
              style: pw.TextStyle(
                font: font,
                fontSize: 12,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.SizedBox(height: 32),
            pw.Center(
              child: pw.Text(
                'Спасибо за покупку',
                style: pw.TextStyle(
                  font: font,
                  fontSize: 14,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
