import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../service/theme_service.dart';
import '../service/user_state_service.dart';
import '../theme/theme.dart';
import '../theme/typography.dart';
import '../util/util.dart';
import '../widgets/custom_scaffold.dart';
import '../widgets/dinasona_popup.dart';
import 'root/beneficiary_root_page.dart';
import 'root/donor_root_page.dart';

class ChosePathPage extends StatelessWidget {
  const ChosePathPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeService service = Get.find();
    final CustomTheme diasonaTheme = service.theme;
    return CustomScaffold(
      padding: true,
      body: Column(
        children: <Widget>[
          Gap(getRelativeHeight(20)),
          Expanded(
            child: Material(
              color: diasonaTheme.amberglow,
              borderRadius: BorderRadius.circular(24),
              child: InkWell(
                borderRadius: BorderRadius.circular(24),
                onTap: () async {
                  //setup donor
                  unawaited(
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const AlertDialog(
                          content: Row(
                            children: <Widget>[
                              CircularProgressIndicator(),
                              SizedBox(width: 20),
                              Text('Creating donor account...'),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                  await Get.find<UserStateService>()
                      .updateUserInfo(<String, dynamic>{
                    'is_donor': true,
                  });
                  Get.close(1);
                  showPopup();
                  unawaited(
                    Get.offAll(
                      () => const DonorRootPage(),
                    ),
                  );
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getRelativeWidth(20),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Gap(getRelativeHeight(20)),
                      Text(
                        'Donate now',
                        style:
                            CustomTypography.fromColor(diasonaTheme.moonstone)
                                .k36Bold,
                      ),
                      Text(
                        'Support those in need by contributing money to help improve their lives.',
                        style:
                            CustomTypography.fromColor(diasonaTheme.moonstone)
                                .k16SemiBold,
                        textAlign: TextAlign.center,
                      ),
                      Gap(getRelativeHeight(20)),
                      Expanded(
                        child: SizedBox.expand(
                          child: SvgPicture.asset(
                            'assets/images/give.svg',
                          ),
                        ),
                      ),
                      Gap(getRelativeHeight(20)),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Gap(getRelativeHeight(20)),
          Expanded(
            child: Material(
              color: diasonaTheme.ferngreen,
              borderRadius: BorderRadius.circular(24),
              child: InkWell(
                borderRadius: BorderRadius.circular(24),
                onTap: () async {
                  unawaited(
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const AlertDialog(
                          content: Row(
                            children: <Widget>[
                              CircularProgressIndicator(),
                              SizedBox(width: 20),
                              Text('Creating donor account...'),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                  await Get.find<UserStateService>()
                      .updateUserInfo(<String, dynamic>{
                    'is_donor': false,
                  });
                  await Get.find<UserStateService>()
                      .createBeneficiaryInstance();

                  Get.close(1);

                  showPopup(isBeneficiary: true);

                  unawaited(
                    Get.offAll(
                      () => const BeneficiaryRootPage(),
                    ),
                  );
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getRelativeWidth(20),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Gap(getRelativeHeight(20)),
                      Text(
                        'Get help',
                        style:
                            CustomTypography.fromColor(diasonaTheme.moonstone)
                                .k36Bold,
                      ),
                      Text(
                        'Receive financial assistance and support to overcome your challenges..',
                        style:
                            CustomTypography.fromColor(diasonaTheme.moonstone)
                                .k16SemiBold,
                        textAlign: TextAlign.center,
                      ),
                      Gap(getRelativeHeight(20)),
                      Expanded(
                        child: SizedBox.expand(
                          child: SvgPicture.asset(
                            'assets/images/receive.svg',
                          ),
                        ),
                      ),
                      Gap(getRelativeHeight(20)),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Gap(getRelativeHeight(20)),
        ],
      ),
    );
  }
}
