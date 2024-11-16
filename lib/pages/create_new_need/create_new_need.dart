import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../model/need.dart';
import '../../service/theme_service.dart';
import '../../theme/theme.dart';
import '../../theme/typography.dart';
import '../../util/util.dart';
import 'controller/create_new_need_controller.dart';
import 'need_screen1.dart';
import 'need_screen2.dart';
import 'need_screen3.dart';
import 'need_screen4.dart';
import 'need_screen5.dart';
import 'widgets/progress_bar.dart';

class CreateNewNeed extends GetView<CreateNewNeedController> {
  const CreateNewNeed({super.key, this.need});

  final Need? need;

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Get.put(ThemeService()).theme;
    Get.put(CreateNewNeedController());

    // If wanted in the future edit to be able to edit current areas of interest and photos
    controller.isEditingNeed.value = need != null;
    if (need != null) {
      controller.editingNeedId.value = need!.id;

      final String tmpAmount = need!.amount == need!.amount.toInt()
          ? need!.amount.toInt().toString()
          : need!.amount.toString();

      controller.screen1.text = need!.title;
      controller.screen3.text = tmpAmount;
      controller.screen4.text = need!.description;
    }

    return GestureDetector(
      behavior: HitTestBehavior.opaque, // Ensure gestures pass through
      onTap: () => FocusScope.of(context).unfocus(),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: getRelativeWidth(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Gap(getRelativeHeight(20)),
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
                    GestureDetector(
                      onTap: () {
                        // Navigate to the tapped page
                        controller.pageController.animateToPage(
                          i,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                        // Update the current page and tab
                        controller.currentPage.value = i;
                        controller.currentTab.value = NeedsTab.values[i];
                      },
                      child: ProgressBar(
                        selected: controller.currentPage.value == i,
                      ),
                    ),
                ],
              ),
            ),
            Expanded(
              child: Obx(() {
                controller.currentPage.value;
                controller.initializePageController();

                return PageView(
                  // ignore: always_specify_types

                  physics: const PageScrollPhysics(),
                  controller: controller.pageController,
                  onPageChanged: (int index) {
                    controller.currentPage.value = index;
                    controller.currentTab.value = NeedsTab.values[index];
                  },
                  children: const <Widget>[
                    NeedScreen1(),
                    NeedScreen2(),
                    NeedScreen3(),
                    NeedScreen4(),
                    NeedScreen5(),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
