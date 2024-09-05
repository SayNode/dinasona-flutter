import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../service/theme_service.dart';
import '../../theme/theme.dart';
import '../../theme/typography.dart';
import '../../util/util.dart';
import 'controllers/wallet_page_controller.dart';

class WalletConnectedPage extends GetView<WalletPageController> {
  const WalletConnectedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Get.put(ThemeService()).theme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(getRelativeWidth(15)),
          decoration: BoxDecoration(
            color: theme.shadowed,
            borderRadius: BorderRadius.circular(getRelativeWidth(20)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              RichText(
                text: TextSpan(
                  text: '${'Wallet'.tr} ',
                  style: CustomTypography.fromColor(theme.moonstone).k20Bold,
                  children: <TextSpan>[
                    TextSpan(
                      text: 'balance',
                      style: CustomTypography.fromColor(theme.moonstone)
                          .k20Bold
                          .copyWith(fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
