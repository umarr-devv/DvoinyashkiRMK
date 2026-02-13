import 'package:app/blocs/blocs.dart';
import 'package:app/features/work_time/blocs/detail_session/detail_session_cubit.dart';
import 'package:app/service/print.dart';
import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:talker_flutter/talker_flutter.dart';

class PrintSessionScheme extends PrintScheme {
  PrintSessionScheme({required this.session, required this.dataState});

  final DetailSessionState session;
  final DataState dataState;

  @override
  pw.Widget build() {
    final cashRegister = dataState.cashRegisters.firstWhereLogTypeOrNull(
      (i) => i.refKey == session.workShift?.cashRegisterKey,
    );
    final store = dataState.structureUnits.firstWhereLogTypeOrNull(
      (i) => i.refKey == session.workShift?.structureUnitKey,
    );
    final user = dataState.users.firstWhereLogTypeOrNull(
      (i) => i.refKey == session.workShift?.userKey,
    );
    return pw.Theme(
      data: pw.ThemeData(
        defaultTextStyle: pw.TextStyle(font: font, fontSize: 8),
      ),
      child: pw.Padding(
        padding: pw.EdgeInsets.symmetric(vertical: 16, horizontal: 4),
        child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Image(logo, width: 128),
            pw.SizedBox(height: 32),
            pw.Text('Номер смены: ${session.workShift?.number}'),
            pw.Text('Магазин: ${store?.description}'),
            pw.Text('Касса: ${cashRegister?.description}'),
            pw.Text('Кассир: ${user?.description}'),
            pw.Text(
              'Начало смены: ${DateFormat('HH:mm dd.MM.yyyy').format(session.workShift!.workShiftStart)}',
            ),
            pw.Text(
              'Конец смены: ${DateFormat('HH:mm dd.MM.yyyy').format(session.workShift!.workShiftEnd ?? DateTime(0))}',
            ),
            pw.SizedBox(height: 8),
            pw.Text('Начальная сумма'),
            pw.Table(
              children: session.startCashes.map((i) {
                return pw.TableRow(
                  children: [pw.Text(NumberFormat().format(i.value))],
                );
              }).toList(),
            ),
            pw.Text('Конечная сумма'),
            pw.Table(
              children: session.endCashes.map((i) {
                return pw.TableRow(
                  children: [pw.Text(NumberFormat().format(i.value))],
                );
              }).toList(),
            ),
            pw.SizedBox(height: 8),
            pw.Text('Выемки денег'),
            pw.SizedBox(height: 2),
            pw.Table(
              children:
                  [
                    pw.TableRow(
                      children: [
                        pw.Text('Касса'),
                        pw.Text('Сумма'),
                        pw.Text('Дата'),
                      ],
                    ),
                  ] +
                  session.withdraws.map((item) {
                    final cashRegister = dataState.cashRegisters
                        .firstWhereLogTypeOrNull(
                          (i) => i.refKey == item.cashRegisyerKey,
                        );
                    return pw.TableRow(
                      children: [
                        pw.Text(cashRegister?.description ?? ''),
                        pw.Text(NumberFormat().format(item.documentSum)),
                        pw.Text(
                          DateFormat('HH:mm dd.MM.yyyy').format(item.date),
                        ),
                      ],
                    );
                  }).toList(),
            ),
            pw.SizedBox(height: 8),
            pw.Text('Проданные товары'),
            pw.SizedBox(height: 2),
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
                  session.workShift!.items.map((item) {
                    final nomenclature = dataState.nomenclatures
                        .firstWhereLogTypeOrNull(
                          (i) => i.refKey == item.nomenclatureKey,
                        );
                    return pw.TableRow(
                      children: [
                        pw.Text(nomenclature?.description ?? ''),
                        pw.Text(item.price.toString()),
                        pw.Text(item.quantity.toString()),
                        pw.Text(item.totalSum.toString()),
                      ],
                    );
                  }).toList(),
            ),
            pw.SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
