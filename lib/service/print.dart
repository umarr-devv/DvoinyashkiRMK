
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:talker/talker.dart';

class PrintService {
  PrintService(this.printerUrl);

  final String printerUrl;
  final talker = GetIt.I<Talker>();

  Future print(PrintScheme scheme) async {
    try {
      await Printing.directPrintPdf(
        printer: Printer(url: printerUrl),
        onLayout: (pageFormat) async {
          return await scheme.init(pageFormat);
        },
        usePrinterSettings: true,
      );
    } catch (exc, st) {
      talker.error(exc, st);
    }
  }
}

abstract class PrintScheme {
  PrintScheme();

  final pdf = pw.Document();

  late pw.Font font;
  late pw.MemoryImage logo;

  Future<Uint8List> init(PdfPageFormat pageFormat) async {
    final fontData = await rootBundle.load(
      "assets/fonts/Manrope/Manrope-Regular.ttf",
    );
    final logoData = await rootBundle.load('assets/images/print_logo.png');

    font = pw.Font.ttf(fontData.buffer.asByteData());
    logo = pw.MemoryImage(logoData.buffer.asUint8List());

    pdf.addPage(pw.Page(pageFormat: pageFormat, build: (context) => build()));
    return await pdf.save();
  }

  pw.Widget build();
}
