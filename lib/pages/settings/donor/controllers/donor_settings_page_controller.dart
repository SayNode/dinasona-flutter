import 'package:get/get.dart';

import '../../../../model/donor_statistics.dart';
import '../../../../model/user.dart';
import '../../../../service/user_state_service.dart';
import '../../../../widgets/dialogs/delete_account_dialog.dart';
import '../../../../widgets/dialogs/logout_dialog.dart';

class DonorSettingsPageController extends GetxController {
  final UserStateService _userStateService = Get.find();

  User get user => _userStateService.user.value;
  DonorStatistics get donorStatistics =>
      _userStateService.donorStatistics.value;

  void logout() {
    Get.dialog(const LogoutDialog());
  }

  void deleteAccount() {
    Get.dialog(const DeleteAccountDialog());
  }
}
