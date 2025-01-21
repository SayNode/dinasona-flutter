import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../../service/localization_controller.dart';
import '../../../../service/theme_service.dart';
import '../../../../service/wallet_service.dart';
import '../../../../theme/theme.dart';
import '../../../../theme/typography.dart';

class PeopleHelpedWidget extends StatelessWidget {
  const PeopleHelpedWidget({
    required this.peopleHelped,
    required this.countries,
    super.key,
  });
  final int peopleHelped;
  final int countries;

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Get.find<ThemeService>().theme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 16,
          ),
          decoration: BoxDecoration(
            color: theme.shadowed,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Obx(
                () => Get.find<WalletService>().isWalletConnected.value
                    ? Text(
                        '${Get.find<LocalizationController>().selectedCurrency.value.sign} ${Get.find<WalletService>().amountSentInUserCurrency.value}',
                        style:
                            CustomTypography.fromColor(theme.moonstone).k36Bold,
                      )
                    : Text(
                        '${Get.find<LocalizationController>().selectedCurrency.value.sign} 0.0',
                        style:
                            CustomTypography.fromColor(theme.moonstone).k36Bold,
                      ),
              ),
              Text(
                'Your generosity fuels positive change',
                style: CustomTypography.fromColor(theme.moonstone).k14Reg,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        const Gap(6),
        IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 16,
                  ),
                  decoration: BoxDecoration(
                    color: theme.ferngreen,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text(
                        '$peopleHelped people',
                        style:
                            CustomTypography.fromColor(theme.moonstone).k24Bold,
                      ),
                      Text(
                        "You've touched numerous lives with your kindness",
                        style:
                            CustomTypography.fromColor(theme.moonstone).k14Reg,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              const Gap(6),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 30,
                  ),
                  decoration: BoxDecoration(
                    color: theme.amberglow,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text(
                        '$countries countries',
                        style:
                            CustomTypography.fromColor(theme.moonstone).k24Bold,
                      ),
                      Text(
                        'Your generosity knows no borders',
                        style:
                            CustomTypography.fromColor(theme.moonstone).k14Reg,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
