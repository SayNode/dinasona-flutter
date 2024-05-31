/* import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';

import '../../../service/auth_service.dart';
import '../../../service/storage_service.dart';
import '../../../service/user_state_service.dart';
import '../../sign_up/controller/sign_up_controller.dart';

class LoginController extends GetxController {
  RxBool showPassword = false.obs;
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final AuthService authService = Get.find<AuthService>();
  final StorageService storageService = Get.find<StorageService>();
  final SignupController signupController = Get.put(SignupController());
  RxString emailError = ''.obs;
  RxString passwordError = ''.obs;
  RxString usernameError = ''.obs;
  RxString nonFieldError = ''.obs;
  RxString platformError = ''.obs;
  final LocalAuthentication auth = LocalAuthentication();
  RxBool loading = false.obs;

  String get storedEmail => storageService.contents.email;

  Future<void> checkExisting() async {
    loading.value = true;
    if (storageService.contents.provider == ProviderTypes.email) {
      unawaited(checkBiometricLogin());
    } else if (storageService.contents.provider == ProviderTypes.google) {
      platformError.value = await signupController.googleSignInPressed();
    } else if (storageService.contents.provider == ProviderTypes.apple) {
      platformError.value = await signupController.appleSignInPressed(
        authorizationCode: storageService.contents.authorizationCode,
        identityToken: storageService.contents.identityToken,
      );
    }
    signupController.error.value = '';
    loading.value = false;
  }

  void reset() {
    emailError.value = '';
    passwordError.value = '';
    usernameError.value = '';
    nonFieldError.value = '';
    emailController.clear();
    passwordController.clear();
    showPassword.value = false;
    signupController.error.value = '';
  }

  void setShowPassword() {
    showPassword.value = !showPassword.value;
  }

  bool isBiometricsEnabled() {
    return storageService.contents.biometrics && storageService.isUserInStorage;
  }

  Future<bool> _biometricLogin() async {
    if (isBiometricsEnabled()) {
      LegacyConstants.logger.log('biometric login enabled');

      final bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;

      final List<BiometricType> availableBiometricList =
          await auth.getAvailableBiometrics();

      if (canAuthenticateWithBiometrics && availableBiometricList.isNotEmpty) {
        try {
          final bool isAuthenticated = await auth.authenticate(
            localizedReason: 'Please authenticate.',
            options: const AuthenticationOptions(
              stickyAuth: true,
              biometricOnly: true,
            ),
          );
          if (isAuthenticated) {
            if (isAuthenticated) {
              await loginPressed(
                storageService.contents.email,
                storageService.contents.password,
              );
            }
          }

          return true;
        } catch (e) {
          return false;
        }
      }
      return false;
    }
    return false;
  }

  Future<bool> checkBiometricLogin() async {
    loading.value = true;
    final bool ret = await _biometricLogin();
    loading.value = false;
    return ret;
  }

  Future<void> loginPressed(String email, String password) async {
    loading.value = true;
    final AuthResponse loginResult = await authService.login(email, password);
    if (loginResult.success) {
      if (Get.find<UserStateService>().userInfo.value.onBoardingFinished) {
        Get.find<RoutingService>().redirect(isAfterLogin: true);
      } else {
        await finishCustomization();
      }
      reset();
    } else {
      if (authService.loginError.isNotEmpty) {
        if ((json.decode(authService.loginError) as Map<String, dynamic>)
            .containsKey('email')) {
          emailError.value = List<String>.from(
            (jsonDecode(authService.loginError)
                as Map<String, dynamic>)['email'] as List<dynamic>,
          )[0];
        } else {
          emailError.value = '';
        }
        if ((json.decode(authService.loginError) as Map<String, dynamic>)
            .containsKey('password')) {
          passwordError.value = List<String>.from(
            (jsonDecode(authService.loginError)
                as Map<String, dynamic>)['password'] as List<dynamic>,
          )[0];
        } else {
          passwordError.value = '';
        }
        if ((json.decode(authService.loginError) as Map<String, dynamic>)
            .containsKey('username')) {
          usernameError.value = List<String>.from(
            (jsonDecode(authService.loginError)
                as Map<String, dynamic>)['username'] as List<dynamic>,
          )[0];
        } else {
          usernameError.value = '';
        }
        if ((json.decode(authService.loginError) as Map<String, dynamic>)
            .containsKey('non_field_errors')) {
          nonFieldError.value = List<String>.from(
            (jsonDecode(authService.loginError)
                as Map<String, dynamic>)['non_field_errors'] as List<dynamic>,
          )[0];
        } else {
          nonFieldError.value = '';
        }
      }
    }
    loading.value = false;
  }
}
 */