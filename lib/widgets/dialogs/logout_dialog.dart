import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../pages/choose_path_page.dart';
import '../../service/auth_service.dart';
import '../../service/theme_service.dart';
import '../../theme/theme.dart';
import '../../theme/typography.dart';
import '../../util/util.dart';
import '../dinasona_button.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Get.find<ThemeService>().theme;
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Image.asset(
              'assets/images/logout.png',
              width: 90,
              height: 90,
            ),
            Gap(getRelativeHeight(20)),
            Text(
              'Log out'.tr,
              style: CustomTypography.fromColor(theme.shadowed).k24Bold,
            ),
            Text(
              'Are you sure you want to log out?'.tr,
              style: CustomTypography.fromColor(theme.graphite).k16Reg,
            ),
            Gap(getRelativeHeight(10)),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                DinasonaButton(
                  expand: false,
                  color: theme.silvershine,
                  text: 'Log out'.tr,
                  textColor: theme.graphite,
                  onPressed: () async {
                    await Get.find<AuthService>().logout();
                    await Get.offAll<void>(
                      () => const ChosePathPage(),
                      transition: Transition.upToDown,
                    );
                  },
                ),
                Gap(getRelativeWidth(10)),
                DinasonaButton(
                  expand: false,
                  color: theme.amberglow,
                  text: 'Cancel'.tr,
                  onPressed: Get.back,
                  padding: const EdgeInsets.all(16),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
