import 'package:app/blocs/blocs.dart';
import 'package:app/features/work_time/blocs/detail_session/detail_session_cubit.dart';
import 'package:app/service/print.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:talker_flutter/talker_flutter.dart';

class PrintSessionScheme extends PrintScheme {
  PrintSessionScheme({
    required this.session,
    required this.dataState,
    required this.context,
  });

  final DetailSessionState session;
  final DataState dataState;
  final BuildContext context;

  @override
  List<pw.Widget> build() {
    final cashRegister = dataState.cashRegisters.firstWhereLogTypeOrNull(
      (i) => i.refKey == session.workShift?.cashRegisterKey,
    );
    final store = dataState.structureUnits.firstWhereLogTypeOrNull(
      (i) => i.refKey == session.workShift?.structureUnitKey,
    );
    final user = dataState.users.firstWhereLogTypeOrNull(
      (i) => i.refKey == session.workShift?.userKey,
    );
    final startWarehouseCash = session.startWarehouseItemsCash(context);
    final endWarehouseCash = session.endWarehouseItemsCash(context);
    return [
      pw.Theme(
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
              pw.Text('Выручка'),
              pw.Text('Наличные: ${NumberFormat().format(session.cashRevenue)}'),
              pw.Text('Безналичные: ${NumberFormat().format(session.cashlessRevenue)}'),
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
              pw.SizedBox(height: 8),
              pw.Text('Начальная сумма товаров'),
              pw.Text(NumberFormat().format(startWarehouseCash)),
              pw.Text('Конечная сумма товаров'),
              pw.Text(NumberFormat().format(endWarehouseCash)),
              pw.SizedBox(height: 24),
            ],
          ),
        ),
      ),
    ];
  }
}
