import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../service/theme_service.dart';
import '../../theme/theme.dart';
import '../../theme/typography.dart';
import '../../util/util.dart';
import '../../widgets/dinasona_button.dart';
import 'controller/create_new_need_controller.dart';
import 'widgets/image_component.dart';

class NeedScreen5 extends GetView<CreateNewNeedController> {
  const NeedScreen5({super.key});

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Get.put(ThemeService()).theme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Gap(getRelativeHeight(40)),
        Text(
          'Add photos'.tr,
          style: CustomTypography.fromColor(theme.shadowed).k16SemiBold,
        ),
        Obx(
          () => ImageComponentWidget(
            file: controller.selectedImage.value,
            onTap: () {
              controller.pickImage(
                ImageSource.gallery,
                controller.selectedImage,
              );
            },
          ),
        ),
        Gap(getRelativeHeight(10)),
        Obx(
          () => ImageComponentWidget(
            file: controller.selectedImage2.value,
            onTap: () {
              controller.pickImage(
                ImageSource.gallery,
                controller.selectedImage2,
              );
            },
          ),
        ),
        const Spacer(),
        Row(
          children: <Widget>[
            Obx(
              () => DinasonaButton(
                expand: false,
                text: 'Save as draft'.tr,
                locked: !controller.canSaveNewNeed.value,
                onPressed: () {
                  controller.canSaveNewNeed.value = false;
                  controller.onTapdraftButton();
                },
              ),
            ),
            const Gap(10),
            Expanded(
              child: Obx(
                () => DinasonaButton(
                  text: 'Publish'.tr,
                  locked: !controller.canSaveNewNeed.value,
                  onPressed: () {
                    controller.canSaveNewNeed.value = false;
                    controller.onTapPublishButton();
                  },
                ),
              ),
            ),
          ],
        ),
        Gap(getRelativeHeight(20)),
      ],
    );
  }
}
