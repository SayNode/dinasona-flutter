import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../service/auth_service.dart';
import '../../temp_home_page.dart';

class LoginController extends GetxController {
  final AuthService authService = Get.find<AuthService>();
  RxBool showPassword = false.obs;
  final TextEditingController password = TextEditingController();
  final TextEditingController email = TextEditingController();
  RxString error = ''.obs;
  RxBool loading = false.obs;

  void setShowPassword() {
    showPassword.value = !showPassword.value;
  }

  Future<void> loginSubmit() async {
    loading.value = true;
    error.value = '';
    if (email.text.isEmail) {
      if (password.text.isNotEmpty) {
        final AuthResponse loginResult =
            await authService.login(email.text, password.text);
        if (loginResult.success) {
          await Get.to<void>(() => const TempHomePage());
        }
      } else {
        error.value = 'Password is required';
      }
    } else {
      error.value = 'Invalid email';
    }

    loading.value = false;
  }
}
