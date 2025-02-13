import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class GalleryAccessController extends GetxController {
  final Rx<File?> selectedFilePath = Rx<File?>(null);

  Future<void> pickFile() async {
    final picker = ImagePicker();
    try {
      final pickedImage = await picker.pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        selectedFilePath.value = File(pickedImage.path);
      }
    } finally {}
  }

  void clearFile() {
    selectedFilePath.value = null;
  }
}
