import 'package:flutter/material.dart';
import '../../../widgets/custom_scaffold.dart';
import 'package:get/get.dart';

import '../../widgets/beneficiary_bottom_navigation_bar.dart';
import 'controllers/beneficiary_root_controller.dart';

class BeneficiaryRootPage extends GetView<BeneficiaryRootController> {
  const BeneficiaryRootPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(BeneficiaryRootController());
    return Obx(
      () => CustomScaffold(
        body: controller.body[controller.tabIndex.value],
        bottomNavigationBar: BeneficiaryBottomNavigationBar(
          changeTabIndex: controller.changeTabIndex,
          tabIndex: controller.tabIndex.value,
        ),
      ),
    );
  }
}
