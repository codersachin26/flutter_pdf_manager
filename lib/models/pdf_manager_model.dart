import 'dart:io';

import 'package:pdf_manager/models/pdf_file_model.dart';
import 'package:pdf_manager/utils/get_file_size.dart';

class PdfManager {
  static List<String> pickedFilePaths = <String>[];
  // remove file from disk
  static void removeFiles(List<String> filePath) {}

  // move file from disk
  static void moveFile(List<String> filePath, String from, String to) {}

  // return dir pdfs
  static Future<List<PdfFile>> getPdfs(String dirPath) async {
    final List<PdfFile> pdfFiles = <PdfFile>[];
    final dir = Directory(dirPath);
    if (await dir.exists()) {
      await for (var file in dir.list(recursive: true)) {
        if (file.path.contains('.pdf')) {
          final name = file.path.split('/').last;
          final path = file.path;
          final size = getFileSize(path);
          pdfFiles.add(PdfFile(name, size, path));
        }
      }
    }
    return pdfFiles;
  }

  // create app dirs
  static void createDirs() {
    const String officeDirPath = '/storage/emulated/0/Pdf Manager/Office';
    const String saveDirPath = '/storage/emulated/0/Pdf Manager/Save';
    const String favDirPath = '/storage/emulated/0/Pdf Manager/Favorites';
    final List<String> paths = [officeDirPath, saveDirPath, favDirPath];
    for (var path in paths) {
      if (!Directory(path).existsSync()) {
        final pathDir = Directory(path);
        pathDir.create(recursive: true);
      }
    }
  }
}
