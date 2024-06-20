import 'package:flutter/material.dart';

import '../../../theme/color.dart';
import '../../../theme/typography.dart';
import '../../../util/util.dart';

class NeedTabChip extends StatelessWidget {
  const NeedTabChip({
    required this.text,
    this.selected = false,
    super.key,
    this.onTap,
  });

  final String text;
  final void Function()? onTap;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: getRelativeHeight(40),
      child: Material(
        color: selected ? LightColor.ferngreen : Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: selected ? LightColor.ferngreen : LightColor.shadowed,
          ),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getRelativeWidth(16),
              vertical: getRelativeHeight(8),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  text,
                  style: CustomTypography.fromColor(
                    selected ? LightColor.snowfall : LightColor.graphite,
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
