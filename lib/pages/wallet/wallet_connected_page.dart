import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../service/theme_service.dart';
import '../../theme/theme.dart';
import '../../theme/typography.dart';
import '../../util/util.dart';
import '../../widgets/dinasona_button.dart';
import 'controllers/wallet_page_controller.dart';
import 'widgets/list_of_transactions.dart';
import 'widgets/wallet_info_card.dart';

class WalletConnectedPage extends GetView<WalletPageController> {
  const WalletConnectedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Get.put(ThemeService()).theme;

    /* controller
      ..getBalanceInUSD()
      ..getTransactions(); */

    return RefreshIndicator(
      color: theme.shadowed,
      onRefresh: () async {
        //await controller.getBalanceInUSD();
        await controller.getTransactions();
      },
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: <Widget>[
          SliverFillRemaining(
            child: Padding(
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
                  Gap(getRelativeHeight(15)),
                  const WalletInfoCard(),
                  Gap(getRelativeHeight(30)),
                  const Expanded(
                    child: SingleChildScrollView(child: ListOfTransactions()),
                  ),
                  Gap(getRelativeHeight(30)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: DinasonaButton(
                          text: 'Receive'.tr,
                          textColor: theme.amberglow,
                          onPressed: () {},
                          color: theme.moonstone,
                          customElevation: 0,
                          borderColor: theme.amberglow,
                        ),
                      ),
                      Gap(getRelativeWidth(10)),
                      Expanded(
                        child: DinasonaButton(
                          text: 'Send'.tr,
                          onPressed: () {},
                          color: theme.amberglow,
                        ),
                      ),
                    ],
                  ),
                  Gap(getRelativeHeight(30)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
