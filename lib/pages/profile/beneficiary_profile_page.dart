import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/beneficiary_profile_page_controller.dart';

class BeneficiaryProfilePage extends GetView<BeneficiaryProfilePageController> {
  const BeneficiaryProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(BeneficiaryProfilePageController());
    return const Placeholder();
  }
}
