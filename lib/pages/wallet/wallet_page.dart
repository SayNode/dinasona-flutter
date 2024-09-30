import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/wallet_page_controller.dart';
import 'no_wallet_connected_page.dart';
import 'wallet_connected_page.dart';

class WalletPage extends GetView<WalletPageController> {
  const WalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isWalletConnected.value
          ? const WalletConnectedPage()
          : const NoWalletConnectedPage(),
    );
  }
}
