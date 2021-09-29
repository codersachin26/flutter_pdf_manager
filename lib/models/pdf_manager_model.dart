import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:pdf_manager/models/pdf_file_model.dart';
import 'package:pdf_manager/models/pdf_list_model.dart';
import 'package:pdf_manager/utils/get_file_size.dart';

class PdfManager extends ChangeNotifier {
  List<PdfFile> _markedPdfFile = <PdfFile>[];
  bool isMarking = false;
  static const _dirPaths = {
    'All Pdf': '/storage/emulated/0',
    'Download': '/storage/emulated/0/Download',
    'Telegram': '/storage/emulated/0/Telegram/Telegram Documents',
    'WhatsApp': '/storage/emulated/0/WhatsApp/Media/WhatsApp Documents',
    'Save': '/storage/emulated/0/Pdf Manager/Save',
    'Favorites': '/storage/emulated/0/Pdf Manager/Favorites',
    'Office': '/storage/emulated/0/Pdf Manager/Office',
    'SDcard': '/storage/sdcard/'
  };

  Map<String, PdfListDir> _pdfListDirs = Map<String, PdfListDir>();

  int get markedCount => _markedPdfFile.length;

  PdfFile get getmarkedPdf => _markedPdfFile.first;

  // remove pdf file from disk
  Future<void> removeFiles(String listName) async {
    while (_markedPdfFile.isNotEmpty) {
      final PdfFile file = _markedPdfFile.removeLast();
      File deleteFile = File(file.path);
      await deleteFile.delete();
      PdfListDir listDir = _pdfListDirs[listName]!;
      listDir.remove(file);
      _pdfListDirs[listName] = listDir;
    }

    notifyListeners();
  }

  // rename pdf file
  Future<String?> renamePdfFile(String newName, String listName) async {
    final pdfFile = File(_markedPdfFile.first.path);
    final newFileName = newName + '.pdf';
    final newPath =
        pdfFile.path.replaceFirst(_markedPdfFile.first.name, newFileName);
    print(File(newPath).existsSync());
    if (File(newPath).existsSync() &&
        newFileName != _markedPdfFile.first.name) {
      return 'file already exists';
    } else {
      await pdfFile.rename(newPath);
      PdfListDir listDir = _pdfListDirs[listName]!;
      listDir.rename(_markedPdfFile.first, newPath);
      _pdfListDirs[listName] = listDir;
      print(listDir);

      notifyListeners();
    }
  }

  // move pdf files to new path
  Future<void> moveFile(String from, String to) async {
    while (_markedPdfFile.isNotEmpty) {
      PdfFile file = _markedPdfFile.removeLast();
      File sourceFile = File(file.path);
      try {
        await sourceFile.rename(
            '/storage/emulated/0/Pdf Manager/$to/${file.path.split('/').last}');
      } on FileSystemException catch (e) {
        print(e.osError);
        await sourceFile.copy(
            '/storage/emulated/0/Pdf Manager/$to/${file.path.split('/').last}');
        await sourceFile.delete();
      }
      final addListName = to;
      final removeListName = from;

      // remove from PdfList model
      removePdfFromList(removeListName, file);

      // add to PdfList model
      addPdfToList(addListName, file);
    }

    notifyListeners();
  }

  // remove pdf file from list
  void removePdfFromList(String listName, PdfFile file) {
    final listDir = _pdfListDirs[listName]!;
    listDir.remove(file);
    _pdfListDirs[listName] = listDir;
  }

  // add pdf file to list
  void addPdfToList(String listName, PdfFile file) {
    final listDir = _pdfListDirs[listName]!;
    listDir.add(file);
    _pdfListDirs[listName] = listDir;
  }

  // return dir pdfs
  Future<List<PdfFile>> getPdfs(String dirName) async {
    return _pdfListDirs[dirName]!.pdfFiles;
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

  void marked(PdfFile pdfFile) {
    if (_markedPdfFile.any((file) => file.name == pdfFile.name)) {
      _markedPdfFile.removeWhere((file) => file.name == pdfFile.name);
    } else {
      _markedPdfFile.add(pdfFile);
    }

    notifyListeners();
  }

  bool isMarked(String name) {
    return _markedPdfFile.any((file) => file.name == name);
  }

  void clearMarked() {
    this._markedPdfFile.clear();
  }

  void initPdfLists() {
    var paths = _dirPaths;
    paths.forEach((listName, path) async {
      final List<PdfFile> pdfFiles = <PdfFile>[];
      final dir = Directory(path);
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
      _pdfListDirs[listName] = PdfListDir(name: listName, pdfFiles: pdfFiles);
    });
  }

  void setMarkingState(bool value) {
    isMarking = value;
    clearMarked();
    notifyListeners();
  }
}
