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
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: CustomScaffold(
        appBarTitle: 'Contact us'.tr,
        padding: true,
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Text(
                "We're here to help! Please share your questions, feedback, or concerns with us."
                    .tr,
                style: CustomTypography.fromColor(theme.graphite).k16Reg,
              ),
              Gap(getRelativeHeight(20)),
              DinasonaTextField(
                hintText: 'Type your message here...'.tr,
                controller: controller.formController,
                maxLines: 18,
              ),
              Gap(getRelativeHeight(20)),
              Obx(
                () => DinasonaButton(
                  text: 'Send'.tr,
                  onPressed: controller.send,
                  locked: !controller.isButtonActive.value,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
