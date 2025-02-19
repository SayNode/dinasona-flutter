import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../service/theme_service.dart';
import '../../../theme/theme.dart';
import '../../../theme/typography.dart';
import '../../../util/util.dart';

class CurrencyTileWidget extends StatelessWidget {
  const CurrencyTileWidget({
    required this.imageUrl,
    required this.sign,
    required this.name,
    super.key,
    this.onTap,
  });

  final void Function()? onTap;
  final String imageUrl;
  final String sign;
  final String name;

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Get.put(ThemeService()).theme;
    return Material(
      color: theme.snowfall,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 10,
          ),
          child: Row(
            children: <Widget>[
              Image.asset(
                imageUrl,
                width: 35,
                height: 24,
              ),
              const SizedBox(width: 15),
              Text(
                sign,
                style: CustomTypography.fromColor(
                  theme.shadowed,
                ).k16Reg,
              ),
              Gap(getRelativeWidth(5)),
              Text(
                name,
                style: CustomTypography.fromColor(
                  theme.graphite,
                ).k14Reg,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
