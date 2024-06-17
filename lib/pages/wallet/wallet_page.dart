import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/wallet_controller.dart';

class WalletPage extends GetView<WalletController> {
  const WalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(WalletController());
    return const Placeholder();
  }
}
