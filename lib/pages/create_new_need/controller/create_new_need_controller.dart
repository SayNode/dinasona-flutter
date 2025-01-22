import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../model/liquid_limits.dart';
import '../../../model/need.dart';
import '../../../service/breez_service.dart';
import '../../../service/currency_conversion_service.dart';
import '../../../service/localization_controller.dart';
import '../../../service/need_service.dart';
import '../../../service/user_state_service.dart';
import '../../../service/wallet_service.dart';
import '../../../util/popup_manager.dart';
import '../../root/controllers/beneficiary_root_controller.dart';
import '../../root/controllers/donor_root_page_controller.dart';
import '../wallet_instructions.dart';

enum NeedsTab { screen1, screen2, screen3, screen4, screen5 }

class CreateNewNeedController extends GetxController {
  CreateNewNeedController({this.need});
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
  DonorRootController donorRootController = Get.find<DonorRootController>();
  final Rx<File?> selectedImage = Rx<File?>(null);
  final Rx<File?> selectedImage2 = Rx<File?>(null);
  final RxBool isEditingNeed = false.obs;
  final RxInt editingNeedId = 0.obs;
  final RxBool canSaveNewNeed = true.obs;
  final RxString inboundError = ''.obs;

  LiquidLimitUserCurrency receivingLimitsInSatoshi =
      LiquidLimitUserCurrency(minUserCurrency: 0, maxUserCurrency: 0);

  Need? need;

  @override
  Future<void> onInit() async {
    super.onInit();
    screen1.addListener(() {
      isScreen1ButtonActive.value = screen1.text.isNotEmpty.obs.value;
    });
    screen3.addListener(() {
      checkInboundOutboundLimit();
      isScreen3ButtonActive.value =
          double.parse(screen3.text == '' ? '0' : screen3.text) > 0 &&
              !inboundError.value.isNotEmpty;
    });

    try {
      pageController.dispose();
    } catch (_) {}
    pageController = PageController();

    isEditingNeed.value = need != null;
    if (need != null) {
      editingNeedId.value = need!.id;

      final String tmpAmount = need!.amount == need!.amount.toInt()
          ? need!.amount.toInt().toString()
          : need!.amount.toString();

      final double userUSDCurrencyRate = 1 /
          await Get.find<CurrencyConversionService>()
              .fetchUserTargetCurrencyRate(
            'usd',
          );

      screen1.text = need!.title;
      screen3.text =
          (double.parse(tmpAmount) / userUSDCurrencyRate).toStringAsFixed(2);
      screen4.text = need!.description;
    }

    try {
      await Get.find<BreezService>().getBalanceInSatoshis();
    } catch (_) {
      // No wallet connected -> Is handled
    }
  }

  @override
  void onClose() {
    try {
      pageController.dispose();
    } catch (_) {}
    super.onClose();
  }

  void checkInboundOutboundLimit() {
    final double receiveUserCurrencyAmount =
        double.parse(screen3.text == '' ? '0' : screen3.text);

    if (receiveUserCurrencyAmount <= 0) {
      inboundError.value = '';
      return;
    }

    // Load inbound liquid limits
    receivingLimitsInSatoshi =
        Get.find<BreezService>().liquidSendReceiveLimitsInUserCurrency.receive;

    if (receiveUserCurrencyAmount <
            receivingLimitsInSatoshi.minUserCurrency - 0.01 ||
        receiveUserCurrencyAmount > receivingLimitsInSatoshi.maxUserCurrency) {
      inboundError.value =
          'Amount must be between ${Get.find<LocalizationController>().selectedCurrency.value.sign} ${receivingLimitsInSatoshi.minUserCurrency.toStringAsFixed(2)} and ${Get.find<LocalizationController>().selectedCurrency.value.sign} ${receivingLimitsInSatoshi.maxUserCurrency.toStringAsFixed(2)}'
              .tr;
    } else {
      inboundError.value = '';
    }
  }

  void initializePageController() {
    try {
      pageController.dispose();
    } catch (_) {}
    pageController = PageController();
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
    pageController.dispose();
    unawaited(Get.delete<CreateNewNeedController>());
    onClose();
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
    pageController.dispose();
    unawaited(Get.delete<CreateNewNeedController>());
    onClose();
  }

  Future<void> openCurrency({Widget? child}) async {
    await PopupManager.openCurrencyPopup();
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

  // Need amounts are always saved in USD
  // The frontend will convert it back to the user's currency
  Future<void> createNewNeed({bool isDraft = true}) async {
    final String areasOfInterest = selectedAreasOfInterest
        .map(
          (AreaOfInterest e) => e.title,
        )
        .toString()
        .replaceAll('(', '')
        .replaceAll(')', '');

    final double userUSDCurrencyRate = 1 /
        await Get.find<CurrencyConversionService>().fetchUserTargetCurrencyRate(
          'usd',
        );
    final double needAmountInUSD =
        double.parse(screen3.text) * userUSDCurrencyRate;

    await needService.createNewNeed(
      screen1.text,
      screen4.text,
      needAmountInUSD,
      areasOfInterest,
      isDraft: isDraft,
      images: <String>[
        if (selectedImage.value != null) selectedImage.value!.path,
        if (selectedImage2.value != null) selectedImage2.value!.path,
      ],
    );
  }

  void getToWalletScreen() {
    // Donor needs to Get.back() twice to get to the wallet screen
    if (userStateService.user.value.isDonor) {
      donorRootController.changeTabIndex(2);
      Get.back();

      if (Get.currentRoute.contains('DIALOG')) {
        // Get back a third time because the user is in a dialog
        // This is the case when the donor clicks on a category -> popup -> add wallet screen
        Get.back();
      }
    } else {
      beneficiaryRootController.changeTabIndex(2);
    }

    if (!Get.currentRoute.contains('BeneficiaryRootPage')) {
      Get.back();
    }

    onClose();
  }

  void deleteNeed(int id) {
    needService.deleteNeed(id);
  }

  Future<void> updateNeed(int id, bool isDraft) async {
    final double userUSDCurrencyRate = 1 /
        await Get.find<CurrencyConversionService>().fetchUserTargetCurrencyRate(
          'usd',
        );
    final double needAmountInUSD =
        double.parse(screen3.text) * userUSDCurrencyRate;

    final double currencyRateBTCvsUSD =
        await Get.find<CurrencyConversionService>()
            .fetchConversionRateBTCvsUSD();

    final int needAmountInSatoshi =
        (((1 / currencyRateBTCvsUSD) * needAmountInUSD) * 100000000).round();

    final String bolt11Invoice = await Get.find<BreezService>().createInvoice(
      'Need invoice ::client_invoice',
      needAmountInSatoshi,
    );

    await needService.updateNeed(id, <String, dynamic>{
      'title': screen1.text,
      'description': screen4.text,
      'amount': needAmountInUSD.toStringAsFixed(2),
      'bolt11Invoice': bolt11Invoice,
      'status': isDraft ? 'draft' : 'published',
    });
  }
}
