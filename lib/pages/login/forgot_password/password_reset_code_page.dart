import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import '../../../service/theme_service.dart';
import '../../../theme/theme.dart';
import '../../../theme/typography.dart';
import '../../../widgets/custom_scaffold.dart';
import 'controller/forgot_password_controller.dart';

class PasswordResetCodePage extends GetView<ForgotPasswordController> {
  const PasswordResetCodePage({super.key});

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = ThemeService().theme;

    final PinTheme defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 20,
        color: Color.fromRGBO(30, 60, 87, 1),
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: theme.shadowed),
        borderRadius: BorderRadius.circular(15),
      ),
    );

    final PinTheme focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: theme.amberglow),
      borderRadius: BorderRadius.circular(15),
    );

    return CustomScaffold(
      body: SafeArea(
        minimum: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            /* HeaderAndSubHeader(
              header: 'Password recovery code'.tr,
              subHeader:
                  'Please enter the code you received on your registered email address to reset your password.'
                      .tr,
            ), */
            const Text('ksdjfiskdjf'),
            const Gap(30),
            Center(
              child: Column(
                children: <Widget>[
                  Pinput(
                    defaultPinTheme: defaultPinTheme,
                    focusedPinTheme: focusedPinTheme,
                    keyboardType: TextInputType.text,
                    onCompleted: (String recoveryCode) =>
                        <void>{controller.validateCode(recoveryCode)},
                  ),
                  const Gap(10),
                  Obx(
                    () => controller.codeIsInValid.value
                        ? Text(
                            'Wrong code'.tr,
                            style: CustomTypography.fromColor(
                              theme.inferno,
                            ).k16SemiBold,
                          )
                        : Container(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
