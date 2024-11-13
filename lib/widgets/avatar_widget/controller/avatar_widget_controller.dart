import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../service/user_state_service.dart';
import '../../../util/image_loader.dart';

class AvatarWidgetController extends GetxController {
  RxBool isUploading = false.obs;

  Future<void> selectImage() async {
    final UserStateService userStateService = Get.find<UserStateService>();
    File file;
    try {
      file = await ImageLoader.pickImage(ImageSource.gallery);
      isUploading.value = true;

      await userStateService.updateUserAvatar(file: file);

      if (!Get.find<UserStateService>().user.value.isDonor) {
        await userStateService.updateBeneficiaryImage(file: file);
      }
      isUploading.value = false;
    } catch (e) {
      if (e == 'No image selected') {
        isUploading.value = false;
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
