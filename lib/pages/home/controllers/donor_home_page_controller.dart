import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/need.dart';
import '../../../util/mock_data.dart';
import '../../../util/popup_manager.dart';

class DonorHomePageController extends GetxController {
  RxList<NeedField> selectedNeedFields = <NeedField>[].obs;
  RxList<Need> recommendedDonations = <Need>[].obs;

  @override
  Future<void> onInit() async {
    selectedNeedFields.addAll(NeedField.values.take(2));
    // TODO - Get needs from backend
    recommendedDonations.addAll(MockData.needs);
    super.onInit();
  }

  Future<void> openExploreMore({Widget? child}) async {
    final List<NeedField>? temp = await PopupManager.openSelectNeedFieldsPopup(
      selectedNeedFields,
    );
    if (temp != null) {
      selectedNeedFields.value = temp;
    }
  }

  Future<void> seeAll(NeedField? field) async {}
}
