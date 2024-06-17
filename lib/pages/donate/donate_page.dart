import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/donate_page_controller.dart';

class DonatePage extends GetView<DonatePageController> {
  const DonatePage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(DonatePageController());
    return const Placeholder();
  }
}
