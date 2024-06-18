import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../model/donation.dart';
import '../../../theme/color.dart';
import '../../../theme/typography.dart';
import '../../../util/util.dart';

class DonationFieldChip extends StatelessWidget {
  const DonationFieldChip({
    required this.donationField,
    super.key,
    this.onTap,
  });

  final DonationField donationField;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(128),
        side: const BorderSide(
          color: LightColor.shadowed,
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
                'assets/images/donation_fields/${donationField.name}.png',
                width: getRelativeWidth(24),
                height: getRelativeWidth(24),
                fit: BoxFit.cover,
              ),
              Gap(getRelativeWidth(8)),
              Text(
                donationField.title,
                style: CustomTypography.fromColor(LightColor.graphite).k14Reg,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
