import 'package:get/get.dart';

import '../../../model/beneficiary.dart';
import '../../../model/need.dart';
import '../../../util/mock_data.dart';

enum NeedTab {
  all,
  ongoing,
  past;

  String get title {
    switch (this) {
      case NeedTab.all:
        return 'All';
      case NeedTab.ongoing:
        return 'Ongoing';
      case NeedTab.past:
        return 'Past';
    }
  }
}

class BeneficiaryPageController extends GetxController {
  BeneficiaryPageController({required this.beneficiary});

  final Beneficiary beneficiary;
  RxList<Need> needs = <Need>[].obs;

  Rx<NeedTab> selectedTab = NeedTab.all.obs;

  @override
  void onInit() {
    needs.value = MockData.needs;
    super.onInit();
  }
}
