import 'dart:async';
import 'dart:io';

import 'package:flutter_breez_liquid/flutter_breez_liquid.dart' as liquid_sdk;
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

import '../util/constants.dart';
import 'breez_sdk_instance.dart';

abstract class BreezBaseService extends GetxService {
  BreezSDKLiquid breezSDKLiquid = BreezSDKLiquid();
  //breezSDKLiquid.

  Future<dynamic> connectToLiquid(String seedPhrase) async {
    try {
      // TODO Julien - Improve config after prototype is finished
      final liquid_sdk.Config defaultConfiguration = liquid_sdk.defaultConfig(
        network: Constants.networkType,
        breezApiKey: Constants.breezAPIKey,
      );

      final liquid_sdk.Config fullConfig = liquid_sdk.Config(
        liquidElectrumUrl: defaultConfiguration.liquidElectrumUrl,
        bitcoinElectrumUrl: defaultConfiguration.bitcoinElectrumUrl,
        mempoolspaceUrl: defaultConfiguration.mempoolspaceUrl,
        workingDir: (await getApplicationDocumentsDirectory()).path,
        network: Constants.networkType,
        paymentTimeoutSec: defaultConfiguration.paymentTimeoutSec,
        zeroConfMinFeeRateMsat: defaultConfiguration.zeroConfMinFeeRateMsat,
        breezApiKey: Constants.breezAPIKey,
      );

      final liquid_sdk.ConnectRequest connectRequest =
          liquid_sdk.ConnectRequest(mnemonic: seedPhrase, config: fullConfig);

      await breezSDKLiquid.connect(req: connectRequest);
    } catch (e) {
      // ignore: only_throw_errors
      throw 'Error connecting to liquid: $e';
    }
  }

  Future<void> disconnectFromLiquid() async {
    breezSDKLiquid.disconnect();
  }

  Future<List<liquid_sdk.Payment>> getPaymentHistory() async {
    final List<liquid_sdk.Payment> paymentsHistory =
        await breezSDKLiquid.listPayments();
    return paymentsHistory;
  }

  Future<int> getBalanceInSatoshis() async {
    final int balance = await breezSDKLiquid.getBalanceInSatoshis();

    return balance;
  }

  Future<void> registerWebhook() async {
    try {
      await breezSDKLiquid.instance!.registerWebhook(
        webhookUrl: Constants.notificationDeliveryServiceEndpoint,
      );
    } catch (_) {}
  }

  Future<void> unregisterWebhook() async {
    try {
      await breezSDKLiquid.instance!.unregisterWebhook();
    } catch (_) {}
  }

  Future<liquid_sdk.LNInvoice> parseInvoice(String bolt11Invoice) async {
    final liquid_sdk.LNInvoice parsedInvoice =
        liquid_sdk.parseInvoice(input: bolt11Invoice);

    return parsedInvoice;
  }

  Future<String> createInvoice(String description, int amountInSatoshi) async {
    final String bolt11Invoice = await breezSDKLiquid.createInvoice(
      description: description,
      amountInSatoshi: amountInSatoshi,
    );

    return bolt11Invoice;
  }

  Future<liquid_sdk.PrepareSendResponse> prepareSendingTransaction(
    String bolt11Invoice,
  ) async {
    final liquid_sdk.PrepareSendResponse prepareSendResponse =
        await breezSDKLiquid.prepareSendingTransaction(bolt11Invoice);
    return prepareSendResponse;
  }

  Future<dynamic> sendPayment({
    liquid_sdk.PrepareSendResponse? preparedSendData,
    String? bolt11Invoice,
  }) async {
    final dynamic sendPaymentResponse = await breezSDKLiquid.sendPayment(
      bolt11: bolt11Invoice,
      preparedSendData: preparedSendData,
    );

    return sendPaymentResponse;
  }

  Future<void> clearApplicationDocumentsDirectory() async {
    final Directory directory = await getApplicationDocumentsDirectory();
    if (directory.existsSync()) {
      directory.listSync().forEach((FileSystemEntity file) {
        if (file is File) {
          file.deleteSync();
        } else if (file is Directory) {
          file.deleteSync(recursive: true);
        }
      });
    }
  }
}

class PaymentException {
  const PaymentException(this.details);
  final liquid_sdk.Payment details;
}

extension ConfigCopyWith on liquid_sdk.Config {
  liquid_sdk.Config copyWith({
    String? liquidElectrumUrl,
    String? bitcoinElectrumUrl,
    String? mempoolspaceUrl,
    String? workingDir,
    liquid_sdk.LiquidNetwork? network,
    BigInt? paymentTimeoutSec,
    int? zeroConfMinFeeRateMsat,
    String? breezApiKey,
  }) {
    return liquid_sdk.Config(
      liquidElectrumUrl: liquidElectrumUrl ?? this.liquidElectrumUrl,
      bitcoinElectrumUrl: bitcoinElectrumUrl ?? this.bitcoinElectrumUrl,
      mempoolspaceUrl: mempoolspaceUrl ?? this.mempoolspaceUrl,
      workingDir: workingDir ?? this.workingDir,
      network: network ?? this.network,
      paymentTimeoutSec: paymentTimeoutSec ?? this.paymentTimeoutSec,
      zeroConfMinFeeRateMsat:
          zeroConfMinFeeRateMsat ?? this.zeroConfMinFeeRateMsat,
      breezApiKey: breezApiKey ?? this.breezApiKey,
    );
  }
}
