import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../service/auth_service.dart';
import '../../../service/user_state_service.dart';
import '../../../util/password.dart';
import '../../../widgets/dinasona_popup.dart';
import '../../home/beneficary_home_page.dart';
import '../../home/donor_home_page.dart';

class SignupController extends GetxController {
  SignupController({required this.isBeneficiary});

  RxBool showPassword = false.obs;
  final Password passwordStrength = Password();
  final TextEditingController password = TextEditingController();
  final TextEditingController email = TextEditingController();
  RxBool loading = false.obs;
  RxString error = ''.obs;
  RxBool loadingGoogle = false.obs;
  RxBool loadingApple = false.obs;
  final Rx<GlobalKey<FormState>> registrationFormKey =
      GlobalKey<FormState>().obs;
  final AuthService authService = Get.put(AuthService());
  UserStateService userStateService = Get.find<UserStateService>();
  RxString chosenLanguage = ''.obs;
  RxString chosenCurrency = ''.obs;
  RxBool isCreateAccountButtonActive = false.obs;
  RxBool isEmailFieldEmpty = false.obs;
  RxBool isPasswordFieldEmpty = false.obs;
  late bool isBeneficiary;

  @override
  void onInit() {
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

  Future<void> signUpSubmit({bool isBeneficiary = false}) async {
    loading.value = true;
    error.value = '';
    if (email.text.isEmail) {
      if (determinePasswordStrength(password.value.text) >= 3) {
        final AuthResponse registrationResult = await authService.registration(
          email.text,
          password.text,
        );
        if (registrationResult.success) {
          proceed();
        } else {
          try {
            registrationFormKey.value.currentState!.validate();
            if (registrationResult.info.isNotEmpty) {
              if ((json.decode(registrationResult.info.toString())
                      as Map<String, dynamic>)
                  .containsKey('email')) {
                error.value =
                    // ignore: avoid_dynamic_calls
                    jsonDecode(registrationResult.info.toString())['email'][0]
                        as String;
              }
              if ((json.decode(registrationResult.info.toString())
                      as Map<String, dynamic>)
                  .containsKey('password')) {
                error.value =
                    // ignore: avoid_dynamic_calls
                    jsonDecode(registrationResult.info.toString())['password']
                        [0] as String;
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

  Future<String> googleSignInPressed() async {
    loadingGoogle.value = true;
    error.value = '';
    final AuthResponse loginResult = await authService.googleSignIn();
    if (loginResult.success) {
      // TODO - Handle successful login
      // Google sign in should be working fine in the frontend - backend is not ready at the moment of writing this
      // The google sign in is only working in dev mode because the release signature hasn't been created yet
    } else {
      error.value = loginResult.info.toString();
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
      // TODO - Handle successful login
      // Apple sign in needs the client ID from the Appstore to work -> The app is not yet initialized in the store
      // The backend is not ready at the time of writing this
    } else {
      error.value = loginResult.info.toString();
    }
    loadingApple.value = false;
    return error.value;
  }

  Future<void> proceed() async {
    await Get.to<void>(
      () {
        showPopup(isBeneficiary: isBeneficiary);
        Get.to(
          () => isBeneficiary
              ? const BeneficiaryHomePage()
              : const DonorHomePage(),
        );
      },
    );
  }
}
