import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../service/logger_service.dart';
import '../../../service/user_state_service.dart';
import '../../../service/wallet_service.dart';
import '../../../util/popup_manager.dart';
import '../../../util/util.dart';
import '../../root/beneficiary_root_page.dart';
import '../../root/donor_root_page.dart';
import 'wallet_page_controller.dart';

class ImportWalletController extends GetxController {
  final WalletPageController controller = Get.find<WalletPageController>();
  final LoggerService loggerService = Get.find<LoggerService>();
  final RxString seedImportErrorMessage = ''.obs;
  final RxList<String> reactiveImportSeedInputs = <String>[''].obs;
  List<TextEditingController> importSeedInputs =
      List<TextEditingController>.generate(12, (_) => TextEditingController());

  @override
  void onInit() {
    super.onInit();

    importSeedInputs = List<TextEditingController>.generate(
      12,
      (_) => TextEditingController(),
    );
  }

  Future<void> importWallet(
    String seedPhrase,
  ) async {
    if (Get.context != null) {
      showLoadingDialog(Get.context!);
    }
    await controller.clearWalletEnvironment();
    try {
      loggerService.log('Importing wallet');

      final dynamic connectionResult =
          await controller.breezService.connectToNode(
        seedPhrase,
      );

      if (connectionResult == 'invalid word in phrase' ||
          connectionResult == 'invalid checksum') {
        if (Get.context != null) {
          hideLoadingDialog(Get.context!);
        }
        seedImportErrorMessage.value = connectionResult as String;
        return;
      }

      Get.find<WalletService>().createWalletFromSeedWords(
        'password',
        seedPhrase.split(' '),
      );

      if (Get.context != null) {
        hideLoadingDialog(Get.context!);
      }

      controller.isWalletConnected.value = true;
      loggerService.log('Wallet successfully imported');

      Future<void>.delayed(const Duration(milliseconds: 1000), () {
        PopupManager.openWalletInfoPopup(
          'Wallet successfully imported!'.tr,
          'Your wallet has been successfully imported. You can now access your account and manage your assets securely.'
              .tr,
        );
      });
      await Get.to(
        () => Get.find<UserStateService>().user.value.isDonor
            ? const DonorRootPage()
            : const BeneficiaryRootPage(),
      );
    } catch (e) {
      Future<void>.delayed(const Duration(milliseconds: 1000), () {
        PopupManager.openWalletInfoPopup(
          'Failed to import wallet'.tr,
          'The wallet import was unsuccessful.  Double-check your details and try again, or create a new wallet if necessary to proceed.'
              .tr,
        );
      });
      await Get.to(
        () => Get.find<UserStateService>().user.value.isDonor
            ? const DonorRootPage()
            : const BeneficiaryRootPage(),
      );
    }
  }
}
