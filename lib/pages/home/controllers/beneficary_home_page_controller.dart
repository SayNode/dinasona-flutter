import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/need.dart';
import '../../../util/mock_data.dart';
import '../../../util/popup_manager.dart';

enum NeedsTab { allNeeds, ongoing, past, draft }

class BeneficiaryHomePageController extends GetxController {
  PageController pageController = PageController();
  RxList<Need> needs = <Need>[].obs;
  Rx<NeedsTab> currentTab = NeedsTab.allNeeds.obs;

  @override
  void onInit() {
    needs.addAll(MockData.needs);
    super.onInit();
  }

  void onTabChange(int value) {
    switch (value) {
      case 0:
        currentTab.value = NeedsTab.allNeeds;
      case 1:
        currentTab.value = NeedsTab.ongoing;
      case 2:
        currentTab.value = NeedsTab.past;
      case 3:
        currentTab.value = NeedsTab.draft;
    }
  }

  void openStoryPopup() {
    PopupManager.openStoryPopup();
  }

  void selectTab(NeedsTab tab) {
    pageController.jumpToPage(
      tab.index,
    );
    currentTab.value = tab;
  }
}
