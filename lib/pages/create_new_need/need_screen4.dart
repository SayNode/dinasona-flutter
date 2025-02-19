import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../service/theme_service.dart';
import '../../theme/theme.dart';
import '../../theme/typography.dart';
import '../../util/util.dart';
import '../../widgets/custom_scaffold.dart';
import '../../widgets/dinasona_button.dart';
import 'controller/create_new_need_controller.dart';

class NeedScreen4 extends GetView<CreateNewNeedController> {
  const NeedScreen4({super.key});

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Get.put(ThemeService()).theme;
    return CustomScaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Tell your story: describe your need'.tr,
            style: CustomTypography.fromColor(theme.shadowed).k16SemiBold,
          ),
          Gap(getRelativeHeight(5)),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: theme.shadowed.withAlpha(128),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        textInputAction: TextInputAction.newline,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        controller: controller.screen4,
                        maxLength: controller.descriptionMaxLenth,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Tell your story: describe your need',
                        ),
                      ),
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
          Gap(getRelativeHeight(20)),
        ],
      ),
    );
  }
}
