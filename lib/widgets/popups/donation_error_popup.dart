import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../service/theme_service.dart';
import '../../theme/theme.dart';
import '../../theme/typography.dart';
import '../../util/util.dart';

class DonationErrorPopup extends StatelessWidget {
  const DonationErrorPopup({
    required this.error,
    super.key,
  });

  final String error;

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Get.find<ThemeService>().theme;
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'An error occured while processing your donation',
              style: CustomTypography.fromColor(theme.inferno).k20Bold,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: getRelativeHeight(20)),
            Text(
              error,
              style: CustomTypography.fromColor(theme.shadowed).k16SemiBold,
            ),
          ],
        ),
      ),
    );
  }
}
