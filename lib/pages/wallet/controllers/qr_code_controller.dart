import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../send_bitcoin_page.dart';

class QrCodeController extends GetxController {
  String qrCode = '';
  MobileScannerController scannerController = MobileScannerController();

  void onDetect(BarcodeCapture barcode) {
    qrCode = barcode.barcodes.first.rawValue.toString();
    scannerController.stop();
    Get.off<void>(
      () => SendBitcoinPage(
        bolt11InvoiceFromQRCode: qrCode,
      ),
    );
  }
}
