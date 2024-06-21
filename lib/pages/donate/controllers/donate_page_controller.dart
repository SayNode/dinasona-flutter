import 'package:get/get.dart';

import '../../../model/need.dart';
import '../../../util/mock_data.dart';

class DonatePageController extends GetxController {
  RxList<Need> needsFulfilled = <Need>[].obs;

  @override
  void onInit() {
    // TODO - Get donations made by the user from backend
    needsFulfilled.addAll(MockData.needs);
    super.onInit();
  }
}
