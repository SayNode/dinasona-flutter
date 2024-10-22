import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../../service/theme_service.dart';
import '../../../../service/wallet_service.dart';
import '../../../../theme/theme.dart';
import '../../../../theme/typography.dart';

class HelpedRecievedWidget extends StatelessWidget {
  const HelpedRecievedWidget({
    required this.peopleHelped,
    required this.amountDonated,
    required this.needsClosed,
    super.key,
  });
  final int peopleHelped;
  final double amountDonated;
  final int needsClosed;

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
                () => Text(
                  '\$ ${double.parse(Get.find<WalletService>().balanceInUSD.value.toStringAsFixed(3))}',
                  style: CustomTypography.fromColor(theme.moonstone).k36Bold,
                ),
              ),
              Text(
                'wallet balance',
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
                        'supported you',
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
                        '$needsClosed needs',
                        style:
                            CustomTypography.fromColor(theme.moonstone).k24Bold,
                      ),
                      Text(
                        'successfully closed',
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
