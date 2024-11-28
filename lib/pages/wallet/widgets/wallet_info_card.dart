import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../service/localization_controller.dart';
import '../../../service/theme_service.dart';
import '../../../service/wallet_service.dart';
import '../../../theme/theme.dart';
import '../../../theme/typography.dart';
import '../../../util/util.dart';
import '../controllers/wallet_page_controller.dart';

class WalletInfoCard extends GetView<WalletPageController> {
  const WalletInfoCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final WalletService walletService = Get.find<WalletService>();
    final LocalizationController localizationController =
        Get.find<LocalizationController>();
    final CustomTheme theme = Get.put(ThemeService()).theme;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(getRelativeWidth(15)),
      decoration: BoxDecoration(
        color: theme.shadowed,
        borderRadius: BorderRadius.circular(getRelativeWidth(20)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              RichText(
                text: TextSpan(
                  text: '${'Wallet'.tr} ',
                  style: CustomTypography.fromColor(theme.moonstone)
                      .k20Bold
                      .copyWith(fontWeight: FontWeight.w800),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'balance'.tr,
                      style: CustomTypography.fromColor(theme.moonstone)
                          .k20Bold
                          .copyWith(fontWeight: FontWeight.w100),
                    ),
                  ],
                ),
              ),
              Gap(getRelativeHeight(5)),
              Obx(
                () => Text(
                  '${localizationController.selectedCurrency['sign']} ${walletService.balanceInUserCurrency.value}',
                  style: CustomTypography.fromColor(theme.moonstone).k36Bold,
                ),
              ),
              Gap(getRelativeHeight(5)),
              Text(
                'Latest transaction'.tr,
                style: CustomTypography.fromColor(theme.moonstone).k14Reg,
              ),
              Obx(
                () => Text(
                  walletService.timeSinceLastTransaction.value,
                  style:
                      CustomTypography.fromColor(theme.moonstone).k16SemiBold,
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.more_horiz, color: theme.moonstone),
                style: ButtonStyle(
                  visualDensity: VisualDensity.compact,
                  minimumSize: WidgetStateProperty.all(
                    Size.zero,
                  ),
                  padding: WidgetStateProperty.all(
                    EdgeInsets.zero,
                  ),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                onPressed: () {
                  controller.toggleShowWalletOptions();
                },
              ),
              Obx(
                () => controller.showWalletOptions.value
                    ? Container(
                        decoration: BoxDecoration(
                          color: theme.moonstone,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: EdgeInsets.all(getRelativeWidth(10)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            TextButton(
                              style: ButtonStyle(
                                visualDensity: VisualDensity.compact,
                                minimumSize: WidgetStateProperty.all(
                                  Size.zero,
                                ),
                                padding: WidgetStateProperty.all(
                                  EdgeInsets.zero,
                                ),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              onPressed: () {
                                controller.saveSeedPhraseToClipboard(context);
                              },
                              child: Text(
                                'Export/Backup'.tr,
                                style: CustomTypography.fromColor(
                                  theme.shadowed,
                                ).k14Reg,
                              ),
                            ),
                            Gap(getRelativeHeight(5)),
                            TextButton(
                              style: ButtonStyle(
                                visualDensity: VisualDensity.compact,
                                minimumSize: WidgetStateProperty.all(
                                  Size.zero,
                                ),
                                padding: WidgetStateProperty.all(
                                  EdgeInsets.zero,
                                ),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              onPressed: () {
                                controller.deleteUserWallet();
                              },
                              child: Text(
                                'Delete'.tr,
                                style: CustomTypography.fromColor(
                                  theme.inferno,
                                ).k14Reg,
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
