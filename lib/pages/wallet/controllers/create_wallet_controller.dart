import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'dart:math';

import '../../../service/breez_service.dart';
import '../../../service/storage/secure_storage_service.dart';
import '../../../service/user_state_service.dart';
import '../../../service/wallet_service.dart';
import '../../../util/popup_manager.dart';
import '../../../util/util.dart';
import '../../root/beneficiary_root_page.dart';
import '../../root/donor_root_page.dart';
import 'wallet_page_controller.dart';

class CreateWalletController extends GetxController {
  final SecureStorageService secureStorageService =
      Get.find<SecureStorageService>();
  final WalletService walletService = Get.find<WalletService>();
  final BreezService breezService = Get.find<BreezService>();

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

  final TextEditingController seedConfirmationInput1 = TextEditingController();
  final TextEditingController seedConfirmationInput2 = TextEditingController();
  final TextEditingController seedConfirmationInput3 = TextEditingController();

  void resetWalletConnectionInputs() {
    seedConfirmationInput1.clear();
    seedConfirmationInput2.clear();
    seedConfirmationInput3.clear();
  }

  void updateUserInputs() {
    userHasEnteredSeedPhrase.value = !(seedConfirmationInput1.text.isNotEmpty &&
        seedConfirmationInput2.text.isNotEmpty &&
        seedConfirmationInput3.text.isNotEmpty);
  }

  Future<void> createWallet() async {
    if (Get.context != null) {
      showLoadingDialog(Get.context!);
    }
    await walletService.clearWalletEnvironment();
    await breezService.connectToNode(seedPhrase.value);
    await Get.find<UserStateService>().fetchUserInfo();
    await secureStorageService.writeString(
      'walletSeedPhrase${Get.find<UserStateService>().user.value.email}',
      seedPhrase.value,
    );

    if (Get.context != null) {
      hideLoadingDialog(Get.context!);
    }

    walletService.isWalletConnected.value = true;

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
            seedConfirmationInput1.text.toLowerCase() ||
        seedPhraseChecks[1].toLowerCase() !=
            seedConfirmationInput2.text.toLowerCase() ||
        seedPhraseChecks[2].toLowerCase() !=
            seedConfirmationInput3.text.toLowerCase()) {
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
