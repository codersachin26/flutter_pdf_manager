import 'package:pdf_manager/models/pdf_file_model.dart';

class PdfList {
  final String name;
  final List<PdfFile> pdfFiles;

  PdfList({required this.name, required this.pdfFiles});

  void add(PdfFile file) {
    this.pdfFiles.add(file);
  }

  void remove(PdfFile pdfFile) {
    this.pdfFiles.removeWhere((file) => file.name == pdfFile.name);
  }

  void rename(PdfFile pdfFile, String newName) {
    var index = this.pdfFiles.indexWhere((file) => file.name == pdfFile.name);
    pdfFiles[index] =
        PdfFile(newName, pdfFiles[index].size, pdfFiles[index].path);
  }
}
