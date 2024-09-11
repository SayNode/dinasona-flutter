import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/custom_scaffold.dart';
import 'controllers/send_receive_bitcoin_controller.dart';
import 'widgets/display_invoice.dart';
import 'widgets/receive_bitcoin_input.dart';

class ReceiveBitcoinPage extends GetView<SendReceiveBitcoinController> {
  const ReceiveBitcoinPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SendReceiveBitcoinController());

    return Obx(
      () => CustomScaffold(
        padding: true,
        appBarTitle: 'Receive'.tr,
        boldTitle: false,
        body: controller.invoiceIsGenerated.value
            ? const DisplayInvoice()
            : const ReceiveBitcoinInput(),
      ),
    );
  }
}
