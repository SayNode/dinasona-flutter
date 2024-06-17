import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../service/theme_service.dart';
import '../../theme/theme.dart';
import '../../theme/typography.dart';
import '../../widgets/custom_scaffold.dart';
import 'controller/home_controller.dart';
import 'widgets/all_needs_widget.dart';
import 'widgets/create_need_container_widget.dart';

class BeneficiaryHomeScreen extends GetView<HomeController> {
  const BeneficiaryHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeService service = Get.find<ThemeService>();
    Get.put(HomeController());
    final CustomTheme theme = service.theme;
    return CustomScaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Gap(30),
            Text(
              'Good morning, Fatima'.tr,
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
                    size: 14,
                  ),
                  const Gap(10),
                  Text(
                    'Download our PDF guide and explore using the app'.tr,
                    style: CustomTypography.fromColor(theme.shadowed).k14Reg,
                  ),
                ],
              ),
            ),
            const Gap(30),
            Text(
              'Your needs'.tr,
              style: CustomTypography.fromColor(theme.shadowed).k20Bold,
            ),
            Expanded(
              child: PageView(
                controller: controller.pageController,
                onPageChanged: controller.onTabChange,
                children: const <Widget>[
                  AllNeedsWidget(),
                  AllNeedsWidget(),
                  AllNeedsWidget(),
                  AllNeedsWidget(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
