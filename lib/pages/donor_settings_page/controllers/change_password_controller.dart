import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../service/auth_service.dart';

class ChangePasswordController extends GetxController {
  final TextEditingController currentPasswordController =
      TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final AuthService _authService = Get.find<AuthService>();

  final RxBool validPassword = false.obs;

  final RxnString errorTextCurrentPassword = RxnString();
  final RxnString errorTextNewPassword = RxnString();
  final RxnString errorTextConfirmPassword = RxnString();

  void validatePasswords() {
    validPassword.value = newPasswordController.text.isNotEmpty &&
        confirmPasswordController.text.isNotEmpty;
  }

  Future<void> submit() async {
    errorTextCurrentPassword.value = null;
    errorTextNewPassword.value = null;
    errorTextConfirmPassword.value = null;
    if (validPassword.value) {
      final AuthResponse response = await _authService.changePassword(
        currentPassword: currentPasswordController.text,
        newPassword: newPasswordController.text,
        confirmNewPassword: confirmPasswordController.text,
      );

      if (response.success) {
        Get.back();
      } else {
        final Map<String, dynamic> message = (response.info['result']
            as Map<String, dynamic>)['error'] as Map<String, dynamic>;
        if (message['old_password'] != null) {
          final List<String> errorList =
              (message['old_password'] as List<dynamic>)
                  .map((dynamic item) => item.toString())
                  .toList();
          bool firstError = true;
          for (final String error in errorList) {
            if (firstError) {
              firstError = false;
              errorTextCurrentPassword.value = error;
            } else {
              errorTextCurrentPassword.value =
                  '${errorTextCurrentPassword.value!}\n$error';
            }
          }
        }
        if (message['new_password1'] != null) {
          final List<String> errorList =
              (message['new_password1'] as List<dynamic>)
                  .map((dynamic item) => item.toString())
                  .toList();
          bool firstError = true;
          for (final String error in errorList) {
            if (firstError) {
              firstError = false;
              errorTextNewPassword.value = error;
            } else {
              errorTextNewPassword.value =
                  '${errorTextNewPassword.value!}\n$error';
            }
          }
        }
        if (message['new_password2'] != null) {
          final List<String> errorList =
              (message['new_password2'] as List<dynamic>)
                  .map((dynamic item) => item.toString())
                  .toList();
          bool firstError = true;
          for (final String error in errorList) {
            if (firstError) {
              firstError = false;
              errorTextConfirmPassword.value = error;
            } else {
              errorTextConfirmPassword.value =
                  '${errorTextConfirmPassword.value!}\n$error';
            }
          }
        }
        if (errorTextNewPassword.value == null &&
            errorTextCurrentPassword.value == null &&
            errorTextConfirmPassword.value == null) {
          errorTextConfirmPassword.value = 'An error occurred';
        }
      }
    }
  }
}
