import 'package:get/get.dart';

import '../../../service/breez_service.dart';
import '../show_seed_phrase_page.dart';

class WalletPageController extends GetxController {
  RxBool isWalletConnected = false.obs;
  RxString seedPhrase = ''.obs;

  BreezService breezService = Get.find<BreezService>();

  void seedPhraseConfirmation() {
    seedPhrase.value = breezService.generateSeedPhrase();
    Get.to<void>(() => const ShowSeedPhrasePage());
  }

  Future<void> createWallet() async {
    await breezService.connectToNode(seedPhrase.value);
  }

  Future<void> importWallet(String seedPhrase) async {
    //await breezService.connectToNode(seedPhrase);
  }
}
