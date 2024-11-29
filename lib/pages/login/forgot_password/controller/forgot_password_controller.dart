// ignore_for_file: inference_failure_on_function_invocation

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../model/auth_response.dart';
import '../../../../service/auth_service.dart';
import '../../../../util/password.dart';
import '../../../../widgets/password_updated_page.dart';
import '../enter_new_password_page.dart';
import '../password_reset_code_page.dart';
import '../reset_password_page.dart';

class ForgotPasswordController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final RxString email = ''.obs;
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController codeController = TextEditingController();
  final AuthService authService = Get.find<AuthService>();
  RxBool matches = true.obs;
  RxBool isStrong = false.obs;
  RxBool hasError = false.obs;
  RxString createPasswordError = ''.obs;
  RxString unknownEmailError = ''.obs;
  RxBool emailIsSent = false.obs;
  RxBool codeIsInValid = false.obs;
  RxBool showPassword = false.obs;
  final RxBool isValid = false.obs;

  void setShowPassword() {
    showPassword.value = !showPassword.value;
  }

  void isEmail() {
    email.value = emailController.text;
    if (emailController.text.isEmail) {
      isValid.value = true;
    } else {
      isValid.value = false;
    }
  }

  Future<void> onSubmit() async {
    emailIsSent.value = false;

    unawaited(
      Get.to<Widget>(
        () => ResetPasswordPage(
          email: emailController.text,
          onTap: () => Get.to<void>(const PasswordResetCodePage()),
        ),
      ),
    );

    final AuthResponse authResponse =
        await authService.resetPassword(emailController.text.toLowerCase());
    emailIsSent.value = authResponse.success;

    if (emailIsSent.value) {
      unknownEmailError.value = '';
      Future<void>.delayed(const Duration(milliseconds: 2000), () {
        Get.to<void>(() => const PasswordResetCodePage());
      });
    } else {
      // ignore: always_specify_types
      authResponse.result.forEach((String key, value) {
        unknownEmailError.value = value.toString();
      });
    }
  }

  Future<void> validateCode(String recoveryCode) async {
    codeIsInValid.value = !(await authService.verifyCode(recoveryCode)).success;

    if (!codeIsInValid.value) {
      unawaited(Get.offAll<void>(() => const EnterNewPasswordPage()));
    }
  }

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

  Future<void> onPasswordChangeSubmit() async {
    createPasswordError.value = '';

    final AuthResponse result = await authService.changePasswordAfterReset(
      newPasswordController.text,
      confirmPasswordController.text,
    );

    if (result.success) {
      unawaited(Get.offAll<void>(const PasswordUpdatedPage()));
    } else {
      // ignore: always_specify_types
      result.result.forEach((String key, value) {
        // ignore: avoid_dynamic_calls
        createPasswordError.value = value[0].toString();
      });
    }
  }
}
