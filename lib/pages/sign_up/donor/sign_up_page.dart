import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

import '../../../service/theme_service.dart';
import '../../../theme/theme.dart';
import '../../../theme/typography.dart';
import '../../../util/util.dart';
import '../../../widgets/custom_scaffold.dart';
import '../../../widgets/dinasona_button.dart';
import '../../../widgets/dinasona_textfield.dart';
import '../../../widgets/google_apple_sign_in.dart';
import '../controller/sign_up_controller.dart';

class SignupPage extends GetView<SignupController> {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    final CustomTheme dinasonaTheme = Get.put(ThemeService()).theme;
    final Size screenSize = MediaQuery.of(context).size;
    Get.put(SignupController());
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
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: getRelativeWidth(17.5),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          Get.back<void>();
                        },
                        borderRadius: BorderRadius.circular(50),
                        child: Ink(
                          width: getRelativeWidth(50),
                          height: getRelativeWidth(50),
                          child: const Icon(
                            Icons.arrow_back_sharp,
                            color: Colors.black,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: getRelativeHeight(30)),
                      child: Image.asset(
                        'assets/images/logos/dinasona_logo.png',
                      ),
                    ),
                  ),
                  SizedBox(
                    width: getRelativeWidth(85),
                  ),
                ],
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
                    'Create an account'.tr,
                    style: CustomTypography.fromColor(dinasonaTheme.shadowed)
                        .k36Bold,
                  ),
                  Text(
                    "Your account is the key to sharing kindness. Let's begin your impact journey!"
                        .tr,
                    style: CustomTypography.fromColor(dinasonaTheme.shadowed)
                        .k16Reg,
                  ),
                  SizedBox(
                    height: getRelativeHeight(30),
                  ),
                  Obx(
                    () => Form(
                      child: Column(
                        children: <Widget>[
                          Text('${controller.test}'),
                          DinasonaTextField(
                            hintText: 'Enter email'.tr,
                            hasVerticalMargin: true,
                            prefix: const Icon(Icons.email, size: 25),
                            controller: null,
                            keyboardType: TextInputType.name,
                            validator: null,
                          ),
                          DinasonaTextField(
                            hintText: 'Enter password'.tr,
                            hasVerticalMargin: true,
                            prefix: const Icon(Icons.lock, size: 25),
                            suffixIcon:
                                const Icon(Icons.visibility_off, size: 25),
                            obscureText: true,
                            controller: null,
                            keyboardType: TextInputType.name,
                            validator: null,
                          ),
                          SizedBox(height: getRelativeHeight(20)),
                          const DinasonaButton(
                            text: 'Create an account',
                            onPressed: null,
                          ),
                        ],
                      ),
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
                          text: 'Already have an account? '.tr,
                          style:
                              CustomTypography.fromColor(dinasonaTheme.shadowed)
                                  .k16Reg,
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Sign in'.tr,
                              style: CustomTypography.fromColor(
                                dinasonaTheme.amberglow,
                              ).k16Reg,
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  null;
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
