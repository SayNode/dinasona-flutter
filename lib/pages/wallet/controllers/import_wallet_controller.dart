import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

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

class ImportWalletController extends GetxController {
  final SecureStorageService secureStorageService =
      Get.find<SecureStorageService>();
  final WalletService walletService = Get.find<WalletService>();
  final BreezService breezService = Get.find<BreezService>();
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
    loggerService.log('Importing wallet');
    try {
      await walletService.clearWalletEnvironment();

      final dynamic connectionResult = await breezService.connectToLiquid(
        seedPhrase,
      );

      if (connectionResult == 'invalid word in phrase' ||
          connectionResult == 'invalid checksum' ||
          connectionResult == 'unknown word') {
        if (Get.context != null) {
          hideLoadingDialog(Get.context!);
        }
        seedImportErrorMessage.value = connectionResult as String;
        return;
      }

      await Get.find<UserStateService>().fetchUserInfo();
      await secureStorageService.writeString(
        'walletSeedPhrase${Get.find<UserStateService>().user.value.email}',
        seedPhrase,
      );
      await WalletPageController().getTransactions();

      if (Get.context != null) {
        hideLoadingDialog(Get.context!);
      }

      walletService.isWalletConnected.value = true;
      loggerService.log('Wallet successfully imported');

      Future<void>.delayed(const Duration(milliseconds: 1000), () {
        PopupManager.openWalletInfoPopup(
          'Wallet successfully imported!'.tr,
          'Your wallet has been successfully imported. You can now access your account and manage your assets securely.'
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
      loggerService.log('Wallet import failed: $e');

      // Wait for the loading dialog to show before hiding it
      // Todo fix in a later milestone - dirty quick fix for the launch
      await Future<void>.delayed(const Duration(milliseconds: 1000), () {});

      if (Get.context != null) {
        hideLoadingDialog(Get.context!);
      }

      await Future<void>.delayed(const Duration(milliseconds: 1000), () {
        PopupManager.openWalletInfoPopup(
          'Failed to import wallet'.tr,
          'The wallet import was unsuccessful.  Double-check your details and try again, or create a new wallet if necessary to proceed.'
              .tr,
        );
      });

      FocusManager.instance.primaryFocus?.unfocus();
    }
  }
}
