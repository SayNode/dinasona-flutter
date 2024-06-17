import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../donor_settings_page/donor_settings_page.dart';

class PageLoaderController extends GetxController {
  RxInt tabIndex = 0.obs;

  final List<Widget> body = <Widget>[
    Container(),
    Container(),
    const DonorSettingsPage(),
  ];

  // ignore: use_setters_to_change_properties
  void changeTabIndex(int index) {
    tabIndex.value = index;
  }
}
