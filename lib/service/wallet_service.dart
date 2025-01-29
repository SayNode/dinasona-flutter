import 'package:flutter_breez_liquid/flutter_breez_liquid.dart';
import 'package:get/get.dart';

import '../util/util.dart';
import 'breez_service.dart';
import 'currency_conversion_service.dart';
import 'logger_service.dart';
import 'storage/secure_storage_service.dart';
import 'user_state_service.dart';

class WalletService extends GetxService {
  final SecureStorageService secureStorageService =
      Get.find<SecureStorageService>();
  BreezService breezService = Get.find<BreezService>();
  LoggerService loggerService = Get.find<LoggerService>();
  CurrencyConversionService currencyConversionService =
      Get.find<CurrencyConversionService>();

  RxDouble balanceInUserCurrency = 0.0.obs;
  RxList<double> transactionAmounts = <double>[].obs;
  RxString timeSinceLastTransaction = ''.obs;
  RxList<Payment> transactions = <Payment>[].obs;
  RxBool isWalletConnected = false.obs;
  RxDouble amountSentInUserCurrency = 0.0.obs;

  @override
  void onInit() {
    super.onInit();

    isWalletConnected.listen((bool value) async {
      if (breezService.breezSDKLiquid.instance != null) {
        if (value) {
          await breezService.registerWebhook();
          return;
        }
        await breezService.unregisterWebhook();
      }
    });
  }

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
      if (lastTransactionTime < transaction.timestamp) {
        lastTransactionTime = transaction.timestamp;
      }
      if (transaction.paymentType == PaymentType.send) {
        amountSentInUserCurrency.value +=
            currencyConversionService.conversionRates.value.BTCvsUSR *
                currencyConversionService
                    .satoshiToX(transaction.amountSat.toDouble());
      }

      amountSentInUserCurrency.value =
          double.parse(amountSentInUserCurrency.toStringAsFixed(2));

      _transactionAmounts.add(
        currencyConversionService.conversionRates.value.BTCvsUSR *
            currencyConversionService
                .satoshiToX(transaction.amountSat.toDouble()),
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

  Future<void> getBalanceInUserCurrency() async {
    final int balanceInSatoshis = await breezService.getBalanceInSatoshis();

    balanceInUserCurrency.value =
        currencyConversionService.satoshiToX(balanceInSatoshis.toDouble()) *
            currencyConversionService.conversionRates.value.BTCvsUSR;
  }

  Future<void> clearWalletEnvironment() async {
    try {
      await breezService.disconnectFromLiquid();
    } catch (_) {}
    try {
      await breezService.clearApplicationDocumentsDirectory();
    } catch (_) {}
    isWalletConnected.value = false;
  }

  Future<void> deleteUserWallet() async {
    await clearWalletEnvironment();
    await secureStorageService.delete(
      'walletSeedPhrase${Get.find<UserStateService>().user.value.email}',
    );
  }

  Future<void> connectToWalletAfterSignIn() async {
    isWalletConnected.value = false;
    await Get.find<UserStateService>().fetchUserInfo();
    final String seedPhrase = await secureStorageService.readString(
          'walletSeedPhrase${Get.find<UserStateService>().user.value.email}',
        ) ??
        '';

    if (seedPhrase.isNotEmpty) {
      try {
        await breezService.connectToLiquid(
          seedPhrase,
        );
        await getTransactions();
        isWalletConnected.value = true;
      } catch (e) {
        Get.find<LoggerService>().log('Error connecting to liquid: $e');
      }
    }
  }
}
