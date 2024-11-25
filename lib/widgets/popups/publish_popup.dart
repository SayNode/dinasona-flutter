import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../pages/home/controllers/beneficary_home_page_controller.dart';
import '../../pages/root/beneficiary_root_page.dart';
import '../../pages/root/controllers/beneficiary_root_controller.dart';
import '../../service/theme_service.dart';
import '../../service/user_state_service.dart';
import '../../theme/theme.dart';
import '../../theme/typography.dart';
import '../../util/util.dart';

class PublishPopup extends StatelessWidget {
  const PublishPopup({super.key});

  @override
  Widget build(BuildContext context) {
    final UserStateService userStateService = Get.find<UserStateService>();
    final CustomTheme theme = Get.find<ThemeService>().theme;
    return PopScope(
      canPop: false,
      child: SizedBox(
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
                'Need posted successfully!'.tr,
                textAlign: TextAlign.center,
                style: CustomTypography.fromColor(theme.shadowed).k24Bold,
              ),
              Text(
                'Your need has been shared with the community. Thank you for joining Dinasona and trusting us with your needs.'
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
                  unawaited(
                      Get.offAll<void>(() => const BeneficiaryRootPage()));
                },
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  padding:
                      EdgeInsets.symmetric(vertical: getRelativeHeight(20)),
                  decoration: BoxDecoration(
                    color: theme.ferngreen,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    'Return to home'.tr,
                    style:
                        CustomTypography.fromColor(theme.moonstone).k16SemiBold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
