import 'dart:math';

import 'package:breez_sdk/bridge_generated.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../service/breez_service.dart';
import '../../../service/currency_conversion_service.dart';
import '../../../service/logger_service.dart';
import '../../../util/popup_manager.dart';
import '../../../util/util.dart';
import '../../root/donor_root_page.dart';
import '../show_seed_phrase_page.dart';

class WalletPageController extends GetxController {
  BreezService breezService = Get.find<BreezService>();
  LoggerService loggerService = Get.find<LoggerService>();
  CurrencyConversionService currencyConversionService =
      Get.find<CurrencyConversionService>();

  RxString testInvoice = ''.obs;
  RxDouble balanceInUSD = 0.0.obs;
  RxBool showWalletOptions = false.obs;
  RxList<Payment> transactions = <Payment>[].obs;
  RxList<double> transactionAmounts = <double>[].obs;
  RxString timeSinceLastTransaction = ''.obs;

  RxBool isWalletConnected = false.obs;
  RxString seedPhrase = ''.obs;

  final TextEditingController seedConfirmationInput1 = TextEditingController();
  final TextEditingController seedConfirmationInput2 = TextEditingController();
  final TextEditingController seedConfirmationInput3 = TextEditingController();
  List<TextEditingController> importSeedInputs =
      List<TextEditingController>.generate(12, (_) => TextEditingController());

  void toggleShowWalletOptions() =>
      showWalletOptions.value = !showWalletOptions.value;

  Future<void> getTransactions() async {
    // ignore: no_leading_underscores_for_local_identifiers
    final List<Payment> _transactions = await breezService.getPaymentHistory();
    // ignore: no_leading_underscores_for_local_identifiers
    final List<double> _transactionAmounts = <double>[];
    int lastTransactionTime = 0;
    transactions.clear();
    transactionAmounts.clear();

    for (final Payment transaction in _transactions) {
      if (lastTransactionTime < transaction.paymentTime) {
        lastTransactionTime = transaction.paymentTime;
      }
      _transactionAmounts.add(
        await currencyConversionService.convertSatoshisToUSD(
          (transaction.amountMsat / 1000).round(),
        ),
      );
    }

    transactions.value = _transactions;
    transactionAmounts.value = _transactionAmounts;

    timeSinceLastTransaction.value = getTimePassedString(
      DateTime.fromMillisecondsSinceEpoch(
        lastTransactionTime * 1000,
      ),
    );
  }

  void resetWalletConnectionInputs() {
    seedConfirmationInput1.clear();
    seedConfirmationInput2.clear();
    seedConfirmationInput3.clear();
    importSeedInputs = List<TextEditingController>.generate(
      12,
      (_) => TextEditingController(),
    );
  }

  void goToSeedPhraseConfirmation() {
    resetWalletConnectionInputs();
    seedPhrase.value = breezService.generateSeedPhrase();
    Get.to<void>(() => const ShowSeedPhrasePage());
  }

  Future<void> createInvoice() async {
    testInvoice.value = await breezService.createInvoice(
      description: 'Shady tech support',
      amountInSatoshi: 2501,
    );
  }

  Future<void> getBalanceInUSD() async {
    final int balanceInSatoshis =
        (await breezService.getBalanceInSatoshis() / 1000).round();

    // ignore: no_leading_underscores_for_local_identifiers
    final double _balanceInUSD =
        await currencyConversionService.convertSatoshisToUSD(balanceInSatoshis);
    balanceInUSD.value = _balanceInUSD;
  }

  void validateSeedPhrase(List<String> expectedValues) {
    if (expectedValues[0].toLowerCase() !=
            seedConfirmationInput1.text.toLowerCase() ||
        expectedValues[1].toLowerCase() !=
            seedConfirmationInput2.text.toLowerCase() ||
        expectedValues[2].toLowerCase() !=
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

    createWallet();
  }

  Future<void> clearWalletEnvironment() async {
    resetWalletConnectionInputs();
    try {
      await breezService.breezSDK.disconnect();
      // ignore: empty_catches
    } catch (e) {}
    try {
      await breezService.clearApplicationDocumentsDirectory();
      // ignore: empty_catches
    } catch (e) {}
    isWalletConnected.value = false;
  }

  Future<void> createWallet() async {
    await clearWalletEnvironment();

    await breezService.connectToNode(seedPhrase.value);
    isWalletConnected.value = true;

    Future<void>.delayed(const Duration(milliseconds: 1000), () {
      PopupManager.openWalletInfoPopup(
        'Success!'.tr,
        'Your wallet has been successfully created. You can now access and manage your assets.'
            .tr,
      );
    });

    await Get.to(() => const DonorRootPage());
  }

  Future<void> importWallet(
    String seedPhrase,
  ) async {
    await clearWalletEnvironment();
    try {
      loggerService.log('Importing wallet');

      await breezService.connectToNode(
        seedPhrase.length > 15
            ? seedPhrase
            : 'solve mixture maid peanut stable monitor pulp check special plunge then business',
      );

      isWalletConnected.value = true;
      loggerService.log('Wallet successfully imported');

      Future<void>.delayed(const Duration(milliseconds: 1000), () {
        PopupManager.openWalletInfoPopup(
          'Wallet successfully imported!'.tr,
          'Your wallet has been successfully imported. You can now access your account and manage your assets securely. '
              .tr,
        );
      });
      await Get.to(() => const DonorRootPage());
    } catch (e) {
      Future<void>.delayed(const Duration(milliseconds: 1000), () {
        PopupManager.openWalletInfoPopup(
          'Failed to import wallet'.tr,
          'The wallet import was unsuccessful.  Double-check your details and try again, or create a new wallet if necessary to proceed.'
              .tr,
        );
      });
      await Get.to(() => const DonorRootPage());
    }
  }
}
