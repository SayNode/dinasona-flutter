import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../service/theme_service.dart';
import '../../theme/theme.dart';
import '../../theme/typography.dart';
import '../../util/util.dart';
import 'controllers/google_apple_sign_in_controller.dart';

class GoogleAppleSignIn extends GetView<GoogleAppleSignInController> {
  const GoogleAppleSignIn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Get.put(ThemeService()).theme;
    return Column(
      children: <Widget>[
        ElevatedButton(
          onPressed: () => controller.googleSignInPressed(),
          style: ElevatedButton.styleFrom(
            backgroundColor: theme.moonstone,
            padding: EdgeInsets.all(getRelativeWidth(15)),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(getRelativeHeight(20)),
              side: BorderSide(color: theme.shadowed),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SvgPicture.asset('assets/images/logos/google_logo.svg'),
              SizedBox(width: getRelativeWidth(20)),
              Text(
                'Continue with Google'.tr,
                style: CustomTypography.fromColor(theme.shadowed).k16Reg,
              ),
              Obx(
                () => controller.loadingGoogle.value
                    ? Container(
                        margin: EdgeInsets.only(left: getRelativeWidth(20)),
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: theme.graphite,
                        ),
                      )
                    : Container(),
              ),
            ],
          ),
        ),
        SizedBox(height: getRelativeHeight(10)),
        if (GetPlatform.isIOS)
          ElevatedButton(
            onPressed: () => controller.appleSignInPressed(),
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.moonstone,
              padding: EdgeInsets.all(getRelativeWidth(15)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(getRelativeHeight(20)),
                side: BorderSide(color: theme.shadowed),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SvgPicture.asset('assets/images/logos/apple_logo.svg'),
                SizedBox(width: getRelativeWidth(20)),
                Text(
                  'Continue with Apple'.tr,
                  style: CustomTypography.fromColor(theme.shadowed).k16Reg,
                ),
                Obx(
                  () => controller.loadingApple.value
                      ? Container(
                          margin: EdgeInsets.only(left: getRelativeWidth(20)),
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: theme.graphite,
                          ),
                        )
                      : Container(),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
