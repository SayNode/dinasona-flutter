import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../model/auth_response.dart';
import '../../../../service/auth_service.dart';
import '../../../../util/password.dart';
import '../../../../widgets/password_updated_page.dart';

class EnterNewPasswordController extends GetxController {
  RxBool showPassword = false.obs;
  final TextEditingController newPasswordController = TextEditingController();
  RxBool matches = true.obs;
  RxBool isStrong = false.obs;
  RxBool hasError = false.obs;
  RxString createPasswordError = ''.obs;
  final AuthService authService = Get.find<AuthService>();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  void updateMatch() {
    if (newPasswordController.text.compareTo(confirmPasswordController.text) ==
            0 &&
        confirmPasswordController.text.isNotEmpty) {
      matches.value = true;

      if (determinePasswordStrength(newPasswordController.text) >= 3) {
        createPasswordError.value = '';
        isStrong.value = true;
      } else {
        createPasswordError.value = 'Password is too weak'.tr;
        isStrong.value = false;
      }
    } else if (matches.value == true) {
      createPasswordError.value = 'Passwords do not match'.tr;
      matches.value = false;
      isStrong.value = true;
    }
  }

  void setShowPassword() {
    showPassword.value = !showPassword.value;
  }

  Future<void> onPasswordChangeSubmit() async {
    createPasswordError.value = '';

    final AuthResponse result = await authService.changePasswordAfterReset(
      newPasswordController.text,
      confirmPasswordController.text,
    );

    if (result.success) {
      unawaited(Get.offAll<void>(() => const PasswordUpdatedPage()));
    } else {
      // ignore: always_specify_types
      result.result.forEach((String key, value) {
        // ignore: avoid_dynamic_calls
        createPasswordError.value = value[0].toString();
      });
    }
  }
}
