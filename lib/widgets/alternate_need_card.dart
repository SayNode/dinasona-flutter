import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../model/need.dart';
import '../theme/color.dart';
import '../theme/typography.dart';
import '../util/popup_manager.dart';
import '../util/util.dart';
import 'dinasona_button.dart';

class AlternateNeedCard extends StatelessWidget {
  const AlternateNeedCard({
    required this.need,
    super.key,
  });

  final Need need;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: getRelativeHeight(200),
      child: Material(
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(
            color: LightColor.snowfall,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: getRelativeHeight(16),
            horizontal: getRelativeWidth(16),
          ),
          child: Column(
            children: <Widget>[
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
              Gap(getRelativeHeight(8)),
              const Divider(
                height: 1,
                thickness: 1,
                color: LightColor.graphite,
              ),
              Gap(getRelativeHeight(14)),
              IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
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
                    Gap(getRelativeWidth(16)),
                    const VerticalDivider(
                      width: 1,
                      thickness: 1,
                      color: LightColor.graphite,
                    ),
                    Gap(getRelativeWidth(16)),
                    Expanded(
                      child: Material(
                        color: LightColor.ferngreen,
                        borderRadius: BorderRadius.circular(18),
                        child: InkWell(
                          onTap: () {
                            PopupManager.openNeedPopup(need);
                          },
                          borderRadius: BorderRadius.circular(18),
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: getRelativeHeight(12),
                                horizontal: getRelativeWidth(12),
                              ),
                              child: Text(
                                'Donate now',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: CustomTypography.fromColor(
                                  LightColor.snowfall,
                                ).k16SemiBold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
