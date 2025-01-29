import 'dart:async';

import 'package:get/get.dart';

import '../../../model/need.dart';
import '../../../service/api_service.dart';
import '../../../service/currency_conversion_service.dart';
import '../../../service/logger_service.dart';
import '../../../service/wallet_service.dart';
import '../../wallet/send_bitcoin_page.dart';

class NeedPopupController extends GetxController {
  NeedPopupController({required this.need});
  final Need need;
  final APIService apiService = Get.find<APIService>();
  final LoggerService logger = Get.find<LoggerService>();

  final CurrencyConversionService currencyConversionService =
      Get.find<CurrencyConversionService>();
  final RxDouble needAmountInUserCurrency = 0.0.obs;
  final RxBool isLoadingCurrency = true.obs;

  @override
  Future<dynamic> onInit() async {
    isLoadingCurrency.value = true;
    super.onInit();

    needAmountInUserCurrency.value =
        need.amount * currencyConversionService.conversionRates.value.USDvsUSR;

    isLoadingCurrency.value = false;
  }

  bool isLocked() {
    if (need.status == NeedStatus.past ||
        Get.find<WalletService>().balanceInUserCurrency < need.amount ||
        Get.find<WalletService>().isWalletConnected.value == false) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> donate(Need need) async {
    unawaited(
      Get.off<void>(
        () => SendBitcoinPage(
          bolt11FromDonation: need.bolt11invoice,
          need: need,
        ),
      ),
    );
  }
}
