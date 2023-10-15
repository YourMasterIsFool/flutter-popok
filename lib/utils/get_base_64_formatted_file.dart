import 'dart:convert';
import 'dart:io';

String getBase64FormattedFile(String? path) {
  if (path == null) return '';
  File file = File(path);
  List<int> fileInByte = file.readAsBytesSync();
  String fileBase64 = base64Encode(fileInByte);

  return fileBase64;
}
