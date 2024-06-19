import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../model/donation.dart';
import '../../../theme/color.dart';
import '../../../theme/typography.dart';
import '../../../util/util.dart';

class DonationFieldChip extends StatelessWidget {
  const DonationFieldChip({
    required this.donationField,
    this.selected = false,
    super.key,
    this.onTap,
  });

  final DonationField donationField;
  final void Function()? onTap;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: getRelativeHeight(40),
      child: Material(
        color: selected ? LightColor.ferngreen : Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(128),
          side: BorderSide(
            color: selected ? LightColor.ferngreen : LightColor.shadowed,
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
                  donationField.asset,
                  fit: BoxFit.fitHeight,
                ),
                Gap(getRelativeWidth(8)),
                Text(
                  donationField.title,
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
