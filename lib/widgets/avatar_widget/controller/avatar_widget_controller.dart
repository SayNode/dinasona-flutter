import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../service/user_state_service.dart';
import '../../../util/image_loader.dart';

class AvatarWidgetController extends GetxController {
  Future<void> selectImage() async {
    final UserStateService userStateService = Get.find<UserStateService>();
    File file;

    try {
      file = await ImageLoader.pickImage(ImageSource.gallery);
      await userStateService.updateAvatar(file: file);
    } catch (e) {
      if (e == 'No image selected') {
        return;
      }
    }

    unawaited(
      Get.dialog(
        barrierDismissible: false,
        const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );

    Get.back();
  }
}
