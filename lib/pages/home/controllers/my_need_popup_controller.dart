import 'package:get/get.dart';

import '../../../model/need.dart';
import '../../../service/currency_conversion_service.dart';
import '../../../service/need_service.dart';

class MyNeedPopupController extends GetxController {
  MyNeedPopupController({required this.need});
  NeedService needService = Get.find<NeedService>();
  final CurrencyConversionService currencyConversionService =
      Get.find<CurrencyConversionService>();
  final Need need;
  final RxDouble needAmountInUserCurrency = 0.0.obs;
  final RxBool isLoadingCurrency = true.obs;
  void editNeed(Need need) {
    // needService.updateNeed(
    //   need.id,

    // );
  }

  @override
  Future<dynamic> onInit() async {
    isLoadingCurrency.value = true;
    super.onInit();

    final double userTargetCurrencyRate =
        await currencyConversionService.fetchUserTargetCurrencyRate('usd');
    needAmountInUserCurrency.value = need.amount * userTargetCurrencyRate;

    isLoadingCurrency.value = false;
  }

  void deleteNeed(int id) {
    needService.deleteNeed(id);
  }

  String publishedDate() {
    final DateTime now = DateTime.now();
    final DateTime createdAt = need.createdAt;
    final Duration difference = now.difference(createdAt);
    if (difference.inDays == 0) {
      return 'Today';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else {
      return '${difference.inDays} days ago';
    }
  }

  String donatedDate() {
    final String day = need.updatedAt.day.toString();
    final String month = need.updatedAt.month.toString();
    final String year = need.updatedAt.year.toString();

    // Determine the day suffix
    String daySuffix(int day) {
      if (day >= 11 && day <= 13) {
        return 'th';
      }
      switch (day % 10) {
        case 1:
          return 'st';
        case 2:
          return 'nd';
        case 3:
          return 'rd';
        default:
          return 'th';
      }
    }

    final String suffix = daySuffix(need.updatedAt.day);
    return '$day$suffix $month $year';
  }
}
