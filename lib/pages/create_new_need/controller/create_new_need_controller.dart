import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../model/need.dart';
import '../../../service/breez_service.dart';
import '../../../service/currency_conversion_service.dart';
import '../../../service/need_service.dart';
import '../../../service/user_state_service.dart';
import '../../../service/wallet_service.dart';
import '../../../util/popup_manager.dart';
import '../../root/controllers/beneficiary_root_controller.dart';
import '../wallet_instructions.dart';

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
  bool isloading = false;
  RxList<AreaOfInterest> selectedAreasOfInterest = <AreaOfInterest>[].obs;
  WalletService walletService = Get.find<WalletService>();
  NeedService needService = Get.find<NeedService>();
  UserStateService userStateService = Get.find<UserStateService>();
  final int descriptionMaxLenth = 300;
  BeneficiaryRootController beneficiaryRootController =
      Get.find<BeneficiaryRootController>();
  final Rx<File?> selectedImage = Rx<File?>(null);
  final Rx<File?> selectedImage2 = Rx<File?>(null);
  final RxBool isEditingNeed = false.obs;
  final RxInt editingNeedId = 0.obs;

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

  Future<void> onTapdraftButton() async {
    if (isloading) return;
    isloading = true;
    if (!isEditingNeed.value) {
      if (walletService.isWalletConnected.value) {
        await createNewNeed();
      } else {
        unawaited(
          Get.to(
            const InstructionsPage(
              isDonation: false,
            ),
          ),
        );
      }
    } else {
      await updateNeed(editingNeedId.value, true);
    }
    unawaited(PopupManager.openDraftPopup());
  }

  Future<void> onTapPublishButton() async {
    if (isloading) return;
    isloading = true;
    if (!isEditingNeed.value) {
      await createNewNeed(isDraft: false);
    } else {
      await updateNeed(editingNeedId.value, false);
    }
    unawaited(PopupManager.openPublishPopup());
  }

  Future<void> openCurrency({Widget? child}) async {
    final List<AreaOfInterest>? temp = await PopupManager.openCurrencyPopup(
      selectedAreasOfInterest,
    );
    if (temp != null) {
      selectedAreasOfInterest.value = temp;
    }
  }

  void onSelectAreaOfInterest(AreaOfInterest field) {
    if (selectedAreasOfInterest.contains(field)) {
      selectedAreasOfInterest.remove(field);
    } else {
      selectedAreasOfInterest.add(field);
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

  Future<void> createNewNeed({bool isDraft = true}) async {
    final String areasOfInterest = selectedAreasOfInterest
        .map(
          (AreaOfInterest e) => e.title,
        )
        .toString()
        .replaceAll('(', '')
        .replaceAll(')', '');
    await needService.createNewNeed(
      screen1.text,
      screen4.text,
      screen3.text,
      areasOfInterest,
      isDraft: isDraft,
      images: <String>[
        if (selectedImage.value != null) selectedImage.value!.path,
        if (selectedImage2.value != null) selectedImage2.value!.path,
      ],
    );
  }

  void getToWalletScreen() {
    Get.back();
    beneficiaryRootController.changeTabIndex(2);
  }

  void deleteNeed(int id) {
    needService.deleteNeed(id);
  }

  Future<void> updateNeed(int id, bool isDraft) async {
    final int needAmountInSatoshi =
        ((await Get.find<CurrencyConversionService>()
                    .convertUserCurrencyToBitcoin(double.parse(screen3.text))) *
                100000000)
            .toInt();
    final String bolt11Invoice = await Get.find<BreezService>().createInvoice(
      'Need invoice ::client_invoice',
      needAmountInSatoshi,
    );

    await needService.updateNeed(id, <String, dynamic>{
      'title': screen1.text,
      'description': screen4.text,
      'amount': screen3.text,
      'bolt11Invoice': bolt11Invoice,
      'status': isDraft ? 'draft' : 'published',
    });
  }
}
