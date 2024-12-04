import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../service/theme_service.dart';
import '../../service/wallet_service.dart';
import '../../theme/theme.dart';
import '../../theme/typography.dart';
import '../../util/util.dart';
import '../../widgets/dinasona_button.dart';
import 'controllers/wallet_page_controller.dart';
import 'receive_bitcoin_page.dart';
import 'send_bitcoin_page.dart';
import 'widgets/list_of_transactions.dart';
import 'widgets/wallet_info_card.dart';

class WalletConnectedPage extends GetView<WalletPageController> {
  const WalletConnectedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Get.put(ThemeService()).theme;

    controller
      ..getBalanceInUserCurrency()
      ..getTransactions();

    controller.showWalletOptions.value = false;

    return RefreshIndicator(
      color: theme.shadowed,
      onRefresh: () async {
        await controller.getBalanceInUserCurrency();
        await controller.getTransactions();
      },
      child: GestureDetector(
        onTap: () => controller.showWalletOptions.value = false,
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
                    Obx(() {
                      if (Get.find<WalletService>().transactions.isEmpty) {
                        return Expanded(
                          child: Column(
                            children: <Widget>[
                              Text(
                                'Transactions'.tr,
                                style:
                                    CustomTypography.fromColor(theme.shadowed)
                                        .k24Bold,
                              ),
                              Gap(getRelativeHeight(15)),
                              Text('No transactions yet'.tr),
                            ],
                          ),
                        );
                      } else {
                        return const Expanded(
                          child: SingleChildScrollView(
                            child: ListOfTransactions(),
                          ),
                        );
                      }
                    }),
                    Gap(getRelativeHeight(30)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: DinasonaButton(
                            text: 'Receive'.tr,
                            textColor: theme.amberglow,
                            onPressed: () {
                              Get.to<void>(() => const ReceiveBitcoinPage());
                            },
                            color: theme.moonstone,
                            customElevation: 0,
                            borderColor: theme.amberglow,
                          ),
                        ),
                        Gap(getRelativeWidth(10)),
                        Expanded(
                          child: DinasonaButton(
                            text: 'Send'.tr,
                            onPressed: () {
                              Get.to<void>(() => const SendBitcoinPage());
                            },
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
      ),
    );
  }
}
