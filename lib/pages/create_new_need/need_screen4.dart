import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../service/theme_service.dart';
import '../../theme/theme.dart';
import '../../theme/typography.dart';
import '../../util/util.dart';
import '../../widgets/dinasona_button.dart';
import 'controller/create_new_need_controller.dart';

class NeedScreen4 extends GetView<CreateNewNeedController> {
  const NeedScreen4({super.key});

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Get.put(ThemeService()).theme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Gap(getRelativeHeight(40)),
        Text(
          'Tell your story: describe your need'.tr,
          style: CustomTypography.fromColor(theme.shadowed).k16SemiBold,
        ),
        Gap(getRelativeHeight(20)),
        Expanded(
          child: Container(
            height: getRelativeHeight(500),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: theme.graphite),
            ),
            child: Column(
              children: <Widget>[
                TextField(
                  controller: controller.screen1,
                  maxLength: controller.descriptionMaxLenth,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    hintText: 'Tell your story: describe your need',
                  ),
                ),
              ],
            ),
          ),
        ),
        const Spacer(),
        Row(
          children: <Widget>[
            DinasonaButton(
              expand: false,
              text: 'Back'.tr,
              onPressed: () => controller.selectTab(NeedsTab.screen3),
            ),
            const Gap(10),
            Expanded(
              child: DinasonaButton(
                text: 'Continue'.tr,
                onPressed: () => controller.selectTab(NeedsTab.screen5),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
