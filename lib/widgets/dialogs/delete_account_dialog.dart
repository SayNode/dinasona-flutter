import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../pages/donor_settings_page/widgets/delete_account_bottom_sheet.dart';
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
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Image.asset(
              'assets/images/delete_user.png',
              width: 90,
              height: 90,
            ),
            Gap(getRelativeHeight(20)),
            Text(
              'Delete account'.tr,
              style: CustomTypography.fromColor(theme.shadowed).k24Bold,
            ),
            Text(
              textAlign: TextAlign.center,
              'Just checking: are you sure you want to delete?'.tr,
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
                  text: 'Yes, I am'.tr,
                  textColor: theme.graphite,
                  onPressed: () {
                    Get.bottomSheet(
                      const DeleteAccountBottomSheet(),
                    );
                  },
                  padding: EdgeInsets.all(getRelativeWidth(14)),
                ),
                Gap(getRelativeWidth(30)),
                DinasonaButton(
                  expand: false,
                  color: theme.amberglow,
                  text: 'No, I am not'.tr,
                  onPressed: Get.back,
                  padding: EdgeInsets.all(getRelativeWidth(14)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
