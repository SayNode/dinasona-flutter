import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/beneficary_home_controller.dart';

class BeneficiaryHomePage extends GetView<BeneficiaryHomeController> {
  const BeneficiaryHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(BeneficiaryHomeController());
    return const Placeholder();
  }
}
