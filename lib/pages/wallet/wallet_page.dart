import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../util/util.dart';
import '../../theme/typography.dart';
import 'controllers/wallet_page_controller.dart';
import 'no_wallet_connected_page.dart';
import 'wallet_connected_page.dart';

class WalletPage extends GetView<WalletPageController> {
  const WalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: getRelativeWidth(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Gap(getRelativeHeight(20)),
          Text(
            'Wallet'.tr,
            style: CustomTypography.fromColor(Colors.black).k24Bold,
          ),
          Obx(
            () => controller.isWalletConnected.isTrue
                ? const WalletConnectedPage()
                : const NoWalletConnectedPage(),
          ),
        ],
      ),
    );
  }
}
