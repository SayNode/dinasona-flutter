import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../pages/home/controllers/beneficary_home_page_controller.dart';
import '../../pages/root/controllers/beneficiary_root_controller.dart';
import '../../service/theme_service.dart';
import '../../service/user_state_service.dart';
import '../../theme/theme.dart';
import '../../theme/typography.dart';
import '../../util/util.dart';

class DraftPopup extends StatelessWidget {
  const DraftPopup({super.key});

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Get.find<ThemeService>().theme;
    final UserStateService userStateService = Get.find<UserStateService>();
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SvgPicture.asset(
              'assets/images/volunteer.svg',
              width: getRelativeWidth(83),
              height: getRelativeHeight(83),
            ),
            Text(
              'Draft saved!'.tr,
              textAlign: TextAlign.center,
              style: CustomTypography.fromColor(theme.shadowed).k24Bold,
            ),
            Text(
              'Your need has been saved as a draft. You can continue editing or post it when ready.'
                  .tr,
              textAlign: TextAlign.center,
              style: CustomTypography.fromColor(theme.graphite).k16Reg,
            ),
            Gap(getRelativeHeight(10)),
            InkWell(
              onTap: () async {
                await userStateService.fetchUserInfo();
                await userStateService.fetchBeneficiaryInfo();
                await Get.find<BeneficiaryHomePageController>().onRefresh();
                Get.find<BeneficiaryRootController>().changeTabIndex(0);
                //unawaited(Get.off<void>(() => const BeneficiaryRootPage()));
                // ignore: use_if_null_to_convert_nulls_to_bools
                if (Get.isDialogOpen == true) {
                  Get.back();
                }
              },
              child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: getRelativeHeight(20)),
                decoration: BoxDecoration(
                  color: theme.ferngreen,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  'View drafts',
                  style:
                      CustomTypography.fromColor(theme.moonstone).k16SemiBold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
