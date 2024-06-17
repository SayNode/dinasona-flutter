import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/add_page_controller.dart';

class AddPage extends GetView<AddPageController> {
  const AddPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AddPageController());
    return const Placeholder();
  }
}
