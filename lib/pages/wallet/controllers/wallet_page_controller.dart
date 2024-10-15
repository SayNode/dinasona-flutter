import 'dart:async';

import 'package:breez_sdk/bridge_generated.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../service/breez_service.dart';
import '../../../service/currency_conversion_service.dart';
import '../../../service/logger_service.dart';
import '../../../service/storage/secure_storage_service.dart';
import '../../../service/user_state_service.dart';
import '../../../service/wallet_service.dart';
import '../../../util/util.dart';
import '../show_seed_phrase_page.dart';
import 'create_wallet_controller.dart';

class WalletPageController extends GetxController {
  final SecureStorageService secureStorageService =
      Get.find<SecureStorageService>();
  BreezService breezService = Get.find<BreezService>();
  LoggerService loggerService = Get.find<LoggerService>();
  CurrencyConversionService currencyConversionService =
      Get.find<CurrencyConversionService>();

  RxDouble balanceInUSD = 0.0.obs;
  RxBool showWalletOptions = false.obs;
  RxList<Payment> transactions = <Payment>[].obs;
  RxList<double> transactionAmounts = <double>[].obs;
  RxString timeSinceLastTransaction = ''.obs;
  RxDouble amountSentInUserCurrency = 0.0.obs;

  RxBool isWalletConnected = false.obs;

  final TextEditingController seedConfirmationInput1 = TextEditingController();
  final TextEditingController seedConfirmationInput2 = TextEditingController();
  final TextEditingController seedConfirmationInput3 = TextEditingController();

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
    amountSentInUserCurrency.value = 0.0;

    for (final Payment transaction in _transactions) {
      if (lastTransactionTime < transaction.paymentTime) {
        lastTransactionTime = transaction.paymentTime;
      }
      if (transaction.paymentType == PaymentType.Sent) {
        amountSentInUserCurrency.value +=
            await currencyConversionService.convertSatoshiToUserCurrency(
          (transaction.amountMsat / 1000).round(),
        );
      }

      amountSentInUserCurrency.value =
          double.parse(amountSentInUserCurrency.toStringAsFixed(3));

      _transactionAmounts.add(
        await currencyConversionService.convertSatoshiToUserCurrency(
          (transaction.amountMsat / 1000).round(),
        ),
      );
    }

    transactions.value = _transactions;
    transactionAmounts.value = _transactionAmounts;

    timeSinceLastTransaction.value = lastTransactionTime == 0
        ? 'No past transactions'.tr
        : getTimePassedString(
            DateTime.fromMillisecondsSinceEpoch(
              lastTransactionTime * 1000,
            ),
          );
  }

  void resetWalletConnectionInputs() {
    seedConfirmationInput1.clear();
    seedConfirmationInput2.clear();
    seedConfirmationInput3.clear();
  }

  Future<void> deleteUserWallet() async {
    await clearWalletEnvironment();
    await secureStorageService.delete(
      'walletSeedPhrase${Get.find<UserStateService>().user.value.email}',
    );
    Get.find<WalletService>().deleteWallet();
  }

  void goToSeedPhraseConfirmation() {
    resetWalletConnectionInputs();
    Get.put(CreateWalletController()).seedPhrase.value =
        breezService.generateSeedPhrase();
    Get.to<void>(() => const ShowSeedPhrasePage());
  }

  Future<void> getBalanceInUSD() async {
    final int balanceInSatoshis =
        (await breezService.getBalanceInSatoshis() / 1000).round();

    // ignore: no_leading_underscores_for_local_identifiers
    final double _balanceInUSD = await currencyConversionService
        .convertSatoshiToUserCurrency(balanceInSatoshis);
    balanceInUSD.value = _balanceInUSD;
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

  Future<void> connectToWalletAfterSignIn() async {
    await Get.find<UserStateService>().fetchUserInfo();
    final String seedPhrase = await secureStorageService.readString(
          'walletSeedPhrase${Get.find<UserStateService>().user.value.email}',
        ) ??
        '';

    if (seedPhrase.isNotEmpty) {
      try {
        await breezService.connectToNode(
          seedPhrase,
        );
        await getTransactions();
        isWalletConnected.value = true;
      } catch (e) {
        Get.find<LoggerService>().log('Error connecting to node: $e');
      }
    }
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
