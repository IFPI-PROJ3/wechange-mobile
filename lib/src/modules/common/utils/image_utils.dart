import 'dart:convert';
import 'dart:io';

class ImageUtils {
  static String ConvertToBase64(File file) {
    List<int> imageBytes = file.readAsBytesSync();
    return base64Encode(imageBytes);
  }
}
