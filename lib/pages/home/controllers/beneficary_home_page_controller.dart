import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/need.dart';
import '../../../service/need_service.dart';
import '../../../service/user_state_service.dart';
import '../../../service/wallet_service.dart';
import '../../../util/popup_manager.dart';
import '../../create_new_need/wallet_instructions.dart';

enum NeedsTab { allNeeds, ongoing, past, draft }

class BeneficiaryHomePageController extends GetxController {
  PageController pageController = PageController();
  RxList<Need> needs = <Need>[].obs;
  RxList<Need> onGoingNeeds = <Need>[].obs;
  RxList<Need> draftNeeds = <Need>[].obs;
  RxList<Need> pastNeeds = <Need>[].obs;
  Rx<NeedsTab> currentTab = NeedsTab.allNeeds.obs;
  UserStateService userStateService = Get.find<UserStateService>();
  final RxString userNameForGreeting =
      Get.find<UserStateService>().user.value.name.split(' ')[0].obs;

  @override
  Future<void> onInit() async {
    // TODO

    //Get.find<UserStateService>().fetchUserInfo();
    //print(Get.find<UserStateService>().user.value);
    try {
      needs.value = await Get.find<NeedService>().getBeneficiaryNeeds();
    } catch (_) {
      // new beneficiaries have no needs and backend sends empty list - TODO handle this properly
    }
    filterList();
    super.onInit();
  }

  Future<void> onRefresh() async {
    try {
      needs.value = await Get.find<NeedService>().getBeneficiaryNeeds();

      await userStateService.fetchUserInfo();
      userNameForGreeting.value =
          userStateService.user.value.name.split(' ')[0];
      filterList();
      update();
    } catch (_) {
      // new beneficiaries have no needs and backend sends empty list - TODO handle this properly
    }
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

  String getGreetingMessage() {
    final int hour = DateTime.now().hour;

    if (hour >= 0 && hour < 12) {
      return 'Good morning'.tr;
    } else if (hour >= 12 && hour < 17) {
      return 'Good afternoon'.tr;
    } else {
      return 'Good evening'.tr;
    }
  }

  void filterList() {
    onGoingNeeds.clear();
    draftNeeds.clear();
    pastNeeds.clear();
    for (final Need need in needs) {
      if (need.status == NeedStatus.ongoing ||
          need.status == NeedStatus.published) {
        onGoingNeeds.add(need);
      } else if (need.status == NeedStatus.draft) {
        draftNeeds.add(need);
      } else if (need.status == NeedStatus.past) {
        pastNeeds.add(need);
      }
    }
  }

  void openStoryPopup() {
    if (Get.find<WalletService>().isWalletConnected.value) {
      unawaited(PopupManager.openStoryPopup());
    } else {
      unawaited(
        Get.to(
          const InstructionsPage(
            isDonation: false,
          ),
        ),
      );
    }
  }

  void selectTab(NeedsTab tab) {
    pageController.jumpToPage(
      tab.index,
    );
    currentTab.value = tab;
  }
}
