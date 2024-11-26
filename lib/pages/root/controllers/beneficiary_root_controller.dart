import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../service/get_location_service.dart';
import '../../../service/user_state_service.dart';
import '../../../widgets/beneficiary_bottom_navigation_bar.dart';

class BeneficiaryRootController extends GetxController {
  final RxInt tabIndex = 0.obs;
  final List<Widget> body =
      BeneficaryItem.values.map((BeneficaryItem e) => e.page).toList();
  final RxString country = ''.obs;
  final UserStateService userStateService = Get.find<UserStateService>();

  // ignore: use_setters_to_change_properties
  void changeTabIndex(int index) {
    tabIndex.value = index;
  }

  @override
  Future<void> onInit() async {
    if (userStateService.user.value.beneficiary.country.isEmpty) {
      final Map<String, String> location = await getLocationFromIP();
      country.value = location['country']!;
      await userStateService.updateBeneficiaryInfo(
        <String, dynamic>{
          'country': country.value,
        },
      );
      userStateService.user.refresh();
    }

    super.onInit();
  }
}
