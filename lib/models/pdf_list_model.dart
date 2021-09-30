import 'package:pdf_manager/models/pdf_file_model.dart';

class PdfListDir {
  final String name;
  final List<PdfFile> pdfFiles;

  PdfListDir({required this.name, required this.pdfFiles});

  void add(PdfFile file) {
    this.pdfFiles.add(file);
  }

  void remove(PdfFile pdfFile) {
    this.pdfFiles.removeWhere((file) => file.name == pdfFile.name);
  }

  void update(PdfFile pdfFile, int index) {
    this.pdfFiles.removeAt(index);
    this.pdfFiles.insert(index, pdfFile);
  }
}
