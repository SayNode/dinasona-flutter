import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../service/theme_service.dart';
import '../../../theme/theme.dart';
import '../../../theme/typography.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({
    required this.imageUrl,
    required this.name,
    required this.location,
    super.key,
  });
  final String imageUrl;
  final String name;
  final String location;

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Get.find<ThemeService>().theme;

    return Row(
      children: <Widget>[
        if (imageUrl.isNotEmpty)
          Image.network(
            imageUrl,
            height: 100,
            width: 100,
          )
        else
          Image.asset(
            'assets/images/profile_picture_placeholder.png',
            width: 100,
            height: 100,
          ),
        const Gap(28),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              name,
              style: CustomTypography.fromColor(theme.shadowed).k24Bold,
            ),
            Text(
              location,
              style: CustomTypography.fromColor(theme.graphite).k16Reg,
            ),
          ],
        ),
      ],
    );
  }
}
