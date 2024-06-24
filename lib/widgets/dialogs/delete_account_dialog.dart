import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../pages/choose_path_page.dart';
import '../../service/auth_service.dart';
import '../../service/theme_service.dart';
import '../../theme/theme.dart';
import '../../theme/typography.dart';
import '../../util/util.dart';
import '../dinasona_button.dart';

class DeleteAccountDialog extends StatelessWidget {
  const DeleteAccountDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Get.find<ThemeService>().theme;
    return AlertDialog(
      icon: Image.asset(
        'assets/images/delete_user.png',
        width: 90,
        height: 90,
      ),
      title: Text(
        'Delete account'.tr,
        style: CustomTypography.fromColor(theme.shadowed).k24Bold,
      ),
      content: Text(
        textAlign: TextAlign.center,
        'Just checking: are you sure you want to delete?'.tr,
        style: CustomTypography.fromColor(theme.graphite).k16Reg,
      ),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actions: <Widget>[
        DinasonaButton(
          expand: false,
          color: theme.silvershine,
          text: 'Yes, I am'.tr,
          textColor: theme.graphite,
          onPressed: () async {
            await Get.find<AuthService>().deleteUser();
            await Get.offAll<void>(
              () => const ChosePathPage(),
              transition: Transition.upToDown,
            );
          },
          padding: EdgeInsets.all(getRelativeWidth(14)),
        ),
        DinasonaButton(
          expand: false,
          color: theme.amberglow,
          text: 'No, I am not'.tr,
          onPressed: Get.back,
          padding: EdgeInsets.all(getRelativeWidth(14)),
        ),
      ],
    );
  }
}
