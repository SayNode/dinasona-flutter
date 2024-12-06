import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../service/theme_service.dart';
import '../../../theme/theme.dart';
import '../../../theme/typography.dart';
import '../../../widgets/avatar_widget/avatar_widget.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({
    required this.name,
    required this.location,
    super.key,
  });
  final String name;
  final String location;

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Get.find<ThemeService>().theme;

    return Row(
      children: <Widget>[
        const AvatarWidget(),
        const Gap(28),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              name.isEmpty ? 'Unknown'.tr : name,
              style: CustomTypography.fromColor(theme.shadowed).k24Bold,
            ),
            Text(
              location.isEmpty ? 'Unknown'.tr : location,
              style: CustomTypography.fromColor(theme.graphite).k16Reg,
            ),
          ],
        ),
      ],
    );
  }
}
