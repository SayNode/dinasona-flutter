//TODO liquid switch
/* import 'package:breez_sdk/bridge_generated.dart';
import 'package:get/get.dart';

import '../util/constants.dart';
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

  RxDouble balanceInUSD = 0.0.obs;
  RxList<double> transactionAmounts = <double>[].obs;
  RxString timeSinceLastTransaction = ''.obs;
  RxList<Payment> transactions = <Payment>[].obs;
  RxBool isWalletConnected = false.obs;
  RxDouble amountSentInUserCurrency = 0.0.obs;

  @override
  void onInit() {
    super.onInit();

    isWalletConnected.listen((bool value) async {
      if ((await breezService.getNodeState()) != null) {
        if (value) {
          await breezService.breezSDK.registerWebhook(
            webhookUrl: Constants.notificationDeliveryServiceEndpoint,
          );
          return;
        }
        await breezService.breezSDK.unregisterWebhook(
          webhookUrl: Constants.notificationDeliveryServiceEndpoint,
        );
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

  Future<void> getBalanceInUSD() async {
    final int balanceInSatoshis =
        (await breezService.getBalanceInSatoshis() / 1000).round();

    // ignore: no_leading_underscores_for_local_identifiers
    final double _balanceInUSD = await currencyConversionService
        .convertSatoshiToUserCurrency(balanceInSatoshis);
    balanceInUSD.value = _balanceInUSD;
  }

  Future<void> clearWalletEnvironment() async {
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

  Future<void> deleteUserWallet() async {
    await clearWalletEnvironment();
    await secureStorageService.delete(
      'walletSeedPhrase${Get.find<UserStateService>().user.value.email}',
    );
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
}
 */