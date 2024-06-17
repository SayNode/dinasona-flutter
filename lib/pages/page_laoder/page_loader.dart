import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/custom_scaffold.dart';
import '../../widgets/dinasona_navbar.dart';
import 'controllers/page_loader_controller.dart';

class PageLoader extends GetView<PageLoaderController> {
  const PageLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Obx(
        () => controller.body[controller.tabIndex.value],
      ),
      bottomNavigationBar: DinasonaNavbar(
        changeTabIndex: controller.changeTabIndex,
        tabIndex: controller.tabIndex,
      ),
    );
  }
}
