import 'package:get/get.dart';

import '../../../model/donation.dart';

class SelectDonationFieldsController extends GetxController {
  SelectDonationFieldsController(this.initialSelectedDonationFields);

  late List<DonationField> initialSelectedDonationFields;
  RxList<DonationField> selectedDonationFields = <DonationField>[].obs;

  @override
  void onInit() {
    selectedDonationFields.addAll(initialSelectedDonationFields);
    super.onInit();
  }

  void close() {
    Get.back(result: selectedDonationFields.toList());
  }
}
