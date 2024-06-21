import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../model/need.dart';
import '../../../util/popup_manager.dart';

enum NeedsTab { screen1, screen2, screen3, screen4, screen5 }

class CreateNewNeedController extends GetxController {
  RxInt currentPage = 0.obs;
  Rx<NeedsTab> currentTab = NeedsTab.screen1.obs;
  PageController pageController = PageController();
  TextEditingController screen1 = TextEditingController();
  TextEditingController screen3 = TextEditingController();
  RxBool isScreen1ButtonActive = false.obs;
  RxBool isScreen3ButtonActive = false.obs;
  RxList<NeedField> selectedNeedFields = <NeedField>[].obs;
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
    PopupManager.openDraftPopup();
  }

  void onTapPublishButton() {
    PopupManager.openPublishPopup();
  }

  Future<void> openCurrency({Widget? child}) async {
    final List<NeedField>? temp = await PopupManager.openCurrencyPopup(
      selectedNeedFields,
    );
    if (temp != null) {
      selectedNeedFields.value = temp;
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
}
