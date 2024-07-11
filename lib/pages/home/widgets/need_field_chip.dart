import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../model/need.dart';
import '../../../service/theme_service.dart';
import '../../../theme/theme.dart';
import '../../../theme/typography.dart';
import '../../../util/util.dart';

class AreaOfInterestChip extends StatelessWidget {
  const AreaOfInterestChip({
    required this.field,
    this.selected = false,
    super.key,
    this.onTap,
  });

  final AreaOfInterest field;
  final void Function()? onTap;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Get.put(ThemeService()).theme;
    return SizedBox(
      height: getRelativeHeight(40),
      child: Material(
        color: selected ? theme.ferngreen : Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(128),
          side: BorderSide(
            color: selected ? theme.ferngreen : theme.shadowed,
          ),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(128),
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getRelativeWidth(16),
              vertical: getRelativeHeight(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Image.asset(
                  field.asset,
                  fit: BoxFit.fitHeight,
                ),
                Gap(getRelativeWidth(8)),
                Text(
                  field.title,
                  style: CustomTypography.fromColor(
                    selected ? theme.snowfall : theme.graphite,
                  ).k14Reg,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
