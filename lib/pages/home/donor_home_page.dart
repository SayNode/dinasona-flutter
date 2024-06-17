import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/donor_home_page_controller.dart';

class DonorHomePage extends GetView<DonorHomePageController> {
  const DonorHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(DonorHomePageController());
    return const Placeholder();
  }
}
