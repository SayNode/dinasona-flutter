import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/beneficiary_profile_controller.dart';

class BeneficiaryProfilePage extends GetView<BeneficiaryProfileController> {
  const BeneficiaryProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(BeneficiaryProfileController());
    return const Placeholder();
  }
}
