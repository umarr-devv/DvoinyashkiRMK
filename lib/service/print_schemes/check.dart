import 'package:app/blocs/blocs.dart';
import 'package:app/models/models.dart';
import 'package:app/service/print.dart';
import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:talker_flutter/talker_flutter.dart';

class PrintCheckScheme extends PrintScheme {
  PrintCheckScheme({required this.check, required this.dataState});

  final DetailCheckScheme check;
  final DataState dataState;

  @override
  pw.Widget build() {
    final store = dataState.structureUnits.firstWhereLogTypeOrNull(
      (i) => i.refKey == check.structureUnitKey,
    );
    final user = dataState.users.firstWhereLogTypeOrNull(
      (i) => i.refKey == check.userKey,
    );
    return pw.Theme(
      data: pw.ThemeData(
        defaultTextStyle: pw.TextStyle(font: font, fontSize: 7),
      ),
      child: pw.Padding(
        padding: pw.EdgeInsets.symmetric(vertical: 6, horizontal: 8),
        child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Image(logo, width: 128),
            pw.SizedBox(height: 32),
            pw.Text('Номер чека: ${check.number}'),
            pw.SizedBox(height: 24),
            pw.Table(
              columnWidths: {
                0: pw.FlexColumnWidth(2),
                1: pw.FlexColumnWidth(),
                2: pw.FlexColumnWidth(),
                3: pw.FlexColumnWidth(),
              },
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
                    final nomenclature = dataState.nomenclatures
                        .firstWhereLogTypeOrNull(
                          (i) => i.refKey == item.nomenclatureKey,
                        );
                    final characteristic = dataState.characteristics
                        .firstWhereLogTypeOrNull(
                          (i) => i.refKey == item.characteriticKey,
                        );
                    return pw.TableRow(
                      children: [
                        pw.Text('${nomenclature?.description} ${characteristic!.description}'),
                        pw.Text(item.price.toString()),
                        pw.Text(item.quantity.toString()),
                        pw.Text(item.itemSum.toString()),
                      ],
                    );
                  }).toList(),
            ),
            pw.SizedBox(height: 24),
            pw.Text('Магазин: ${store?.description}'),
            pw.Text('Кассир: ${user?.description}'),
            if (check.udsClient.isNotEmpty)
              pw.Text('Клиент: ${check.udsClient}'),
            if (check.udsClient.isNotEmpty)
              pw.Text('Использованные UDS-баллы: ${check.udsSumPayment}'),
            pw.Text('Сумма: ${check.documentSum}'),
            pw.Text(
              'Дата: ${DateFormat('HH:mm dd.MM.yyyy').format(check.date)}',
            ),
            pw.SizedBox(height: 32),
            pw.Text('Не теряйте чек, без нее невозможен возврат'),
            pw.Center(
              child: pw.Text(
                'Спасибо за покупку',
                style: pw.TextStyle(font: font, fontSize: 13),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
