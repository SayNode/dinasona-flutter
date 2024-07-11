import 'package:get/get.dart';

import '../../../model/need.dart';

class SelectAreasOfInterestController extends GetxController {
  SelectAreasOfInterestController(this.initialSelectedDonationFields);

  late List<AreaOfInterest> initialSelectedDonationFields;
  RxList<AreaOfInterest> selectedAreasOfInterest = <AreaOfInterest>[].obs;

  @override
  void onInit() {
    selectedAreasOfInterest.addAll(initialSelectedDonationFields);
    super.onInit();
  }

  void close() {
    Get.back(result: selectedAreasOfInterest.toList());
  }
}
