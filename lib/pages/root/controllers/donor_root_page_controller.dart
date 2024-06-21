import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/donor_bottom_navigation_bar.dart.dart';

class DonorRootController extends GetxController {
  RxInt tabIndex = 0.obs;

  final List<Widget> body =
      DonorItem.values.map((DonorItem e) => e.page).toList();

  // ignore: use_setters_to_change_properties
  void changeTabIndex(int index) {
    tabIndex.value = index;
  }
}
