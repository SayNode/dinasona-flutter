import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../service/theme_service.dart';
import '../../theme/theme.dart';
import '../../theme/typography.dart';
import '../../util/util.dart';
import '../../widgets/dinasona_button.dart';
import 'controllers/wallet_page_controller.dart';
import 'import_wallet_page.dart';

class NoWalletConnectedPage extends GetView<WalletPageController> {
  const NoWalletConnectedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Get.put(ThemeService()).theme;

    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: getRelativeWidth(30)),
          padding: EdgeInsets.all(getRelativeWidth(15)),
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
              Gap(getRelativeWidth(15)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Bitcoin'.tr,
                      style: CustomTypography.fromColor(theme.shadowed)
                          .k16SemiBold,
                    ),
                    Text(
                      'Set up a new  Bitcoin wallet to securely manage your digital assets.'
                          .tr,
                      style: CustomTypography.fromColor(theme.shadowed).k16Reg,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Gap(getRelativeWidth(30)),
        DinasonaButton(
          text: 'Create wallet'.tr,
          onPressed: () {
            controller.goToSeedPhraseConfirmation();
          },
          color: theme.amberglow,
        ),
        Gap(getRelativeWidth(5)),
        DinasonaButton(
          text: 'Import wallet'.tr,
          onPressed: () {
            Get.to<void>(() => const ImportWalletPage());
          },
          color: theme.moonstone,
          textColor: theme.shadowed,
          customElevation: 0,
        ),
      ],
    );
  }
}
