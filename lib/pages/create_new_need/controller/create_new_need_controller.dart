import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../model/need.dart';
import '../../../service/need_service.dart';
import '../../../service/user_state_service.dart';
import '../../../util/popup_manager.dart';

enum NeedsTab { screen1, screen2, screen3, screen4, screen5 }

class CreateNewNeedController extends GetxController {
  RxInt currentPage = 0.obs;
  Rx<NeedsTab> currentTab = NeedsTab.screen1.obs;
  PageController pageController = PageController();
  TextEditingController screen1 = TextEditingController();
  TextEditingController screen3 = TextEditingController();
  TextEditingController screen4 = TextEditingController();
  RxBool isScreen1ButtonActive = false.obs;
  RxBool isScreen3ButtonActive = false.obs;
  RxList<AreaOfInterest> selectedAreasOfInterest = <AreaOfInterest>[].obs;
  NeedService needService = Get.find<NeedService>();
  UserStateService userStateService = Get.find<UserStateService>();
  final int descriptionMaxLenth = 300;

  final Rx<File?> selectedImage = Rx<File?>(null);
  final Rx<File?> selectedImage2 = Rx<File?>(null);

  @override
  void onInit() {
    super.onInit();
    screen1.addListener(() {
      isScreen1ButtonActive.value = screen1.text.isNotEmpty.obs.value;
    });
    screen3.addListener(() {
      isScreen3ButtonActive.value = screen3.text.isNotEmpty.obs.value;
    });
  }

  Future<void> pickImage(ImageSource source, Rx<File?> image) async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      image.value = File(pickedFile.path);
    }
  }

  void onTapdraftButton() {
    createNewNeed('draft');
    PopupManager.openDraftPopup();
  }

  void onTapPublishButton() {
    createNewNeed('published');
    PopupManager.openPublishPopup();
  }

  Future<void> openCurrency({Widget? child}) async {
    final List<AreaOfInterest>? temp = await PopupManager.openCurrencyPopup(
      selectedAreasOfInterest,
    );
    if (temp != null) {
      selectedAreasOfInterest.value = temp;
    }
  }

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

  void createNewNeed(String status) {
    needService.createNewNeed(
      screen1.text,
      screen4.text,
      screen3.text,
      status,
      <int>[1],
    );
  }
}
