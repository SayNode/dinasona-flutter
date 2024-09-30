import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../controllers/qr_code_controller.dart';

class QrCodeScannerPage extends GetView<QrCodeController> {
  const QrCodeScannerPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(QrCodeController());

    return Scaffold(
      appBar: AppBar(title: Text('Scan your lightning invoice'.tr)),
      body: MobileScanner(
        controller: controller.scannerController,
        onDetect: (BarcodeCapture barcode) {
          controller.onDetect(barcode);
        },
      ),
    );
  }
}
