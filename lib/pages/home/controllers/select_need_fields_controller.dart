import 'package:get/get.dart';

import '../../../model/need.dart';
import '../../../service/need_service.dart';

class SelectAreasOfInterestController extends GetxController {
  SelectAreasOfInterestController(this.initialSelectedDonationFields);

  late List<AreaOfInterest> initialSelectedDonationFields;
  RxList<AreaOfInterest> selectedAreasOfInterest = <AreaOfInterest>[].obs;
  final NeedService needService = Get.find<NeedService>();
  RxInt count = 0.obs;
  RxBool loading = false.obs;
  late Map<String, int> amountOfneeds;

  @override
  Future<void> onInit() async {
    loading.value = true;
    selectedAreasOfInterest.addAll(initialSelectedDonationFields);
    amountOfneeds = await needService.getAmoutOfNeeds();
    loading.value = false;
    super.onInit();
  }

  void seeNeeds(AreaOfInterest field) {
    selectedAreasOfInterest.contains(field)
        ? selectedAreasOfInterest.remove(field)
        : selectedAreasOfInterest.add(field);
    count.value = 0;
    for (final AreaOfInterest field in selectedAreasOfInterest) {
      count.value += amountOfneeds[field.title] ?? 0;
    }
  }

  void close() {
    Get.back(result: selectedAreasOfInterest.toList());
  }
}
