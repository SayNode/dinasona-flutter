import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/custom_scaffold.dart';
import '../../widgets/donor_bottom_navigation_bar.dart.dart';
import 'controllers/donor_root_page_controller.dart';

class DonorRootPage extends GetView<DonorRootController> {
  const DonorRootPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => CustomScaffold(
        body: controller.body[controller.tabIndex.value],
        bottomNavigationBar: DonorBottomNavigationBar(
          changeTabIndex: controller.changeTabIndex,
          tabIndex: controller.tabIndex.value,
        ),
      ),
    );
  }
}
