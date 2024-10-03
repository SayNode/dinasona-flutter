import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../service/theme_service.dart';
import '../../../theme/theme.dart';
import '../../../theme/typography.dart';

class BulletPointWidget extends StatelessWidget {
  const BulletPointWidget({
    required this.text,
    super.key,
    this.symbol = '•',
    this.isBold = false,
  });
  final String text;
  final String symbol;
  final bool isBold;

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Get.find<ThemeService>().theme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(width: 8),
        Text(
          symbol,
          style: CustomTypography.fromColor(theme.graphite).k16Reg,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: CustomTypography.fromColor(theme.graphite).k16Reg.copyWith(
                  fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                ),
          ),
        ),
      ],
    );
  }
}
