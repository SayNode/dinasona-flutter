import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../model/need.dart';
import '../../service/theme_service.dart';
import '../../theme/theme.dart';
import '../../theme/typography.dart';
import '../../util/util.dart';
import '../../widgets/dinasona_button.dart';
import '../home/widgets/need_field_chip.dart';
import 'controller/create_new_need_controller.dart';

class NeedScreen2 extends GetView<CreateNewNeedController> {
  const NeedScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Get.put(ThemeService()).theme;
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Gap(getRelativeHeight(40)),
          Text(
            'Choose a category for your need'.tr,
            style: CustomTypography.fromColor(theme.shadowed).k16SemiBold,
          ),
          Gap(getRelativeHeight(10)),
          Wrap(
            spacing: getRelativeWidth(5),
            runSpacing: getRelativeHeight(6),
            children: <Widget>[
              for (final NeedField field in NeedField.values)
                NeedFieldChip(
                  field: field,
                  selected: controller.selectedNeedFields.contains(field),
                  onTap: () => controller.selectedNeedFields.contains(field)
                      ? controller.selectedNeedFields.remove(field)
                      : controller.selectedNeedFields.add(field),
                ),
            ],
          ),
          const Spacer(),
          Row(
            children: <Widget>[
              DinasonaButton(
                expand: false,
                showBackIcon: true,
                text: 'Back'.tr,
                onPressed: () => controller.selectTab(NeedsTab.screen1),
                locked: controller.selectedNeedFields.isEmpty,
              ),
              const Gap(10),
              Expanded(
                child: DinasonaButton(
                  text: 'Continue'.tr,
                  onPressed: () => controller.selectTab(NeedsTab.screen3),
                  locked: controller.selectedNeedFields.isEmpty,
                ),
              ),
            ],
          ),
          Gap(getRelativeHeight(20)),
        ],
      ),
    );
  }
}
