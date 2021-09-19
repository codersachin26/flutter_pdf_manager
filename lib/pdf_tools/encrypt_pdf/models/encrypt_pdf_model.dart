import 'dart:io';

import 'package:pdf_manager/models/pdf_file_model.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class PdfEncrypt {
  final PdfFile _file;

  PdfEncrypt(this._file);

  void encryptIt(String password) async {
    final path = '/storage/emulated/0/Pdf Manager/Save/secured_' + _file.name;
    File memoryFile = File(_file.path);
    PdfDocument pdf = PdfDocument(inputBytes: memoryFile.readAsBytesSync());
    pdf.security.userPassword = password;
    List<int> bytes = pdf.save();
    pdf.dispose();
    final encryptPdf = File(path);
    await encryptPdf.writeAsBytes(bytes, flush: true);
  }
}
