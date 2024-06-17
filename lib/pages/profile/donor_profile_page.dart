import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/donor_profile_page_controller.dart';

class DonorProfilePage extends GetView<DonorProfilePageController> {
  const DonorProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(DonorProfilePageController());
    return const Placeholder();
  }
}
