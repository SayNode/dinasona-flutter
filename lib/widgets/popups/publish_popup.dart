import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../service/theme_service.dart';
import '../../theme/theme.dart';
import '../../theme/typography.dart';
import '../../util/util.dart';

class PublishPopup extends StatelessWidget {
  const PublishPopup({super.key});

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
              onTap: () {
                Get.close(3);
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
                  'Return to home'.tr,
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
