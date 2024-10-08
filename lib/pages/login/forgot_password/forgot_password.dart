// ignore_for_file: inference_failure_on_function_invocation

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../service/theme_service.dart';
import '../../../theme/theme.dart';
import '../../../util/util.dart';
import '../../../widgets/custom_scaffold.dart';
import '../../../widgets/dinasona_button.dart';
import '../../../widgets/dinasona_textfield.dart';
import 'controller/forgot_password_controller.dart';
import '../../../theme/typography.dart';

class ForgotPassword extends GetView<ForgotPasswordController> {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ForgotPasswordController());
    final CustomTheme theme = Get.find<ThemeService>().theme;
    String errorMessage;

    return CustomScaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: getRelativeHeight(8),
            horizontal: getRelativeWidth(12),
          ),
          child: Column(
            children: <Widget>[
              /* HeaderAndSubHeader(
                header: 'Forgot Password?'.tr,
                subHeader:
                    'Don’t worry! It happens. Please enter the email associated with your account.'
                        .tr,
              ), */
              const Gap(50),
              Obx(
                () => DinasonaTextField(
                  //title: 'Email address'.tr,
                  hintText: 'name@email.com',
                  // ignore: avoid_bool_literals_in_conditional_expressions
                  hasError: controller.hasError.value
                      ? true
                      // ignore: avoid_bool_literals_in_conditional_expressions
                      : !controller.isValid.value
                          // ignore: avoid_bool_literals_in_conditional_expressions
                          ? controller.email.value.isNotEmpty
                              ? true
                              : false
                          : false,
                  controller: controller.emailController,
                  onChanged: (String value) {
                    controller.isEmail();
                  },
                ),
              ),
              Obx(() {
                errorMessage = (!controller.matches.value
                    ? 'Please enter correct email'.tr
                    : '');
                return Column(
                  children: <Widget>[
                    const Gap(
                      5,
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            errorMessage,
                            style: CustomTypography.fromColor(
                              theme.graphite,
                            ).k14Reg,
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }),
              const Spacer(),
              Obx(
                () => DinasonaButton(
                  text: 'Send code'.tr,
                  onPressed: () => controller.onSubmit(),
                  locked: !controller.isValid.value,
                ),
              ),
              const Gap(30),
            ],
          ),
        ),
      ),
    );
  }
}
