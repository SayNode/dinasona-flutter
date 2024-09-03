import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../service/theme_service.dart';
import '../../theme/theme.dart';
import '../../util/util.dart';
import 'controllers/wallet_page_controller.dart';

class NoWalletConnectedPage extends GetView<WalletPageController> {
  const NoWalletConnectedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Get.put(ThemeService()).theme;
    Get.put(WalletPageController());

    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(getRelativeWidth(20)),
          decoration: BoxDecoration(
            color: theme.silvershine,
            borderRadius: BorderRadius.circular(getRelativeWidth(15)),
          ),
          child: Row(
            children: <Widget>[
              Image.asset(
                'assets/images/bitcoin_logo.png',
                width: getRelativeWidth(50),
                height: getRelativeWidth(50),
              ),
              Column(
                children: <Widget>[
                  const Text('No wallet connected'),
                  ElevatedButton(
                    onPressed: () {
                      controller.isWalletConnected.value = true;
                    },
                    child: const Text('Connect wallet'),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
