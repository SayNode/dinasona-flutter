import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../service/theme_service.dart';
import '../../../theme/theme.dart';
import '../../../theme/typography.dart';
import '../../../util/util.dart';
import '../../../widgets/custom_scaffold.dart';
import '../../../widgets/dinasona_button.dart';
import '../../../widgets/dinasona_textfield.dart';
import '../../../widgets/google_apple_sign_in/google_apple_sign_in.dart';
import '../../sign_up/donor_and_beneficiary/sign_up_page.dart';
import '../controller/login_controller.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({this.isBeneficiary = true, super.key});

  final bool isBeneficiary;

  @override
  Widget build(BuildContext context) {
    final CustomTheme dinasonaTheme = Get.put(ThemeService()).theme;
    final Size screenSize = MediaQuery.of(context).size;
    Get.put(LoginController());
    return CustomScaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(
                top: getRelativeWidth(50),
                bottom: getRelativeWidth(30),
              ),
              decoration: BoxDecoration(
                color: dinasonaTheme.silvershine,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(
                  vertical: getRelativeHeight(30),
                ),
                child: Image.asset(
                  'assets/images/logos/dinasona_logo.png',
                  width: getRelativeWidth(240),
                ),
              ),
            ),
            Container(
              padding:
                  EdgeInsets.symmetric(horizontal: screenSize.width * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: getRelativeHeight(30),
                  ),
                  Text(
                    'Hello again! 👋 '.tr,
                    style: CustomTypography.fromColor(dinasonaTheme.shadowed)
                        .k36Bold,
                  ),
                  Text(
                    !isBeneficiary
                        ? 'Log in to resume your journey of giving. Your continued support means the world to those in need.'
                            .tr
                        : 'Please log in to access your account and receive the assistance you need.'
                            .tr,
                    style: CustomTypography.fromColor(dinasonaTheme.shadowed)
                        .k16Reg,
                  ),
                  SizedBox(
                    height: getRelativeHeight(30),
                  ),
                  Form(
                    child: Column(
                      children: <Widget>[
                        DinasonaTextField(
                          hintText: 'Enter email'.tr,
                          hasVerticalMargin: true,
                          prefix: Icon(
                            Icons.email,
                            size: 25,
                            color: dinasonaTheme.graphite,
                          ),
                          controller: controller.email,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        Obx(
                          () => DinasonaTextField(
                            hintText: 'Enter password'.tr,
                            hasVerticalMargin: true,
                            prefix: Icon(
                              Icons.lock,
                              size: 25,
                              color: dinasonaTheme.graphite,
                            ),
                            suffixIcon: GestureDetector(
                              onTap: () => controller.setShowPassword(),
                              child: Obx(
                                () => Icon(
                                  controller.showPassword.value
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  size: 25,
                                  color: dinasonaTheme.graphite,
                                ),
                              ),
                            ),
                            obscureText: !controller.showPassword.value,
                            controller: controller.password,
                          ),
                        ),
                        Obx(
                          () => controller.error.value.isNotEmpty
                              ? Padding(
                                  padding: EdgeInsets.only(
                                    top: screenSize.height * 0.005,
                                  ),
                                  child: Text(
                                    controller.error.value,
                                    style: CustomTypography.fromColor(
                                      dinasonaTheme.inferno,
                                    ).k14Reg,
                                  ),
                                )
                              : const SizedBox(),
                        ),
                        Transform(
                          transform: Matrix4.translationValues(
                            0,
                            -7,
                            0,
                          ),
                          child: Container(
                            width: double.infinity,
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                minimumSize: Size.zero,
                                padding: EdgeInsets.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              onPressed: () => controller.forgotPassword(),
                              child: Text(
                                'Forgot password?'.tr,
                                style: CustomTypography.fromColor(
                                  dinasonaTheme.graphite,
                                ).k16Reg,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: getRelativeHeight(15)),
                        Obx(
                          () => DinasonaButton(
                            text: isBeneficiary ? 'Continue'.tr : 'Sign in'.tr,
                            loading: controller.loading.value,
                            onPressed: () =>
                                controller.loginSubmit(isBeneficiary),
                            color: dinasonaTheme.ferngreen,
                            locked: !controller.isSignInButtonActive.value,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: getRelativeHeight(40)),
                  Row(
                    children: <Widget>[
                      const Expanded(child: Divider()),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: getRelativeWidth(15),
                        ),
                        child: const Text('or'),
                      ),
                      const Expanded(child: Divider()),
                    ],
                  ),
                  SizedBox(height: getRelativeHeight(40)),
                  const GoogleAppleSignIn(),
                  Center(
                    child: Container(
                      margin:
                          EdgeInsets.symmetric(vertical: getRelativeHeight(30)),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: 'No account? '.tr,
                          style:
                              CustomTypography.fromColor(dinasonaTheme.shadowed)
                                  .k16Reg,
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Register now'.tr,
                              style: CustomTypography.fromColor(
                                dinasonaTheme.amberglow,
                              ).k16Reg,
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Get.to<void>(
                                    SignupPage.new,
                                  );
                                },
                            ),
                          ],
                        ),
                      ),
                    ),
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
