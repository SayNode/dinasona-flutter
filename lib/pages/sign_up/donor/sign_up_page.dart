import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

import '../../../service/theme_service.dart';
import '../../../theme/theme.dart';
import '../../../theme/typography.dart';
import '../../../util/util.dart';
import '../../../widget/custom_scaffold.dart';
import '../controller/sign_up_controller.dart';

class SignupPage extends GetView<SignupController> {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    final CustomTheme dinasonaTheme = Get.put(ThemeService()).theme;
    return CustomScaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(
              top: getRelativeWidth(40),
              bottom: getRelativeWidth(30),
            ),
            decoration: BoxDecoration(
              color: dinasonaTheme.amberglow,
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
                  width: getRelativeWidth(50),
                  height: getRelativeWidth(50),
                  margin:
                      EdgeInsets.symmetric(horizontal: getRelativeWidth(17.5)),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(54, 0, 0, 0),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: const Icon(
                    Icons.arrow_back_sharp,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                Expanded(
                  child: Image.asset(
                    'asset/images/dinasona_logo.png',
                  ),
                ),
                SizedBox(
                  width: getRelativeWidth(85),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: getRelativeWidth(20)),
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
                  style:
                      CustomTypography.fromColor(dinasonaTheme.shadowed).k16Reg,
                ),
                SizedBox(
                  height: getRelativeHeight(30),
                ),
                Row(
                  children: <Widget>[
                    const Expanded(child: Divider()),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: getRelativeWidth(10)),
                      child: const Text('OR'),
                    ),
                    const Expanded(child: Divider()),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
/* Image.asset(
              'asset/images/dinasona_logo.png',
            ), */
/* Text(
        'Sign Up Page',
        style: CustomTypography.fromColor(dinasonaTheme.amberglow).k24Bold,
      ), */