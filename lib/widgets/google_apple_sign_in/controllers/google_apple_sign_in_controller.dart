import 'package:get/get.dart';

import '../../../model/auth_response.dart';
import '../../../service/auth_service.dart';

class GoogleAppleSignInController {
  RxBool loadingGoogle = false.obs;
  RxBool loadingApple = false.obs;
  RxString error = ''.obs;

  final AuthService authService = Get.put(AuthService());

  Future<String> googleSignInPressed() async {
    loadingGoogle.value = true;
    error.value = '';
    final AuthResponse loginResult = await authService.googleSignIn();
    if (loginResult.success) {
      // TODO - Handle successful login
      // Google sign in should be working fine in the frontend - backend is not ready at the moment of writing this
      // The google sign in is only working in dev mode because the release signature hasn't been created yet
    } else {
      //TODO: Handle error
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
      //TODO: Handle error
    }
    loadingApple.value = false;
    return error.value;
  }
}
