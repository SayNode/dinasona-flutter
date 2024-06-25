import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../service/theme_service.dart';
import '../../theme/theme.dart';
import '../../theme/typography.dart';
import '../../widgets/custom_scaffold.dart';
import '../../widgets/dinasona_button.dart';
import '../../widgets/dinasona_textfield.dart';
import 'controllers/change_password_controller.dart';

class ChangePasswordPage extends GetView<ChangePasswordController> {
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Get.find<ThemeService>().theme;
    return CustomScaffold(
      appBarTitle: 'Change your password'.tr,
      padding: true,
      body: Column(
        children: <Widget>[
          Text(
            'Protect your account with a unique password at least 6 characters long',
            style: CustomTypography.fromColor(theme.graphite).k16Reg,
          ),
          const Gap(42),
          Obx(
            () {
              return DinasonaTextField(
                hintText: 'Current password'.tr,
                obscureText: true,
                controller: controller.currentPasswordController,
                onChanged: (_) => controller.validatePasswords(),
                errorText: controller.errorTextCurrentPassword.value,
              );
            },
          ),
          const Gap(6),
          Obx(
            () {
              return DinasonaTextField(
                hintText: 'New password'.tr,
                obscureText: true,
                controller: controller.newPasswordController,
                onChanged: (_) => controller.validatePasswords(),
                errorText: controller.errorTextNewPassword.value,
              );
            },
          ),
          const Gap(6),
          Obx(
            () {
              return DinasonaTextField(
                hintText: 'Re-enter new password'.tr,
                obscureText: true,
                controller: controller.confirmPasswordController,
                onChanged: (_) => controller.validatePasswords(),
                errorText: controller.errorTextConfirmPassword.value,
              );
            },
          ),
          const Spacer(),
          Obx(
            () {
              return DinasonaButton(
                locked: !controller.validPassword.value,
                text: 'Save'.tr,
                onPressed: controller.submit,
              );
            },
          ),
        ],
      ),
    );
  }
}
