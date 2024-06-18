import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../service/theme_service.dart';
import '../../theme/theme.dart';
import '../../theme/typography.dart';
import '../../util/util.dart';
import '../../widgets/custom_scaffold.dart';
import 'controller/create_new_need_controller.dart';
import 'need_screen1.dart';
import 'need_screen2.dart';
import 'widgets/progress_bar.dart';

class CreateNewNeed extends GetView<CreateNewNeedController> {
  const CreateNewNeed({super.key});

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Get.put(ThemeService()).theme;
    Get.put(CreateNewNeedController());
    return CustomScaffold(
      padding: true,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Gap(30),
          Text(
            'Create a need'.tr,
            style: CustomTypography.fromColor(theme.shadowed).k24Bold,
          ),
          Gap(getRelativeHeight(20)),
          Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                for (int i = 0; i < 5; i++)
                  ProgressBar(
                    selected: controller.currentTab.value == NeedsTab.values[i],
                  ),
              ],
            ),
          ),
          Expanded(
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: controller.pageController,
              onPageChanged: (int index) =>
                  controller.currentPage.value = index,
              children: const <Widget>[
                NeedScreen1(),
                NeedScreen2(),
                NeedScreen1(),
                NeedScreen1(),
                NeedScreen1(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
