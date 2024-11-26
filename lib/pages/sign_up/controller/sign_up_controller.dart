import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/auth_response.dart';
import '../../../service/auth_service.dart';
import '../../../service/user_state_service.dart';
import '../../../util/password.dart';
import '../../choose_path_page.dart';

class SignupController extends GetxController {
  //Services
  final AuthService authService = Get.put(AuthService());
  final UserStateService userStateService = Get.find<UserStateService>();

  //Variables
  RxBool showPassword = false.obs;
  final Password passwordStrength = Password();
  final TextEditingController password = TextEditingController();
  final TextEditingController email = TextEditingController();
  RxBool loading = false.obs;
  RxString error = ''.obs;
  final Rx<GlobalKey<FormState>> registrationFormKey =
      GlobalKey<FormState>().obs;
  RxBool isCreateAccountButtonActive = false.obs;
  RxBool isEmailFieldEmpty = false.obs;
  RxBool isPasswordFieldEmpty = false.obs;

  @override
  Future<void> onInit() async {
    super.onInit();

    password.addListener(() {
      isPasswordFieldEmpty.value = password.text.isNotEmpty.obs.value;
      isCreateAccountButtonActive.value =
          isPasswordFieldEmpty.value && isEmailFieldEmpty.value;
    });
    email.addListener(() {
      isEmailFieldEmpty.value = email.text.isNotEmpty.obs.value;
      isCreateAccountButtonActive.value =
          isPasswordFieldEmpty.value && isEmailFieldEmpty.value;
    });
  }

  void setShowPassword() {
    showPassword.value = !showPassword.value;
  }

  Future<void> signUpSubmit() async {
    loading.value = true;
    error.value = '';
    if (email.text.isEmail) {
      if (determinePasswordStrength(password.value.text) >= 3) {
        final AuthResponse registrationResult = await authService.registration(
          email.text,
          password.text,
          '',
          biometrics: false,
        );
        if (registrationResult.success) {
          await Get.find<UserStateService>().init();
          password.clear();
          email.clear();
          unawaited(Get.to(() => const ChoosePathPage()));
        } else {
          try {
            registrationFormKey.value.currentState!.validate();
            final Map<String, dynamic> errorMap =
                registrationResult.result['error'] as Map<String, dynamic>;
            if (errorMap.isNotEmpty) {
              if (errorMap.containsKey('email')) {
                error.value =
                    // ignore: avoid_dynamic_calls
                    errorMap['email'][0] as String;
              }
              if (errorMap.containsKey('password')) {
                error.value =
                    // ignore: avoid_dynamic_calls
                    errorMap['password'][0] as String;
              }
            }
          } catch (e) {
            error.value = 'This account is already in use'.tr;
          }
        }
      } else {
        error.value =
            'Password is too weak. Your password should contain: a minimum of 8 characters\nat least 1 lower case character\nat least 1 upper case character\nat least 1 special character.'
                .tr;
      }
    } else {
      error.value = 'Invalid email address'.tr;
    }
    loading.value = false;
  }
}
