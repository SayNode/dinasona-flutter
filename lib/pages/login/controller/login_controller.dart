import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../service/auth_service.dart';
import '../../home/beneficary_home_page.dart';

class LoginController extends GetxController {
  final AuthService authService = Get.find<AuthService>();
  RxBool showPassword = false.obs;
  final TextEditingController password = TextEditingController();
  final TextEditingController email = TextEditingController();
  RxString error = ''.obs;
  RxBool loading = false.obs;
  RxBool isSignInButtonActive = false.obs;
  RxBool isEmailFieldEmpty = false.obs;
  RxBool isPasswordFieldEmpty = false.obs;

  @override
  void onInit() {
    super.onInit();
    password.addListener(() {
      isPasswordFieldEmpty.value = password.text.isNotEmpty.obs.value;
      isSignInButtonActive.value =
          isPasswordFieldEmpty.value && isEmailFieldEmpty.value;
    });
    email.addListener(() {
      isEmailFieldEmpty.value = email.text.isNotEmpty.obs.value;
      isSignInButtonActive.value =
          isPasswordFieldEmpty.value && isEmailFieldEmpty.value;
    });
  }

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
          await Get.to<void>(() => const BeneficiaryHomePage());
        } else {
          error.value = 'Unable to log in with provided credentials';
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
