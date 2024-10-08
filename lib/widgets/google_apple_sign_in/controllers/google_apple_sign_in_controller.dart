import 'package:get/get.dart';

import '../../../model/auth_response.dart';
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
    final AuthResponse loginResult = await authService.googleSignIn();
    if (loginResult.success) {
      if (isRegistration) {
        await Get.find<UserStateService>().updateUserInfo(<String, dynamic>{
          'is_donor': !isBeneficiary,
        });
      }

      await Get.to(
        () => Get.find<UserStateService>().user.value.isDonor
            ? const DonorRootPage()
            : const BeneficiaryRootPage(),
      );
    } else {
      //TODO: Handle error
      await Get.to(() => const ErrorPage(error: 'Google sign in failed'));
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

      await Get.to(
        () => Get.find<UserStateService>().user.value.isDonor
            ? const DonorRootPage()
            : const BeneficiaryRootPage(),
      );
    } else {
      //TODO: Handle error
      await Get.to(() => const ErrorPage(error: 'Apple sign in failed'));
    }
    loadingApple.value = false;
    return error.value;
  }
}
