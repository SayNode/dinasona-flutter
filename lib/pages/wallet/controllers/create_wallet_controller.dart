import 'dart:math';

import 'package:get/get.dart';

import '../../../service/storage/secure_storage_service.dart';
import '../../../service/user_state_service.dart';
import '../../../util/popup_manager.dart';
import '../../../util/util.dart';
import '../../root/beneficiary_root_page.dart';
import '../../root/donor_root_page.dart';
import 'wallet_page_controller.dart';

class CreateWalletController extends GetxController {
  final SecureStorageService secureStorageService =
      Get.find<SecureStorageService>();
  final WalletPageController controller = Get.find<WalletPageController>();
  RxString seedPhrase = ''.obs;
  RxBool userHasEnteredSeedPhrase = false.obs;
  RxBool seedPhraseShuffeled = false.obs;

  RxList<String> seedPhraseList = <String>[].obs;
  RxList<String> mixedSeedPhrase = <String>[].obs;
  RxSet<int> uniqueSeedPhraseIndexes = <int>{}.obs;
  RxList<int> randomSeedPhraseIndexes = <int>[].obs;
  RxList<String> seedPhraseChecks = <String>[].obs;
  final Random randomNumber = Random();

  void setupSeedPhraseCheck() {
    seedPhraseList.value = seedPhrase.split(' ');
    mixedSeedPhrase.value = seedPhrase.split(' ')..shuffle();
    uniqueSeedPhraseIndexes.clear();

    while (uniqueSeedPhraseIndexes.length < 3) {
      uniqueSeedPhraseIndexes.add(randomNumber.nextInt(mixedSeedPhrase.length));
    }

    randomSeedPhraseIndexes.value = uniqueSeedPhraseIndexes.toList();

    seedPhraseChecks.value = <String>[
      seedPhraseList[randomSeedPhraseIndexes[0]],
      seedPhraseList[randomSeedPhraseIndexes[1]],
      seedPhraseList[randomSeedPhraseIndexes[2]],
    ];

    seedPhraseShuffeled.value = true;
  }

  void updateUserInputs() {
    userHasEnteredSeedPhrase.value =
        !(controller.seedConfirmationInput1.text.isNotEmpty &&
            controller.seedConfirmationInput2.text.isNotEmpty &&
            controller.seedConfirmationInput3.text.isNotEmpty);
  }

  Future<void> createWallet() async {
    if (Get.context != null) {
      showLoadingDialog(Get.context!);
    }
    await controller.clearWalletEnvironment();
    await controller.breezService.connectToNode(seedPhrase.value);
    await Get.find<UserStateService>().fetchUserInfo();
    await secureStorageService.writeString(
      'walletSeedPhrase${Get.find<UserStateService>().user.value.email}',
      seedPhrase.value,
    );

    if (Get.context != null) {
      hideLoadingDialog(Get.context!);
    }

    controller.isWalletConnected.value = true;

    Future<void>.delayed(const Duration(milliseconds: 1000), () {
      PopupManager.openWalletInfoPopup(
        'Success!'.tr,
        'Your wallet has been successfully created. You can now access and manage your assets.'
            .tr,
      );
    });

    await Get.to<void>(
      () => Get.find<UserStateService>().user.value.isDonor
          ? const DonorRootPage()
          : const BeneficiaryRootPage(),
    );
  }

  void validateSeedPhrase() {
    if (seedPhraseChecks[0].toLowerCase() !=
            controller.seedConfirmationInput1.text.toLowerCase() ||
        seedPhraseChecks[1].toLowerCase() !=
            controller.seedConfirmationInput2.text.toLowerCase() ||
        seedPhraseChecks[2].toLowerCase() !=
            controller.seedConfirmationInput3.text.toLowerCase()) {
      Future<void>.delayed(const Duration(milliseconds: 500), () {
        PopupManager.openWalletInfoPopup(
          'Invalid seed phrase'.tr,
          "Couldn't find a wallet with that seed phrase, please enter the correct seed phrase or create new wallet"
              .tr,
        );
      });

      return;
    }

    setupSeedPhraseCheck();
    createWallet();
  }
}
