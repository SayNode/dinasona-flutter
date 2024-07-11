import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../service/theme_service.dart';
import '../../../service/upgrader_service.dart';
import '../../../theme/theme.dart';
import '../../../theme/typography.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Get.find<ThemeService>().theme;
    final UpgraderService upgraderService = Get.find<UpgraderService>();
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            'Version ${upgraderService.version}+${upgraderService.buildNumber}',
            style: CustomTypography.fromColor(theme.shadowed).k14Reg,
          ),
          const Gap(12),
          Text(
            ' Made with 💚 by Donosora for a better future',
            style: CustomTypography.fromColor(theme.ferngreen).k14Reg,
          ),
        ],
      ),
    );
  }
}
