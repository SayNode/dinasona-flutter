import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../service/theme_service.dart';
import '../../theme/theme.dart';
import '../../theme/typography.dart';
import '../../util/util.dart';
import '../../widgets/custom_scaffold.dart';
import '../../widgets/dinasona_button.dart';
import '../../widgets/dinasona_textfield.dart';
import 'controllers/contact_us_controller.dart';

class ContactUsPage extends GetView<ContactUsController> {
  const ContactUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Get.find<ThemeService>().theme;
    return CustomScaffold(
      appBarTitle: 'Contact Us'.tr,
      padding: true,
      body: Column(
        children: <Widget>[
          Text(
            "We're here to help! Please share your questions, feedback, or concerns with us."
                .tr,
            style: CustomTypography.fromColor(theme.graphite).k16Reg,
          ),
          const Gap(42),
          DinasonaTextField(
            hintText: 'Type your message here...'.tr,
            controller: controller.formController,
            maxLines: 18,
          ),
          const Spacer(),
          Obx(
            () => DinasonaButton(
              text: 'Send'.tr,
              onPressed: controller.send,
              locked: !controller.isButtonActive.value,
            ),
          ),
          Gap(getRelativeHeight(80)),
        ],
      ),
    );
  }
}
