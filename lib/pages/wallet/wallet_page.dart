import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/wallet_page_controller.dart';

class WalletPage extends GetView<WalletPageController> {
  const WalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(WalletPageController());
    return const Placeholder();
  }
}
