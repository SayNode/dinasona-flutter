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
    count.value = selectedAreasOfInterest.fold<int>(
      0,
      (int previousValue, AreaOfInterest element) =>
          previousValue + (amountOfneeds[element.title] ?? 0),
    );
    super.onInit();
  }

  void seeNeeds(AreaOfInterest field) {
    if (selectedAreasOfInterest.contains(field)) {
      selectedAreasOfInterest.remove(field);
      count.value -= amountOfneeds[field.title] ?? 0;
    } else {
      selectedAreasOfInterest.add(field);
      count.value += amountOfneeds[field.title] ?? 0;
    }
  }

  void close() {
    Get.back(result: selectedAreasOfInterest.toList());
  }
}
