import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../service/theme_service.dart';
import '../../theme/theme.dart';
import '../../theme/typography.dart';
import '../../util/util.dart';
import '../../widgets/custom_scaffold.dart';
import '../../widgets/dinasona_button.dart';

class UpdatesScreen extends StatelessWidget {
  const UpdatesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Get.put(ThemeService()).theme;
    return CustomScaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getRelativeWidth(20),
          vertical: getRelativeHeight(70),
        ),
        child: Column(
          children: <Widget>[
            Image.asset(
              'assets/images/logos/dinasona_logo.png',
              scale: 2.5,
            ),
            Gap(getRelativeHeight(130)),
            Text(
              'Exciting update'.tr,
              style: CustomTypography.fromColor(theme.shadowed).k36Bold,
            ),
            Gap(getRelativeHeight(10)),
            Text(
              "Discover what's new in our latest version".tr,
              style: CustomTypography.fromColor(theme.graphite).k16Reg,
            ),
            Gap(getRelativeHeight(20)),
            DinasonaButton(
              text: 'Update now',
              onPressed: () {
                //todo: implement update now
              },
              color: theme.amberglow,
            ),
          ],
        ),
      ),
    );
  }
}
