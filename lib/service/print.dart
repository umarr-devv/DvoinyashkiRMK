import 'package:app/blocs/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:talker/talker.dart';

class PrintService {
  PrintService({this.printerUrl});

  final String? printerUrl;
  final talker = GetIt.I<Talker>();

  Future print(PrintScheme scheme, BuildContext context) async {
    final cubit = BlocProvider.of<SettingsCubit>(context);
    if (cubit.state.printer == null) {
      return;
    }
    try {
      await Printing.directPrintPdf(
        printer: Printer(url: printerUrl ?? cubit.state.printer!),
        onLayout: (pageFormat) async {
          return await scheme.init(pageFormat);
        },
        usePrinterSettings: false,
      );
    } catch (exc, st) {
      talker.error(exc, st);
    }
  }
}

abstract class PrintScheme {
  PrintScheme();

  late pw.Font font;
  late pw.ImageProvider logo;

  Future<void> prepareResources() async {
    font = await fontFromAssetBundle(
      'assets/fonts/Manrope/Manrope-SemiBold.ttf',
    );
    logo = await imageFromAssetBundle('assets/images/print_logo.png');
  }

  Future<Uint8List> init(PdfPageFormat pageFormat) async {
    final pdf = pw.Document(compress: false, pageMode: PdfPageMode.fullscreen);
    await prepareResources();
    pdf.addPage(
      pw.Page(
        pageFormat: pageFormat,
        theme: pw.ThemeData.withFont(base: font, bold: font),
        build: (context) => build(),
      ),
    );
    return await pdf.save();
  }

  pw.Widget build();
}
