import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../service/theme_service.dart';
import '../../../theme/theme.dart';
import '../../../theme/typography.dart';
import '../../../util/util.dart';
import '../controllers/beneficary_home_page_controller.dart';

class CreateNeedContainerWidget extends GetView<BeneficiaryHomePageController> {
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
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              child: Padding(
                padding: EdgeInsets.only(right: getRelativeWidth(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      'Create a need'.tr,
                      style:
                          CustomTypography.fromColor(theme.moonstone).k24Bold,
                    ),
                    AutoSizeText(
                      'Create your need and share your story dsd'.tr,
                      maxLines: 2,
                      style: CustomTypography.fromColor(theme.moonstone).k14Reg,
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: controller.openStoryPopup,
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
