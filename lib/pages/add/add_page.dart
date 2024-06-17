import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/add_controller.dart';

class AddPage extends GetView<AddController> {
  const AddPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AddController());
    return const Placeholder();
  }
}
