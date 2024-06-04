import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../service/theme_service.dart';
import '../theme/theme.dart';
import '../theme/typography.dart';
import '../util/util.dart';
import '../widget/custom_scaffold.dart';
import '../widget/popups/story_popup.dart';

class ChosePathPage extends StatelessWidget {
  const ChosePathPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeService service = Get.find();
    final CustomTheme diasonaTheme = service.theme;
    return CustomScaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: getRelativeWidth(20),
            vertical: getRelativeHeight(20),
          ),
          child: Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  decoration: BoxDecoration(
                    color: diasonaTheme.amberglow,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      // TODO go to Donor page
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
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
                        SizedBox(height: getRelativeHeight(20)),
                        SizedBox(
                          width: getRelativeWidth(160),
                          child: SvgPicture.asset('asset/images/give.svg'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: getRelativeHeight(20)),
              Expanded(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  decoration: BoxDecoration(
                    color: diasonaTheme.ferngreen,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      // this line is temporary to show the popup
                      showDialog<Widget>(
                        context: context,
                        builder: (BuildContext context) {
                          return const StoryPopup();
                        },
                      );
                      // TODO go to Beneficiary page
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
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
                        SizedBox(height: getRelativeHeight(20)),
                        SizedBox(
                          width: getRelativeWidth(160),
                          child: SvgPicture.asset('asset/images/receive.svg'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
