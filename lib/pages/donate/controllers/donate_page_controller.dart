import 'package:get/get.dart';

import '../../../model/need.dart';
import '../../../service/need_service.dart';

class DonatePageController extends GetxController {
  RxList<Need> needsFulfilled = <Need>[].obs;

  @override
  Future<void> onInit() async {
    needsFulfilled.value = await Get.find<NeedService>().getDonateHistory();
    super.onInit();
  }
}
