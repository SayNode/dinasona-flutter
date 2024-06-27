import 'dart:io';

import 'package:image_picker/image_picker.dart';

//TODO: Implement ImageLoader everywhere in the app where images are picked

class ImageLoader {
  static Future<File> pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    throw ImageException('No image selected');
  }
}

class ImageException implements Exception {
  ImageException(this.message);
  final String message;
  @override
  String toString() => message;
}
