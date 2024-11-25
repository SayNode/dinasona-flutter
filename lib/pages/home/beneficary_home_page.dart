import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../service/theme_service.dart';
import '../../theme/theme.dart';
import '../../theme/typography.dart';
import '../../util/util.dart';
import 'controllers/beneficary_home_page_controller.dart';
import 'widgets/all_needs_widget.dart';
import 'widgets/create_need_container_widget.dart';
import 'widgets/tab_header_widget.dart';

class BeneficiaryHomePage extends GetView<BeneficiaryHomePageController> {
  const BeneficiaryHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(BeneficiaryHomePageController());
    final CustomTheme theme = Get.put(ThemeService()).theme;

    return Obx(
      () => RefreshIndicator(
        onRefresh: () => controller.onRefresh(),
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: getRelativeHeight(16)),
          children: <Widget>[
            Gap(getRelativeHeight(20)),
            Text(
              controller.userNameForGreeting.value.isNotEmpty
                  ? '${controller.getGreetingMessage()}, ${controller.userNameForGreeting.value}'
                  : controller.getGreetingMessage(),
              style: CustomTypography.fromColor(theme.shadowed).k24Bold,
            ),
            const Gap(20),
            const CreateNeedContainerWidget(),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.file_download_outlined,
                    color: theme.shadowed,
                    size: getRelativeWidth(18),
                  ),
                  const Gap(10),
                  Flexible(
                    child: AutoSizeText(
                      'Download our PDF guide and explore using the app'.tr,
                      maxLines: 2,
                      style: CustomTypography.fromColor(theme.shadowed).k14Reg,
                    ),
                  ),
                ],
              ),
            ),
            const Gap(30),
            Text(
              'Your needs'.tr,
              style: CustomTypography.fromColor(theme.shadowed).k20Bold,
            ),
            const Gap(10),
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Expanded(
                    child: TabHeaderWidget(
                      text: 'All (${controller.needs.length})'.tr,
                      selected:
                          controller.currentTab.value == NeedsTab.allNeeds,
                      onTap: () => controller.selectTab(NeedsTab.allNeeds),
                    ),
                  ),
                  Expanded(
                    child: TabHeaderWidget(
                      text: 'Ongoing (${controller.onGoingNeeds.length})'.tr,
                      selected: controller.currentTab.value == NeedsTab.ongoing,
                      onTap: () => controller.selectTab(NeedsTab.ongoing),
                    ),
                  ),
                  Expanded(
                    child: TabHeaderWidget(
                      text: 'Past (${controller.pastNeeds.length})'.tr,
                      selected: controller.currentTab.value == NeedsTab.past,
                      onTap: () => controller.selectTab(NeedsTab.past),
                    ),
                  ),
                  Expanded(
                    child: TabHeaderWidget(
                      text: 'Draft (${controller.draftNeeds.length})'.tr,
                      selected: controller.currentTab.value == NeedsTab.draft,
                      onTap: () => controller.selectTab(NeedsTab.draft),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height:
                  400, // Add fixed height for PageView or ensure it’s scrollable
              child: PageView(
                controller: controller.pageController,
                onPageChanged: controller.onTabChange,
                children: <Widget>[
                  TabNeedWidget(needs: controller.needs),
                  TabNeedWidget(needs: controller.onGoingNeeds),
                  TabNeedWidget(
                    needs: controller.pastNeeds,
                  ),
                  TabNeedWidget(
                    needs: controller.draftNeeds,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
