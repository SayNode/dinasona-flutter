import 'package:get/get.dart';

import '../../../../model/beneficiary_statistics.dart';
import '../../../../model/user.dart';
import '../../../../service/user_state_service.dart';
import '../../../../widgets/dialogs/delete_account_dialog.dart';
import '../../../../widgets/dialogs/logout_dialog.dart';

class BeneficiarySettingsPageController extends GetxController {
  final UserStateService _userStateService = Get.find<UserStateService>();

  BenbeficiaryStatistics get beneficiaryStatistics =>
      _userStateService.beneficiaryStatistics.value;

  User get user => _userStateService.user.value;

  void logout() {
    Get.dialog(const LogoutDialog());
  }

  void deleteAccount() {
    Get.dialog(const DeleteAccountDialog());
  }
}
