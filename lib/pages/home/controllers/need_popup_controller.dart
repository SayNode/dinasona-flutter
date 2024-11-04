import 'package:get/get.dart';

import '../../../model/need.dart';

class NeedPopupController extends GetxController {
  NeedPopupController({required this.need});
  final Need need;

  Future<void> donate(Need need) async {
    // Donate to the need
  }
}
