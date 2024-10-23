import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../service/breez_service.dart';
import '../../../service/currency_conversion_service.dart';
import '../../../service/logger_service.dart';
import '../../../service/storage/secure_storage_service.dart';
import '../../../service/user_state_service.dart';
import '../../../service/wallet_service.dart';
import '../show_seed_phrase_page.dart';
import 'create_wallet_controller.dart';

class WalletPageController extends GetxController {
  //TODO liquid switch
  //final WalletService walletService = Get.find<WalletService>();
  final SecureStorageService secureStorageService =
      Get.find<SecureStorageService>();
  BreezService breezService = Get.find<BreezService>();
  LoggerService loggerService = Get.find<LoggerService>();
  CurrencyConversionService currencyConversionService =
      Get.find<CurrencyConversionService>();

  RxBool showWalletOptions = false.obs;

  void toggleShowWalletOptions() =>
      showWalletOptions.value = !showWalletOptions.value;

  Future<void> getTransactions() async {
    //TODO liquid switch
    //await walletService.getTransactions();
  }

  Future<void> deleteUserWallet() async {
    //TODO liquid switch
    //await walletService.deleteUserWallet();
  }

  Future<void> getBalanceInUSD() async {
    //TODO liquid switch
    //await walletService.getBalanceInUSD();
  }

  void goToSeedPhraseConfirmation() {
    Get.put(CreateWalletController()).seedPhrase.value =
        breezService.generateSeedPhrase();
    Get.to<void>(() => const ShowSeedPhrasePage());
  }

  // TODO: Chose a more secure and reliable way to export the seed phrase
  Future<void> saveSeedPhraseToClipboard(BuildContext context) async {
    final String? seedPhrase = await secureStorageService.readString(
      'walletSeedPhrase${Get.find<UserStateService>().user.value.email}',
    );

    if (seedPhrase != null && seedPhrase.isNotEmpty) {
      try {
        await Clipboard.setData(ClipboardData(text: seedPhrase));

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Your seed phrase has been successfully copied to your clipboard.'
                    .tr,
                textAlign: TextAlign.center,
              ),
            ),
          );
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Failed to copy your seedphrase to your clipboard.'.tr,
                textAlign: TextAlign.center,
              ),
            ),
          );
        }
      }
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Failed to copy your seedphrase to your clipboard.'.tr,
              textAlign: TextAlign.center,
            ),
          ),
        );
      }
    }
  }
}
