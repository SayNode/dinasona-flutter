import 'dart:async';

//import 'package:breez_liquid/breez_liquid.dart';
import 'package:flutter_breez_liquid/flutter_breez_liquid.dart' as liquid_sdk;
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rxdart/rxdart.dart';

import '../util/constants.dart';
import 'breez_sdk_instance.dart';

/* var walletInfo = await breezSDKLiquid.instance!.getInfo();
    print('Public Key: ${walletInfo.pubkey}');

    final secondTest = liquid_sdk.PrepareReceiveResponse(
        paymentMethod: liquid_sdk.PaymentMethod.liquidAddress,
        payerAmountSat: BigInt.from(10000),
        feesSat: BigInt.from(1000));
    final teest = liquid_sdk.ReceivePaymentRequest(
        description: seedPhrase, prepareResponse: secondTest);

    var bip21Uri = await breezSDKLiquid.instance!.receivePayment(req: teest);

    print('test: ${bip21Uri.destination}');
    Uri uri = Uri.parse(bip21Uri.toString());
    String address = uri.path;
    print('New Testnet Address: $address');

    breezSDKLiquid._fetchWalletData(breezSDKLiquid.instance!);

    var lool =
        await breezSDKLiquid._listPayments(sdk: breezSDKLiquid.instance!);
    print('test: ${lool.first.amountSat}');

    //print('test: ${breezSDKLiquid.instance!.listPayments(req: req)}') */

abstract class BreezBaseService extends GetxService {
  final RxBool isConnected = false.obs;
  BreezSDKLiquid breezSDKLiquid = BreezSDKLiquid();

  Future<void> createLightningInvoice() async {
    await breezSDKLiquid.createInvoice(
      description: 'Test payment',
      amountInSatoshi: 1000,
    );
  }

  Future<dynamic> connectToLiquid(String seedPhrase) async {
    isConnected.value = false;

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
      isConnected.value = true;
    } catch (e) {
      isConnected.value = false;
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
