import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../pages/personal_details_page/personal_details_page.dart';
import '../../service/theme_service.dart';
import '../../theme/theme.dart';
import '../../theme/typography.dart';
import '../../util/util.dart';

class StoryPopup extends StatelessWidget {
  const StoryPopup({super.key});

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Get.find<ThemeService>().theme;
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
              'Your story matters!'.tr,
              textAlign: TextAlign.center,
              style: CustomTypography.fromColor(theme.shadowed).k24Bold,
            ),
            Text(
              'People are more inclined to donate when they know about you. Please share your story to help others understand your needs and support you better.'
                  .tr,
              textAlign: TextAlign.center,
              style: CustomTypography.fromColor(theme.graphite).k16Reg,
            ),
            Gap(getRelativeHeight(10)),
            InkWell(
              onTap: () {
                unawaited(Get.off<void>(() => const PersonalDetailsPage()));
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
                  'Share my story'.tr,
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
