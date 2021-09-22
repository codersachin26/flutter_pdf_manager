import 'dart:io';

import 'package:pdf_manager/models/pdf_file_model.dart';
import 'package:pdf_manager/utils/get_file_size.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class PdfEncryptTool {
  late PdfFile _file;

  PdfFile get getPdfFile => _file;

  void addPdf(PdfFile file) {
    _file = file;
  }

  Future<void> encryptIt(String password) async {
    final path = '/storage/emulated/0/Pdf Manager/Save/secured_' + _file.name;
    File memoryFile = File(_file.path);
    PdfDocument pdf = PdfDocument(inputBytes: memoryFile.readAsBytesSync());
    pdf.security.ownerPassword = password;
    pdf.security.userPassword = password;
    List<int> bytes = pdf.save();
    pdf.dispose();
    final encryptPdf = File(path);
    await encryptPdf.writeAsBytes(bytes, flush: true).then((value) {
      final fileName = 'secured_${_file.name}';
      final PdfFile securedFile = PdfFile(fileName, getFileSize(path), path);
      _file = securedFile;
    });
  }
}
