import 'package:app/service/print.dart';
import 'package:pdf/widgets.dart' as pw;

class PrintCheckScheme extends PrintScheme {
  @override
  pw.Widget build() {
    return pw.Column(
      children: [
        pw.Image(logo),
        pw.Text('text', style: pw.TextStyle(font: font)),
      ],
    );
  }
}
