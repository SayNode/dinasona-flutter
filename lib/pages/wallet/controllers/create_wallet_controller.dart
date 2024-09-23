import 'package:get/get.dart';

import '../../../util/popup_manager.dart';
import '../../../util/util.dart';
import '../../root/donor_root_page.dart';
import 'wallet_page_controller.dart';

class CreateWalletController extends GetxController {
  final WalletPageController controller = Get.find<WalletPageController>();
  RxString seedPhrase = ''.obs;
  RxBool userHasEnteredSeedPhrase = false.obs;

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

    await Get.to(() => const DonorRootPage());
  }

  void validateSeedPhrase(List<String> expectedValues) {
    if (expectedValues[0].toLowerCase() !=
            controller.seedConfirmationInput1.text.toLowerCase() ||
        expectedValues[1].toLowerCase() !=
            controller.seedConfirmationInput2.text.toLowerCase() ||
        expectedValues[2].toLowerCase() !=
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

    createWallet();
  }
}
