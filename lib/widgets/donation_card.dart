import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../model/donation.dart';
import '../theme/color.dart';
import '../theme/typography.dart';
import '../util/util.dart';

class DonationCard extends StatelessWidget {
  const DonationCard({
    required this.donation,
    super.key,
  });

  final Donation donation;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: getRelativeHeight(225),
      child: Material(
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(
            color: LightColor.snowfall,
          ),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {},
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: getRelativeHeight(16),
              horizontal: getRelativeWidth(16),
            ),
            child: Column(
              children: <Widget>[
                IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(128),
                          child: Image.network(
                            donation.beneficiaryPhotoUrl,
                            height: getRelativeHeight(52),
                            width: getRelativeHeight(52),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Gap(getRelativeWidth(16)),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              donation.beneficiaryName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: CustomTypography.fromColor(
                                LightColor.shadowed,
                              ).k16SemiBold,
                            ),
                            Text(
                              donation.beneficiaryLocation,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: CustomTypography.fromColor(
                                LightColor.graphite,
                              ).k14Reg,
                            ),
                          ],
                        ),
                      ),
                      Gap(getRelativeWidth(8)),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: getRelativeHeight(8),
                        ),
                        child: const VerticalDivider(
                          width: 1,
                          thickness: 1,
                          color: LightColor.graphite,
                        ),
                      ),
                      Gap(getRelativeWidth(16)),
                      Center(
                        child: Text(
                          '${donation.amount}\$',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: CustomTypography.fromColor(
                            LightColor.shadowed,
                          ).kInter20Bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Gap(getRelativeHeight(8)),
                const Divider(
                  height: 1,
                  thickness: 1,
                  color: LightColor.graphite,
                ),
                Gap(getRelativeHeight(14)),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    donation.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: CustomTypography.fromColor(
                      LightColor.ferngreen,
                    ).k16SemiBold,
                  ),
                ),
                Gap(getRelativeHeight(4)),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    donation.description,
                    style: CustomTypography.fromColor(
                      LightColor.graphite,
                    ).k14Reg,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
