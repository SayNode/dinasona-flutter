import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../model/need.dart';
import '../pages/beneficiary/beneficiary_page.dart';
import '../theme/color.dart';
import '../theme/typography.dart';
import '../util/popup_manager.dart';
import '../util/util.dart';

class NeedCard extends StatelessWidget {
  const NeedCard({
    required this.need,
    super.key,
  });

  final Need need;

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
          onTap: () => PopupManager.openNeedPopup(need),
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
                        child: GestureDetector(
                          onTap: () => Get.to<void>(
                            () =>
                                BeneficiaryPage(beneficiary: need.beneficiary),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(128),
                            child: Image.network(
                              need.beneficiary.photoUrl,
                              height: getRelativeHeight(52),
                              width: getRelativeHeight(52),
                              fit: BoxFit.cover,
                            ),
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
                              need.beneficiary.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: CustomTypography.fromColor(
                                LightColor.shadowed,
                              ).k16SemiBold,
                            ),
                            Text(
                              need.beneficiary.location,
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
                          '${need.amount}\$',
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
                    need.title,
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
                    need.description,
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
