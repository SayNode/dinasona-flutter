import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../service/theme_service.dart';
import '../theme/color.dart';
import '../theme/theme.dart';
import '../theme/typography.dart';
import '../util/util.dart';

class GoogleAppleSignIn extends StatelessWidget {
  const GoogleAppleSignIn({super.key});

  @override
  Widget build(BuildContext context) {
    final CustomTheme dinasonaTheme = Get.put(ThemeService()).theme;
    return Column(
      children: <Widget>[
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
              SvgPicture.asset('assets/images/logos/google_logo.svg'),
              SizedBox(width: getRelativeWidth(20)),
              Text(
                'Continue with Google'.tr,
                style:
                    CustomTypography.fromColor(dinasonaTheme.shadowed).k16Reg,
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
            ],
          ),
        ),
      ],
    );
  }
}
