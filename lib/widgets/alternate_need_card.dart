import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../model/need.dart';
import '../service/theme_service.dart';
import '../theme/theme.dart';
import '../theme/typography.dart';
import '../util/popup_manager.dart';
import '../util/util.dart';

class AlternateNeedCard extends StatelessWidget {
  const AlternateNeedCard({
    required this.need,
    super.key,
  });

  final Need need;

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Get.put(ThemeService()).theme;
    return SizedBox(
      height: getRelativeHeight(200),
      child: Material(
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: theme.snowfall,
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
                    theme.ferngreen,
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
                    theme.graphite,
                  ).k14Reg,
                ),
              ),
              Gap(getRelativeHeight(8)),
              Divider(
                height: 1,
                thickness: 1,
                color: theme.graphite,
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
                          theme.shadowed,
                        ).kInter20Bold,
                      ),
                    ),
                    Gap(getRelativeWidth(16)),
                    VerticalDivider(
                      width: 1,
                      thickness: 1,
                      color: theme.graphite,
                    ),
                    Gap(getRelativeWidth(16)),
                    Expanded(
                      child: Material(
                        color: theme.ferngreen,
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
                                  theme.snowfall,
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
