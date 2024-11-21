import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../pages/root/controllers/beneficiary_root_controller.dart';
import '../service/theme_service.dart';
import '../theme/theme.dart';
import '../theme/typography.dart';
import 'dinasona_button.dart';

void showPopup({bool isBeneficiary = false}) {
  final CustomTheme dinasonaTheme = Get.put(ThemeService()).theme;

  Future<void>.delayed(const Duration(milliseconds: 500), () {
    Get.defaultDialog<void>(
      backgroundColor: dinasonaTheme.moonstone,
      title: '',
      titlePadding: EdgeInsets.zero,
      contentPadding: const EdgeInsets.symmetric(horizontal: 15),
      content: Column(
        children: <Widget>[
          Container(
            transform: Matrix4.translationValues(0, -20, 0),
            child: SvgPicture.asset(
              'assets/images/popup_smiley.svg',
              width: 90,
            ),
          ),
          Text(
            'Account successfully created'.tr,
            style: CustomTypography.fromColor(dinasonaTheme.shadowed).k24Bold,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            !isBeneficiary
                ? "You're in! Begin your giving journey using Dinasona".tr
                : "You're in! Let's create positive change together".tr,
            style: CustomTypography.fromColor(dinasonaTheme.shadowed).k16Reg,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          DinasonaButton(
            text: !isBeneficiary ? 'Start donating'.tr : 'Share your story'.tr,
            onPressed: !isBeneficiary
                ? Get.back<void>
                : () {
                    Get.back<void>();
                    Get.find<BeneficiaryRootController>().changeTabIndex(1);
                  },
          ),
        ],
      ),
    );
  });
}
