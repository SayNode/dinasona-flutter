import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/beneficiary_bottom_navigation_bar.dart';

class BeneficiaryRootController extends GetxController {
  final RxInt tabIndex = 0.obs;
  final List<Widget> body =
      BeneficaryItem.values.map((BeneficaryItem e) => e.page).toList();

  void changeTabIndex(int index) {
    tabIndex.value = index;
  }
}
