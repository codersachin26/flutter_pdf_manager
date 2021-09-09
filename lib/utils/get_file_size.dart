import 'dart:io';

String getFileSize(String path) {
  final file = File(path);
  int sizeInBytes = file.lengthSync();
  if (sizeInBytes > 1000000) {
    const MB = 'MB';
    String sizeInMb = (sizeInBytes / (1024 * 1024)).toStringAsFixed(1);
    return sizeInMb + MB;
  } else {
    const KB = 'KB';
    String sizeInKB = (sizeInBytes / (1024)).toStringAsFixed(1);
    return sizeInKB + KB;
  }
}
