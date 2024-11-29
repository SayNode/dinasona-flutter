import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/auth_response.dart';
import '../../../service/auth_service.dart';
import '../../../service/storage/secure_storage_service.dart';
import '../../../service/user_state_service.dart';
import '../../root/beneficiary_root_page.dart';
import '../../root/donor_root_page.dart';
import '../forgot_password/forgot_password.dart';

class LoginController extends GetxController {
  final SecureStorageService secureStorageService =
      Get.find<SecureStorageService>();
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

  Future<void> forgotPassword() async {
    unawaited(
      Get.off(
        () => const ForgotPassword(),
      ),
    );
  }

  Future<void> loginSubmit(bool isBeneficiary) async {
    loading.value = true;
    error.value = '';
    if (email.text.isEmail) {
      if (password.text.isNotEmpty) {
        final AuthResponse loginResult =
            await authService.login(email.text.toLowerCase(), password.text);
        if (loginResult.success) {
          await Get.find<UserStateService>().init();
          await Get.find<UserStateService>().fetchUserInfo();
          if (!Get.find<UserStateService>().user.value.isDonor) {
            await Get.find<UserStateService>().fetchBeneficiaryInfo();
          }
          password.clear();
          email.clear();
          unawaited(
            Get.offAll<void>(
              () => Get.find<UserStateService>().user.value.isDonor
                  ? const DonorRootPage()
                  : const BeneficiaryRootPage(),
            ),
          );
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
