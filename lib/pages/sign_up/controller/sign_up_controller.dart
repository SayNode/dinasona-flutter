import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../service/auth_service.dart';
import '../../../service/user_state_service.dart';
import '../../../util/password.dart';

class SignupController extends GetxController {
  RxBool showPassword = false.obs;
  final Password passwordStrength = Password();
  final TextEditingController password = TextEditingController();
  final TextEditingController email = TextEditingController();
  RxBool loading = false.obs;
  RxBool invalidPassword = false.obs;
  RxString emailError = ''.obs;
  RxString passwordError = ''.obs;
  RxString error = ''.obs;
  RxBool loadingGoogle = false.obs;
  RxBool loadingApple = false.obs;
  final Rx<GlobalKey<FormState>> registrationFormKey =
      GlobalKey<FormState>().obs;
  final AuthService authService = Get.put(AuthService());
  UserStateService userStateService = Get.find<UserStateService>();

  void setShowPassword() {
    showPassword.value = !showPassword.value;
  }

  Future<void> signUpSubmit() async {
    loading.value = true;
    invalidPassword.value = false;
    if (email.text.isEmail) {
      if (determinePasswordStrength(password.value.text) >= 3) {
        final AuthResponse registrationResult = await authService.registration(
          email.text,
          password.text,
        );
        if (registrationResult.success) {
          // TODO
          print('Registration successful ${registrationResult.success}');
        } else {
          registrationFormKey.value.currentState!.validate();
          if (registrationResult.info.isNotEmpty) {
            if ((json.decode(registrationResult.info.toString())
                    as Map<String, dynamic>)
                .containsKey('email')) {
              emailError.value =
                  jsonDecode(registrationResult.info.toString())['email'][0]
                      as String;
            } else {
              emailError.value = '';
            }
            if ((json.decode(registrationResult.info.toString())
                    as Map<String, dynamic>)
                .containsKey('password')) {
              passwordError.value =
                  jsonDecode(registrationResult.info.toString())['password'][0]
                      as String;
            } else {
              passwordError.value = '';
            }
          }
        }
      } else {
        invalidPassword.value = true;
      }
    } else {
      emailError.value = 'Invalid email address'.tr;
    }
    loading.value = false;
  }

  Future<String> googleSignInPressed() async {
    loadingGoogle.value = true;
    error.value = '';
    final AuthResponse loginResult = await authService.googleSignIn();
    if (loginResult.success) {
      print('Google registration successful ${loginResult.success}');
    } else {
      error.value = loginResult.info.toString();
    }
    loadingGoogle.value = false;
    return error.value;
  }
}
