import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../service/theme_service.dart';
import '../../theme/theme.dart';
import '../../theme/typography.dart';
import '../../util/util.dart';
import '../../widgets/dinasona_button.dart';
import 'controller/create_new_need_controller.dart';

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
        const Spacer(),
        Row(
          children: <Widget>[
            DinasonaButton(
              expand: false,
              text: 'Save as draft'.tr,
              onPressed: () {},
            ),
            const Gap(10),
            Expanded(
              child: DinasonaButton(
                text: 'Publish'.tr,
                onPressed: () {},
              ),
            ),
          ],
        ),
      ],
    );
  }
}
