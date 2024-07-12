import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../pages/choose_path_page.dart';
import '../../service/auth_service.dart';
import '../../service/theme_service.dart';
import '../../service/user_state_service.dart';
import '../../theme/theme.dart';
import '../../theme/typography.dart';
import '../dinasona_button.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Get.find<ThemeService>().theme;
    final UserStateService userStateService = Get.find<UserStateService>();
    return AlertDialog(
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
    );
  }
}
