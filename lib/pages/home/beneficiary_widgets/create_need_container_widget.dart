import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../service/theme_service.dart';
import '../../../theme/theme.dart';
import '../../../theme/typography.dart';

class CreateNeedContainerWidget extends StatelessWidget {
  const CreateNeedContainerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeService service = Get.find<ThemeService>();
    final CustomTheme theme = service.theme;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: theme.ferngreen,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Create a need'.tr,
                  style: CustomTypography.fromColor(theme.moonstone).k24Bold,
                ),
                Text(
                  'Create your need and share your story'.tr,
                  style: CustomTypography.fromColor(theme.moonstone).k14Reg,
                ),
                const Gap(20),
              ],
            ),
            InkWell(
              onTap: () {},
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: theme.silvershine,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Icon(
                    Icons.add,
                    color: theme.ferngreen,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
