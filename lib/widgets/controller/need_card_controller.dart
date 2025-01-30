import 'package:get/get.dart';

import '../../model/need.dart';
import '../../service/currency_conversion_service.dart';

class NeedCardController extends GetxController {
  NeedCardController({required this.need});

  final CurrencyConversionService currencyConversionService =
      Get.find<CurrencyConversionService>();
  final Need need;
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
}
