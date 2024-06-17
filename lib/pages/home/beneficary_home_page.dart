import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/beneficary_home_page_controller.dart';

class BeneficiaryHomePage extends GetView<BeneficiaryHomePageController> {
  const BeneficiaryHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(BeneficiaryHomePageController());
    return const Placeholder();
  }
}
