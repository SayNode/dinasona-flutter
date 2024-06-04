import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../page/personal_details_page/personal_details_page.dart';
import '../../service/theme_service.dart';
import '../../theme/theme.dart';
import '../../theme/typography.dart';
import '../../util/util.dart';

class StoryPopup extends StatelessWidget {
  const StoryPopup({super.key});

  @override
  Widget build(BuildContext context) {
    final CustomTheme diasonaTheme = Get.find<ThemeService>().theme;
    return AlertDialog(
      backgroundColor: diasonaTheme.moonstone,
      icon: SvgPicture.asset(
        'asset/images/volunteer.svg',
        width: getRelativeWidth(83),
        height: getRelativeHeight(83),
      ),
      title: Text(
        'Your story matters!',
        style: CustomTypography.fromColor(diasonaTheme.shadowed).k24Bold,
      ),
      content: Text(
        'People are more inclined to donate when they know about you. Please share your story to help others understand your needs and support you better.',
        style: CustomTypography.fromColor(diasonaTheme.graphite).k16Reg,
        textAlign: TextAlign.center,
      ),
      actions: <Widget>[
        Container(
          alignment: Alignment.center,
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: getRelativeHeight(20)),
          decoration: BoxDecoration(
            color: diasonaTheme.ferngreen,
            borderRadius: BorderRadius.circular(16),
          ),
          child: InkWell(
            onTap: () {
              Get.to<void>(() => const PersonalDetailsPage());
            },
            child: Text(
              'Share my story',
              style: CustomTypography.fromColor(diasonaTheme.moonstone)
                  .k16SemiBold,
            ),
          ),
        ),
      ],
    );
  }
}
