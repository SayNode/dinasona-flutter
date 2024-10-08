import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../pages/login/donor_and_beneficiary/login_page.dart';
import '../util/util.dart';
import 'custom_scaffold.dart';
import 'dinasona_button.dart';

class PasswordUpdatedPage extends StatelessWidget {
  const PasswordUpdatedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: getRelativeHeight(16),
          horizontal: getRelativeWidth(15),
        ),
        child: Center(
          child: Column(
            children: <Widget>[
              Gap(getRelativeHeight(150)),
              /* HeaderAndSubHeader(
                isCentered: true,
                header: 'Password successfully updated'.tr,
                subHeader:
                    "You're all set! Your account is now secured with a new password"
                        .tr,
              ), */
              const Spacer(),
              DinasonaButton(
                text: 'Log in'.tr,
                onPressed: () => Get.offAll<void>(const LoginPage()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
