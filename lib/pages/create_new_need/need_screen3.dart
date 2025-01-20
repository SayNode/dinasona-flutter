import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../service/localization_controller.dart';
import '../../service/theme_service.dart';
import '../../theme/theme.dart';
import '../../theme/typography.dart';
import '../../util/util.dart';
import '../../widgets/dinasona_button.dart';
import '../../widgets/dinasona_textfield.dart';
import 'controller/create_new_need_controller.dart';

class NeedScreen3 extends GetView<CreateNewNeedController> {
  const NeedScreen3({super.key});

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Get.put(ThemeService()).theme;
    final LocalizationController localizationController =
        Get.find<LocalizationController>();
    final CreateNewNeedController controller =
        Get.put(CreateNewNeedController());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Gap(getRelativeHeight(40)),
        Text(
          'Specify amount needed'.tr,
          style: CustomTypography.fromColor(theme.shadowed).k16SemiBold,
        ),
        DinasonaTextField(
          hintText: 'Enter amount',
          controller: controller.screen3,
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.allow(RegExp('[0-9]')),
            FilteringTextInputFormatter.digitsOnly,
          ],
          suffixIcon: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Text(
              localizationController.selectedCurrency['code'] ?? 'usd',
              textAlign: TextAlign.center,
              style: CustomTypography.fromColor(theme.shadowed).k14Reg,
            ),
          ),
        ),
        Gap(getRelativeHeight(10)),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            InkWell(
              onTap: controller.openCurrency,
              child: Text(
                'Change currency',
                style: CustomTypography.fromColor(theme.graphite).k16SemiBold,
              ),
            ),
            Gap(getRelativeWidth(5)),
            SvgPicture.asset('assets/images/question_mark.svg'),
          ],
        ),
        const Spacer(),
        Obx(
          () => Row(
            children: <Widget>[
              DinasonaButton(
                expand: false,
                showBackIcon: true,
                text: 'Back'.tr,
                onPressed: () => controller.selectTab(NeedsTab.screen2),
                // ignore: avoid_bool_literals_in_conditional_expressions
                locked: controller.initialized
                    ? !controller.isScreen1ButtonActive.value
                    : true,
              ),
              const Gap(10),
              Expanded(
                child: DinasonaButton(
                  text: 'Continue'.tr,
                  onPressed: () => controller.selectTab(NeedsTab.screen4),
                  locked: !controller.isScreen3ButtonActive.value,
                ),
              ),
            ],
          ),
        ),
        Gap(getRelativeHeight(20)),
      ],
    );
  }
}
