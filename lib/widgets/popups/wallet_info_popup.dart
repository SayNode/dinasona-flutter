import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../service/theme_service.dart';
import '../../../theme/theme.dart';
import '../../../util/util.dart';
import '../../theme/typography.dart';
import '../dinasona_button.dart';

class Walletinfopopup extends StatelessWidget {
  const Walletinfopopup({
    required this.title,
    required this.description,
    super.key,
  });

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Get.find<ThemeService>().theme;
    return Dialog(
      child: Container(
        padding: EdgeInsets.all(getRelativeWidth(15)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              Symbols.account_balance_wallet,
              weight: 700,
              color: theme.ferngreen,
              size: 50,
            ),
            Gap(getRelativeHeight(15)),
            Text(
              title,
              textAlign: TextAlign.center,
              style: CustomTypography.fromColor(theme.shadowed).k24Bold,
            ),
            Gap(getRelativeHeight(5)),
            Text(
              description,
              textAlign: TextAlign.center,
              style: CustomTypography.fromColor(theme.shadowed).k16Reg,
            ),
            Gap(getRelativeHeight(5)),
            DinasonaButton(
              text: 'OK',
              onPressed: Get.back,
              color: theme.amberglow,
            ),
          ],
        ),
      ),
    );
  }
}
