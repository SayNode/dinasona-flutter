import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../pages/sign_up/controller/sign_up_controller.dart';
import '../service/theme_service.dart';
import '../theme/color.dart';
import '../theme/theme.dart';
import '../theme/typography.dart';
import '../util/util.dart';

class GoogleAppleSignIn extends GetView<SignupController> {
  const GoogleAppleSignIn({
    super.key,
    this.googleLoading = false,
    this.appleLoading = false,
  });

  final bool googleLoading;
  final bool appleLoading;

  @override
  Widget build(BuildContext context) {
    final CustomTheme dinasonaTheme = Get.put(ThemeService()).theme;
    return Column(
      children: <Widget>[
        ElevatedButton(
          onPressed: () {
            controller.googleSignInPressed();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: LightColor.moonstone,
            padding: EdgeInsets.all(getRelativeWidth(15)),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(getRelativeHeight(20)),
              side: const BorderSide(color: LightColor.shadowed),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SvgPicture.asset('assets/images/logos/google_logo.svg'),
              SizedBox(width: getRelativeWidth(20)),
              Text(
                'Continue with Google'.tr,
                style:
                    CustomTypography.fromColor(dinasonaTheme.shadowed).k16Reg,
              ),
              if (googleLoading)
                Container(
                  margin: EdgeInsets.only(left: getRelativeWidth(20)),
                  width: 20,
                  height: 20,
                  child: const CircularProgressIndicator(
                    strokeWidth: 2,
                    color: LightColor.graphite,
                  ),
                ),
            ],
          ),
        ),
        SizedBox(height: getRelativeHeight(10)),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: LightColor.moonstone,
            padding: EdgeInsets.all(getRelativeWidth(15)),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(getRelativeHeight(20)),
              side: const BorderSide(color: LightColor.shadowed),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SvgPicture.asset('assets/images/logos/apple_logo.svg'),
              SizedBox(width: getRelativeWidth(20)),
              Text(
                'Continue with Apple'.tr,
                style:
                    CustomTypography.fromColor(dinasonaTheme.shadowed).k16Reg,
              ),
              if (appleLoading)
                Container(
                  margin: EdgeInsets.only(left: getRelativeWidth(20)),
                  width: 20,
                  height: 20,
                  child: const CircularProgressIndicator(
                    strokeWidth: 2,
                    color: LightColor.graphite,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
