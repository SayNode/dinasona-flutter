import 'dart:async';

import 'package:get/get.dart';

import '../../../model/auth_response.dart';
import '../../../pages/choose_path_page.dart';
import '../../../pages/error/error_page.dart';
import '../../../pages/root/beneficiary_root_page.dart';
import '../../../pages/root/donor_root_page.dart';
import '../../../service/auth_service.dart';
import '../../../service/user_state_service.dart';

class GoogleAppleSignInController {
  RxBool loadingGoogle = false.obs;
  RxBool loadingApple = false.obs;
  RxString error = ''.obs;

  final AuthService authService = Get.put(AuthService());

  Future<String> googleSignInPressed(
    bool isBeneficiary,
    bool isRegistration,
  ) async {
    loadingGoogle.value = true;
    error.value = '';
    final UserStateService userStateService = Get.find<UserStateService>();
    final AuthResponse loginResult = await authService.googleSignIn();
    if (loginResult.success) {
      await userStateService.init();
      if (loginResult.result['is_signup'] as bool) {
        unawaited(Get.to(() => const ChoosePathPage()));
      } else {
        if (userStateService.user.value.isDonor) {
          unawaited(Get.to(() => const DonorRootPage()));
        } else {
          unawaited(Get.to(() => const BeneficiaryRootPage()));
        }
      }
    } else {
      if (loginResult.status == -1) {
        loadingGoogle.value = false;
        return 'Google sign in cancelled';
      }
      //TODO: Handle error
      unawaited(Get.to(() => const ErrorPage(error: 'Google sign in failed')));
    }
    loadingGoogle.value = false;
    return error.value;
  }

  Future<String> appleSignInPressed(
    bool isBeneficiary,
    bool isRegistration, {
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
      if (isRegistration) {
        await Get.find<UserStateService>().updateUserInfo(<String, dynamic>{
          'is_donor': !isBeneficiary,
        });
      }

      if (isBeneficiary) {
        // Change this to a dynamic country code
        await Get.find<UserStateService>().createBeneficiaryInstance();
      }

      unawaited(
        Get.to(
          () => Get.find<UserStateService>().user.value.isDonor
              ? const DonorRootPage()
              : const BeneficiaryRootPage(),
        ),
      );
    } else {
      if (loginResult.status == -1) {
        loadingApple.value = false;
        return 'Apple sign in cancelled';
      }
      //TODO: Handle error
      unawaited(
        Get.to(() => const ErrorPage(error: 'Apple sign in failed')),
      );
    }
    loadingApple.value = false;
    return error.value;
  }
}
