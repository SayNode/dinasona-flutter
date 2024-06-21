import 'package:get/get.dart';

import '../../../model/user.dart';
import '../../../service/user_state_service.dart';

class DonorSettingsPageController extends GetxController {
  final UserStateService _userStateService = Get.find();

  User get user => _userStateService.user.value;
}
