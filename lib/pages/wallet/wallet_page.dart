import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/custom_scaffold.dart';
import 'controllers/wallet_page_controller.dart';
import 'no_wallet_connected_page.dart';

class WalletPage extends GetView<WalletPageController> {
  const WalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(WalletPageController());

    return CustomScaffold(
      padding: true,
      showBackButtonInAppBar: false,
      appBarTitle: 'Wallet'.tr,
      body: Obx(
        () => controller.isWalletConnected.isTrue
            ? const Placeholder()
            : const NoWalletConnectedPage(),
      ),
    );
  }
}
