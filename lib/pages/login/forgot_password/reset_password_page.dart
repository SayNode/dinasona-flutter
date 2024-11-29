import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../service/theme_service.dart';
import '../../../service/user_state_service.dart';
import '../../../theme/theme.dart';
import '../../../theme/typography.dart';
import '../../../util/util.dart';
import '../../../widgets/custom_scaffold.dart';
import '../../../widgets/dinasona_button.dart';
import '../../sign_up/donor_and_beneficiary/sign_up_page.dart';
import '../forgot_password/controller/forgot_password_controller.dart';

class ResetPasswordPage extends GetView<ForgotPasswordController> {
  const ResetPasswordPage({
    super.key,
    this.email,
    this.onTap,
  });
  final String? email;
  final dynamic Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = ThemeService().theme;
    return CustomScaffold(
      showBackButtonInAppBar: false,
      allowScopePop: false,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: getRelativeHeight(16),
            horizontal: getRelativeWidth(15),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Gap(getRelativeHeight(200)),
                Obx(
                  () => AutoSizeText(
                    controller.emailIsSent.value
                        ? 'Email is sent'.tr
                        : controller.unknownEmailError.value.isEmpty
                            ? 'Email is being sent'.tr
                            : 'An error occured'.tr,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: CustomTypography.fromColor(
                      theme.shadowed,
                    ).k36Bold,
                  ),
                ),
                const Gap(15),
                Obx(
                  () => RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: CustomTypography.fromColor(
                        theme.shadowed,
                      ).k16Reg,
                      children: <InlineSpan>[
                        TextSpan(
                          text: controller.emailIsSent.value
                              ? 'You have just received an email with a code to reset your password to '
                                  .tr
                              : controller.unknownEmailError.value.isEmpty
                                  ? 'We are sending an email to '.tr
                                  : "Can't send email to ".tr,
                        ),
                        if (email != null)
                          TextSpan(
                            text: '$email ',
                            style: CustomTypography.fromColor(
                              theme.shadowed,
                            ).k16SemiBold,
                          ),
                      ],
                    ),
                  ),
                ),
                Gap(getRelativeHeight(10)),
                Obx(
                  () => controller.unknownEmailError.isNotEmpty
                      ? Text(
                          controller.unknownEmailError.value,
                          style: CustomTypography.fromColor(
                            theme.inferno,
                          ).k16Reg,
                          textAlign: TextAlign.center,
                        )
                      : Container(),
                ),
                const Gap(100),
                Obx(
                  () => !controller.emailIsSent.value &&
                          controller.unknownEmailError.isEmpty
                      ? SpinKitCircle(
                          color: theme.ferngreen,
                          size: getRelativeWidth(180),
                        )
                      : Container(),
                ),
                const Spacer(),
                Obx(
                  () => DinasonaButton(
                    text: 'Continue'.tr,
                    // ignore: inference_failure_on_function_invocation
                    onPressed: controller.unknownEmailError.isNotEmpty
                        ? () => Get.find<UserStateService>().user.value.isDonor
                            ? Get.to<void>(const SignupPage())
                            : Get.to<void>(
                                const SignupPage(),
                              )
                        : onTap,
                  ),
                ),
                Gap(getRelativeHeight(30)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
