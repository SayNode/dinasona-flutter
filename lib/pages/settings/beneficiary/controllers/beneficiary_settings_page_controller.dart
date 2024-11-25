import 'package:get/get.dart';

import '../../../../model/beneficiary_statistics.dart';
import '../../../../model/user.dart';
import '../../../../service/user_state_service.dart';
import '../../../../util/popup_manager.dart';

class BeneficiarySettingsPageController extends GetxController {
  final UserStateService _userStateService = Get.find<UserStateService>();

  BeneficiaryStatistics get beneficiaryStatistics => _userStateService.beneficiaryStatistics.value;

  User get user => _userStateService.user.value;

  void logout() {
    PopupManager.openLogoutPopup();
  }

  void deleteAccount() {
    PopupManager.openDeleteAccountPopup();
  }

  Future<void> refreshPage() async {
    // Fetch the latest beneficiary statistics
    await _userStateService.fetchBeneficiaryStatistics();
    // Fetch the latest user information
    await _userStateService.fetchBeneficiaryInfo();
    // Update the UI if necessary
    update();
  }
}
