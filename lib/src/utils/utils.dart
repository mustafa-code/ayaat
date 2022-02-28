import 'dart:convert';
import 'dart:io';

import 'dart:math';

String getBase64FormatFile(String path) {
  File file = File(path);
  List<int> fileInByte = file.readAsBytesSync();
  String fileInBase64 = base64Encode(fileInByte);
  return fileInBase64;
}

String getFileSize(int bytes, [int digits = 2]){
  var size = "0 B";
  if (bytes > 0) {
    const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
    var i = (log(bytes) / log(1024)).floor();
    size = ((bytes / pow(1024, i)).toStringAsFixed(digits)) + ' ' + suffixes[i];
  }
  return size;
}