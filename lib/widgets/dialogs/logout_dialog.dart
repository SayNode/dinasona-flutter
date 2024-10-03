import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../pages/choose_path_page.dart';
import '../../service/auth_service.dart';
import '../../service/theme_service.dart';
import '../../service/user_state_service.dart';
import '../../theme/theme.dart';
import '../../theme/typography.dart';
import '../../util/util.dart';
import '../dinasona_button.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Get.find<ThemeService>().theme;
    final UserStateService userStateService = Get.find<UserStateService>();

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
              textAlign: TextAlign.center,
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
                    userStateService.clear();
                    await Get.to<void>(
                      () => const ChosePathPage(),
                      transition: Transition.upToDown,
                    );
                  },
                  padding: EdgeInsets.all(getRelativeWidth(14)),
                ),
                Gap(getRelativeWidth(30)),
                DinasonaButton(
                  expand: false,
                  color: theme.amberglow,
                  text: 'Cancel'.tr,
                  onPressed: () => Get.back<void>(),
                  padding: EdgeInsets.all(getRelativeWidth(14)),
                ),
              ],
            ),
          ],
        ),
      ),
    );

    /* return AlertDialog(
      icon: Image.asset(
        'assets/images/logout.png',
        width: 90,
        height: 90,
      ),
      title: Text(
        'Log out'.tr,
        style: CustomTypography.fromColor(theme.shadowed).k24Bold,
      ),
      content: Text(
        'Are you sure you want to log out?'.tr,
        style: CustomTypography.fromColor(theme.graphite).k16Reg,
      ),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actions: <Widget>[
        DinasonaButton(
          expand: false,
          color: theme.silvershine,
          text: 'Log out'.tr,
          textColor: theme.graphite,
          onPressed: () async {
            await Get.find<AuthService>().logout();
            userStateService.clear();
            await Get.offAll<void>(
              () => const ChosePathPage(),
              transition: Transition.upToDown,
            );
          },
          padding: const EdgeInsets.all(16),
        ),
      ],
    ); */
  }
}
