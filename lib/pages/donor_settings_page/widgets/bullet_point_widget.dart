import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../service/theme_service.dart';
import '../../../theme/theme.dart';
import '../../../theme/typography.dart';

class BulletPointWidget extends StatelessWidget {
  const BulletPointWidget({required this.text, super.key});
  final String text;

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Get.find<ThemeService>().theme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(width: 8),
        Text(
          '•',
          style: CustomTypography.fromColor(theme.graphite).k16Reg,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: CustomTypography.fromColor(theme.graphite).k16Reg,
          ),
        ),
      ],
    );
  }
}
