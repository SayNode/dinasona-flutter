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
    final File file = await ImageLoader.pickImage(ImageSource.gallery);
    unawaited(
      Get.dialog(
        barrierDismissible: false,
        const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
    await userStateService.updateAvatar(file: file);
    Get.back();
  }
}
