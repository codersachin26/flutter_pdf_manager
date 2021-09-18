import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf_manager/models/pdf_file_model.dart';
import 'package:pdf_manager/models/pdf_manager_model.dart';
import 'package:pdf_manager/utils/get_file_size.dart';
import 'package:provider/provider.dart';

class ImgToPdf {
  final List<XFile> _images;

  ImgToPdf(this._images);

  List<XFile> get getAllImg => this._images;

  void remove(int index) {
    this._images.removeAt(index);
  }

  Future<PdfFile> convertToPdf(String name) async {
    final pdfFileName = name + '.pdf';
    final pdf = pw.Document();
    for (var img in _images) {
      final image = pw.MemoryImage(File(img.path).readAsBytesSync());
      pdf.addPage(pw.Page(
          build: (pw.Context context) => pw.Center(child: pw.Image(image))));
    }
    final file = File("/storage/emulated/0/Pdf Manager/Save/$pdfFileName");
    await file.writeAsBytes(await pdf.save());
    final newpdf = File("/storage/emulated/0/Pdf Manager/Save/$pdfFileName");
    PdfFile pdfFile =
        PdfFile(pdfFileName, getFileSize(newpdf.path), newpdf.path);
    return pdfFile;
  }
}
