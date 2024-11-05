import 'package:get/get.dart';

import '../../../model/need.dart';
import '../../../service/need_service.dart';

class MyNeedPopupController extends GetxController {
  MyNeedPopupController({required this.need});
  NeedService needService = Get.find<NeedService>();
  final Need need;
  void editNeed(Need need) {
    needService.updateNeed(
      need.id,
      need.title,
      need.description,
      need.amount.toString(),
      need.status.toString(),
      //todo: change this soon
      1,
    );
  }

  void deleteNeed(int id) {
    needService.deleteNeed(id);
  }
}
