import 'dart:async';

import 'package:get/get.dart';

import 'dart:math';

import '../../../service/breez_service.dart';
import '../../../service/logger_service.dart';
import '../../../service/storage/secure_storage_service.dart';
import '../../../service/user_state_service.dart';
import '../../../service/wallet_service.dart';
import '../../../util/popup_manager.dart';
import '../../../util/util.dart';
import '../../root/beneficiary_root_page.dart';
import '../../root/donor_root_page.dart';
import 'wallet_page_controller.dart';

class CreateWalletController extends GetxController {
  final LoggerService loggerService = Get.find<LoggerService>();
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

  final RxInt seedPhraseTapIndex = 0.obs;
  final List<RxString> seedConfirmationInputs =
      <RxString>[''.obs, ''.obs, ''.obs].obs;

  void onSeedPhraseTap(String word) {
    if (seedPhraseTapIndex.value == 0) {
      seedConfirmationInputs[0].value = word;
      seedPhraseTapIndex.value++;
    } else if (seedPhraseTapIndex.value == 1) {
      seedConfirmationInputs[1].value = word;
      seedPhraseTapIndex.value++;
    } else if (seedPhraseTapIndex.value == 2) {
      seedConfirmationInputs[2].value = word;
      seedPhraseTapIndex.value = 0;
    }
  }

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

  void resetWalletConnectionInputs() {
    seedConfirmationInputs[0].value = '';
    seedConfirmationInputs[1].value = '';
    seedConfirmationInputs[2].value = '';
  }

  void updateUserInputs() {
    userHasEnteredSeedPhrase.value =
        !(seedConfirmationInputs[0].value.isNotEmpty &&
            seedConfirmationInputs[1].value.isNotEmpty &&
            seedConfirmationInputs[2].value.isNotEmpty);
  }

  Future<void> createWallet() async {
    if (Get.context != null) {
      showLoadingDialog(Get.context!);
    }
    loggerService.log('Creating wallet');
    try {
      await walletService.clearWalletEnvironment();
      await breezService.connectToLiquid(seedPhrase.value);
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

      unawaited(
        Get.offAll<void>(
          () => Get.find<UserStateService>().user.value.isDonor
              ? const DonorRootPage()
              : const BeneficiaryRootPage(),
        ),
      );
    } catch (e) {
      loggerService.log('Wallet creation failed: $e');
      Future<void>.delayed(const Duration(milliseconds: 1000), () {
        PopupManager.openWalletInfoPopup(
          'Failed to create wallet'.tr,
          'The wallet creation was unsuccessful.  Double-check your details and try again, or create a new wallet if necessary to proceed.'
              .tr,
        );
      });
      if (Get.context != null) {
        hideLoadingDialog(Get.context!);
      }
    }
  }

  void validateSeedPhrase() {
    if (seedPhraseChecks[0].toLowerCase() !=
            seedConfirmationInputs[0].value.toLowerCase() ||
        seedPhraseChecks[1].toLowerCase() !=
            seedConfirmationInputs[1].value.toLowerCase() ||
        seedPhraseChecks[2].toLowerCase() !=
            seedConfirmationInputs[2].value.toLowerCase()) {
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
