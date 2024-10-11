import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../service/theme_service.dart';
import '../../theme/theme.dart';
import '../../theme/typography.dart';
import '../../util/util.dart';

class ContributionPopup extends StatelessWidget {
  const ContributionPopup({super.key});

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
              'Your contribution made a difference'.tr,
              textAlign: TextAlign.center,
              style: CustomTypography.fromColor(theme.shadowed).k24Bold,
            ),
            Text(
              'Someone is thankful for your generosity. Explore more ways to help.'
                  .tr,
              textAlign: TextAlign.center,
              style: CustomTypography.fromColor(theme.graphite).k16Reg,
            ),
            Gap(getRelativeHeight(10)),
            InkWell(
              //todo: change this later
              onTap: Get.back,
              child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: getRelativeHeight(20)),
                decoration: BoxDecoration(
                  color: theme.ferngreen,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  'Explore more',
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
