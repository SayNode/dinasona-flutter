import 'package:get/get.dart';

import '../../../../model/donor_statistics.dart';
import '../../../../model/user.dart';
import '../../../../service/get_location_service.dart';
import '../../../../service/user_state_service.dart';
import '../../../../util/popup_manager.dart';

class DonorSettingsPageController extends GetxController {
  final UserStateService _userStateService = Get.find();
  final RxString country = ''.obs;

  User get user => _userStateService.user.value;
  DonorStatistics get donorStatistics =>
      _userStateService.donorStatistics.value;

  Future<void> refreshPage() async {
    // Fetch the latest beneficiary statistics
    await _userStateService.fetchDonorStatistics();
    // Fetch the latest user information
    await _userStateService.fetchUserInfo();
    // Update the UI if necessary
    update();
  }

  @override
  Future<void> onInit() async {
    if (_userStateService.user.value.country.isEmpty) {
      final Map<String, String> location = await getLocationFromIP();
      country.value = location['country']!;
      await _userStateService.updateUserInfo(
        <String, dynamic>{
          'country': country.value,
        },
      );
      _userStateService.user.refresh();
    }

    super.onInit();
  }

  void logout() {
    PopupManager.openLogoutPopup();
  }

  void deleteAccount() {
    PopupManager.openDeleteAccountPopup();
  }
}
