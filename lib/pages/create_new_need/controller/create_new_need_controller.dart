import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum NeedsTab { screen1, screen2, screen3, screen4, screen5 }

class CreateNewNeedController extends GetxController {
  RxInt currentPage = 0.obs;
  Rx<NeedsTab> currentTab = NeedsTab.screen1.obs;
  PageController pageController = PageController();
  TextEditingController screen1 = TextEditingController();
  final int descriptionMaxLenth = 300;

  void onTabChange(int value) {
    switch (value) {
      case 0:
        currentTab.value = NeedsTab.screen1;
      case 1:
        currentTab.value = NeedsTab.screen2;
      case 2:
        currentTab.value = NeedsTab.screen3;
      case 3:
        currentTab.value = NeedsTab.screen4;
      case 4:
        currentTab.value = NeedsTab.screen5;
    }
  }

  void selectTab(NeedsTab tab) {
    pageController.jumpToPage(
      tab.index,
    );
    currentTab.value = tab;
  }
}
