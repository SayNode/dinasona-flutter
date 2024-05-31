import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../util/password.dart';

class SignupController extends GetxController {
  var test = 'tets'.obs;
  RxBool showPassword = false.obs;
  final Password passwordStrength = Password();
  final TextEditingController password = TextEditingController();
  final TextEditingController email = TextEditingController();

  void setShowPassword() {
    showPassword.value = !showPassword.value;
  }
}
/* import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../util/password.dart';
import '../../../service/auth_service.dart';
import '../../../service/storage_service.dart';
import '../../../service/user_state_service.dart';

class SignupController extends GetxController {
  RxBool showPassword = false.obs;
  final Password passwordStrength = Password();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPass = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController username = TextEditingController();
  RxBool matches = true.obs;
  RxString error = ''.obs;
  RxBool passwordSame = true.obs;
  RxBool invalidPassword = false.obs;
  final AuthService authService = Get.find<AuthService>();
  final Rx<GlobalKey<FormState>> registrationFormKey =
      GlobalKey<FormState>().obs;
  RxString emailError = ''.obs;
  RxString passwordError = ''.obs;
  RxString usernameError = ''.obs;
  RxBool loading = false.obs;
  RxBool loadingGoogle = false.obs;
  RxBool loadingApple = false.obs;
  RxBool faceIdOn = false.obs;
  final StorageService storageService = Get.find<StorageService>();
  UserStateService userStateService = Get.find<UserStateService>();

  void setShowPassword() {
    showPassword.value = !showPassword.value;
  }

  void updateMatch() {
    if (confirmPass.text.compareTo(password.text) == 0) {
      matches.value = true;
    } else if (matches.value == true) {
      matches.value = false;
    }
  }

  Future<String> googleSignInPressed() async {
    loadingGoogle.value = true;
    error.value = '';
    final AuthResponse loginResult = await authService.googleSignIn();
    if (loginResult.success) {
      Get.put(LoginController()).reset();
    } else {
      error.value = loginResult.message;
    }
    loadingGoogle.value = false;
    return error.value;
  }

  Future<String> appleSignInPressed({
    String? authorizationCode,
    String? identityToken,
  }) async {
    loadingApple.value = true;
    error.value = '';
    final AuthResponse loginResult = await authService.appleSignIn(
      authorizationCode: authorizationCode,
      identityToken: identityToken,
    );
    if (loginResult.success) {
      unawaited(
        userStateService.userProfile.value.onBoardingFinished == false
            ? finishCustomization()
            : Get.offAll<void>(
                () => const HomeDashboard(
                  isAfterStart: true,
                ),
              ),
      );
      Get.put(LoginController()).reset();
    } else {
      error.value = loginResult.message;
    }
    loadingApple.value = false;
    return error.value;
  }

  Future<void> signUpSubmit() async {
    loading.value = true;
    invalidPassword.value = false;
    passwordSame.value = true;
    if (email.text.isEmail) {
      if (matches.value == true) {
        if (determinePasswordStrength(confirmPass.value.text) >= 3) {
          final AuthResponse registrationResult =
              await authService.registration(
            email.text,
            password.text,
            username.text,
            faceIdOn.value,
          );
          if (registrationResult.success) {
            await finishCustomization();
          } else {
            registrationFormKey.value.currentState!.validate();
            if (registrationResult.message.isNotEmpty) {
              if ((json.decode(registrationResult.message)
                      as Map<String, dynamic>)
                  .containsKey('email')) {
                emailError.value =
                    jsonDecode(registrationResult.message)['email'][0]
                        as String;
              } else {
                emailError.value = '';
              }
              if ((json.decode(registrationResult.message)
                      as Map<String, dynamic>)
                  .containsKey('password1')) {
                passwordError.value =
                    jsonDecode(registrationResult.message)['password1'][0]
                        as String;
              } else {
                passwordError.value = '';
              }
              if ((json.decode(registrationResult.message)
                      as Map<String, dynamic>)
                  .containsKey('username')) {
                usernameError.value =
                    jsonDecode(registrationResult.message)['username'][0]
                        as String;
              } else {
                usernameError.value = '';
              }
            }
          }
        } else {
          invalidPassword.value = true;
        }
      } else {
        passwordSame.value = false;
      }
    } else {
      emailError.value = 'Invalid email address'.tr;
    }
    loading.value = false;
  }
}
 */