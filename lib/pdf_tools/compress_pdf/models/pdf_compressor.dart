import 'dart:io';

import 'package:pdf_manager/models/pdf_file_model.dart';
import 'package:pdf_compressor/pdf_compressor.dart';
import 'package:pdf_manager/utils/get_file_size.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class PdfCompressorTool {
  late PdfFile _file;

  PdfFile get getPdfFile => _file;

  void addPdf(PdfFile file) {
    _file = file;
  }

  Future<String> compressor(CompressQuality quality) async {
    try {
      final memoryFile = File(_file.path);
      final pdf = PdfDocument(inputBytes: memoryFile.readAsBytesSync());
    } catch (e) {
      return 'this file is protected';
    }
    final inputFilePath = _file.path;
    final outputFilePath =
        '/storage/emulated/0/Pdf Manager/Save/compressed_${_file.name}';
    await PdfCompressor.compressPdfFile(inputFilePath, outputFilePath, quality)
        .then((value) {
      final fileName = 'compressed_${_file.name}';
      PdfFile compressedFile =
          PdfFile(fileName, getFileSize(outputFilePath), outputFilePath);
      _file = compressedFile;
    });

    return '';
  }
}
