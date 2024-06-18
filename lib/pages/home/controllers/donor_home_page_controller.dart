import 'package:get/get.dart';

import '../../../model/donation.dart';

class DonorHomePageController extends GetxController {
  RxList<DonationField> selectedDonationFields = <DonationField>[].obs;

  @override
  Future<void> onInit() async {
    selectedDonationFields.addAll(DonationField.values.take(2));
    super.onInit();
  }

  Future<void> exploreMore() async {}
}
