import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../model/donation.dart';
import '../../theme/color.dart';
import '../../theme/typography.dart';
import '../../util/util.dart';
import 'controllers/donor_home_page_controller.dart';
import 'widgets/donation_field_chip.dart';

class DonorHomePage extends GetView<DonorHomePageController> {
  const DonorHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Gap(getRelativeHeight(20)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: getRelativeWidth(20)),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Hey, let's make a difference!".tr,
                style: CustomTypography.fromColor(LightColor.shadowed).k24Bold,
              ),
            ),
          ),
          Gap(getRelativeHeight(16)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: getRelativeWidth(20)),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Wrap(
                spacing: getRelativeWidth(4),
                runSpacing: getRelativeHeight(4),
                children: <Widget>[
                  for (final DonationField donationField
                      in controller.selectedDonationFields)
                    DonationFieldChip(donationField: donationField),
                  Material(
                    color: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(128),
                      side: const BorderSide(
                        color: LightColor.shadowed,
                      ),
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(128),
                      onTap: () => controller.exploreMore,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: getRelativeWidth(16),
                          vertical: getRelativeHeight(8),
                        ),
                        child: Text(
                          'Explore more'.tr,
                          style: CustomTypography.fromColor(LightColor.graphite)
                              .k14Reg,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
