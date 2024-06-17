import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../beneficiary_home_page/beneficiary_home_screen_page.dart';

class PageLoaderController extends GetxController {
  RxInt tabIndex = 0.obs;

  final List<Widget> body = <Widget>[
    const BeneficiaryHomeScreen(),
    Container(),
    Container(),
  ];

  // ignore: use_setters_to_change_properties
  void changeTabIndex(int index) {
    tabIndex.value = index;
  }
}
