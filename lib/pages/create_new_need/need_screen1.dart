import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../service/theme_service.dart';
import '../../theme/theme.dart';
import '../../theme/typography.dart';
import '../../util/util.dart';
import '../../widgets/dinasona_button.dart';
import '../../widgets/dinasona_textfield.dart';
import 'controller/create_new_need_controller.dart';

class NeedScreen1 extends GetView<CreateNewNeedController> {
  const NeedScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Get.put(ThemeService()).theme;
    Get.put(CreateNewNeedController());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Gap(getRelativeHeight(40)),
        Text(
          'Give your need a title'.tr,
          style: CustomTypography.fromColor(theme.shadowed).k16SemiBold,
        ),
        DinasonaTextField(
          hintText: 'Give your need a title',
          controller: controller.screen1,
          maxLength: 255,
        ),
        const Spacer(),
        Obx(
          () => DinasonaButton(
            text: 'Continue'.tr,
            onPressed: () => controller.selectTab(NeedsTab.screen2),
            // ignore: avoid_bool_literals_in_conditional_expressions
            locked: controller.initialized
                ? !controller.isScreen1ButtonActive.value
                : true,
          ),
        ),
        Gap(getRelativeHeight(20)),
      ],
    );
  }
}
