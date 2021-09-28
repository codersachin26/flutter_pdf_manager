import 'dart:io';
import 'dart:isolate';
import 'dart:typed_data';

import 'package:pdf/widgets.dart' as pw;
import 'package:image/image.dart' as img;
import 'package:pdf_manager/models/pdf_file_model.dart';
import 'package:pdf_manager/utils/get_file_size.dart';

class ImgToPdf {
  final List<Uint8List> _images;

  ImgToPdf(this._images);

  List<Uint8List> get getAllImg => this._images;

  void remove(int index) {
    this._images.removeAt(index);
  }

  Future<PdfFile> convertToPdf(String name) async {
    final pdfFileName = name + '.pdf';

    final pdf = pw.Document();
    for (var _image in _images) {
      final image = pw.MemoryImage(_image);

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

  static void rotateImg(RotateParam param) {
    final img.Image orignalImg = img.decodeImage(param.imageBytes)!;
    final img.Image orientedImg = img.copyRotate(orignalImg, 90);

    final orientedImgBytes = img.encodePng(orientedImg);
    final rotateImageBytes = Uint8List.fromList(orientedImgBytes);
    param.sendPort.send(rotateImageBytes);
  }

  Future<void> changeOrientation(int index) async {
    final imageBytes = _images[index];
    var recievePort = ReceivePort();
    await Isolate.spawn(
        rotateImg, RotateParam(imageBytes, recievePort.sendPort));

    final orientedImgBytes = await recievePort.first as Uint8List;
    _images.removeAt(index);
    _images.insert(index, orientedImgBytes);
  }
}

class RotateParam {
  final Uint8List imageBytes;
  final SendPort sendPort;
  RotateParam(this.imageBytes, this.sendPort);
}
