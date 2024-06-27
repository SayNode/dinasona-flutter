import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/need.dart';
import '../../../util/mock_data.dart';
import '../../../util/popup_manager.dart';
import '../need_search_page.dart';

class DonorHomePageController extends GetxController {
  RxList<NeedField> favoriteFields = <NeedField>[].obs;
  RxList<Need> recommendedDonations = <Need>[].obs;

  @override
  Future<void> onInit() async {
    // TODO - Get favorite fields from backend
    favoriteFields.addAll(NeedField.values.take(2));
    // TODO - Get needs from backend

    recommendedDonations.addAll(MockData.needs);
    super.onInit();
  }

  Future<void> openExploreMore({Widget? child}) async {
    final List<NeedField>? fields =
        await PopupManager.openSelectNeedFieldsPopup(
      favoriteFields,
    );
    if (fields != null) {
      unawaited(
        Get.to<void>(
          () => NeedSearchPage(fields: fields),
        ),
      );
    }
  }

  Future<void> seeAll(NeedField? field) async {}
}
