import 'package:get/get.dart';

import '../../../model/user.dart';
import '../../../service/user_state_service.dart';
import '../../../util/popup_manager.dart';

class DonorSettingsPageController extends GetxController {
  final UserStateService _userStateService = Get.find();

  User get user => _userStateService.user.value;

  void logout() {
    PopupManager.openLogoutPopup();
  }

  void deleteAccount() {
    PopupManager.openDeleteAccountPopup();
  }
}
