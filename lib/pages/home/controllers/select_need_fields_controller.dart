import 'package:get/get.dart';

import '../../../model/need.dart';

class SelectNeedFieldsController extends GetxController {
  SelectNeedFieldsController(this.initialSelectedDonationFields);

  late List<NeedField> initialSelectedDonationFields;
  RxList<NeedField> selectedNeedFields = <NeedField>[].obs;

  @override
  void onInit() {
    selectedNeedFields.addAll(initialSelectedDonationFields);
    super.onInit();
  }

  void close() {
    Get.back(result: selectedNeedFields.toList());
  }
}
