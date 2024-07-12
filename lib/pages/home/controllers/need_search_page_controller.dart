import 'package:get/get.dart';

import '../../../model/need.dart';
import '../../../service/need_service.dart';

class NeedSearchPageController extends GetxController {
  NeedSearchPageController(this.areas);
  final List<AreaOfInterest> areas;
  RxList<Need> needs = <Need>[].obs;

  @override
  Future<void> onInit() async {
    needs.value = await Get.find<NeedService>()
        .getPublishedNeedsMatchingAreasOfInterest(areas);
    super.onInit();
  }
}
