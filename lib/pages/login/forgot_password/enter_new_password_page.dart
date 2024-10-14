import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../service/theme_service.dart';
import '../../../theme/theme.dart';
import '../../../theme/typography.dart';
import '../../../util/util.dart';
import '../../../widgets/custom_scaffold.dart';
import '../../../widgets/dinasona_button.dart';
import '../../../widgets/dinasona_textfield.dart';
import '../../../widgets/header_subheader.dart';
import 'controller/forgot_password_controller.dart';

class EnterNewPasswordPage extends GetView<ForgotPasswordController> {
  const EnterNewPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = ThemeService().theme;

    return CustomScaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: getRelativeHeight(16),
          horizontal: getRelativeWidth(15),
        ),
        child: Center(
          child: Column(
            children: <Widget>[
              HeaderAndSubHeader(
                header: 'Create a new password'.tr,
                subHeader:
                    'Choose a strong and secure password to keep your account safe'
                        .tr,
              ),
              Gap(getRelativeHeight(70)),
              DinasonaTextField(
                //title: 'New password'.tr,
                hintText: 'Create new password'.tr,
                obscureText: true,
                controller: controller.newPasswordController,
              ),
              Gap(getRelativeHeight(30)),
              DinasonaTextField(
                //title: 'Confirm new password'.tr,
                hintText: 'Confirm new password'.tr,
                obscureText: true,
                controller: controller.confirmPasswordController,
                onChanged: (String value) {
                  controller.updateMatch();
                },
              ),
              Gap(getRelativeHeight(20)),
              Obx(
                () => controller.createPasswordError.value.isNotEmpty
                    ? Text(
                        controller.createPasswordError.value,
                        style: CustomTypography.fromColor(
                          theme.inferno,
                        ).k16SemiBold,
                      )
                    : const SizedBox(),
              ),
              const Spacer(),
              Obx(
                () => DinasonaButton(
                  text: 'Change password'.tr,
                  onPressed: () => controller.onPasswordChangeSubmit(),
                  locked:
                      !controller.matches.value || !controller.isStrong.value,
                ),
              ),
              Gap(getRelativeHeight(30)),
            ],
          ),
        ),
      ),
    );
  }
}
