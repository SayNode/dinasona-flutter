import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../model/need.dart';
import '../pages/beneficiary/beneficiary_page.dart';
import '../service/theme_service.dart';
import '../theme/theme.dart';
import '../theme/typography.dart';
import '../util/popup_manager.dart';
import '../util/util.dart';

class NeedCard extends StatelessWidget {
  const NeedCard({
    required this.need,
    super.key,
    this.onCardClicked,
  });

  final Need need;
  final void Function()? onCardClicked;

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Get.put(ThemeService()).theme;
    return Container(
      margin: EdgeInsets.only(bottom: getRelativeHeight(10)),
      child: Material(
        color: theme.snowfall,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: theme.snowfall,
          ),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onCardClicked ?? () => PopupManager.openNeedPopup(need),
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
                            child: Stack(
                              children: <Widget>[
                                Image.network(
                                  need.beneficiary.photoUrl,
                                  height: getRelativeHeight(52),
                                  width: getRelativeHeight(52),
                                  errorBuilder: (
                                    BuildContext context,
                                    Object error,
                                    StackTrace? stackTrace,
                                  ) =>
                                      Icon(
                                    Icons.person,
                                    size: getRelativeHeight(52),
                                    color: theme.graphite,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ],
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
                                need.status == NeedStatus.past
                                    ? theme.graphite
                                    : theme.shadowed,
                              ).k16SemiBold,
                            ),
                            Text(
                              need.beneficiary.location,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: CustomTypography.fromColor(
                                theme.graphite,
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
                        child: VerticalDivider(
                          width: 1,
                          thickness: 1,
                          color: theme.graphite,
                        ),
                      ),
                      Gap(getRelativeWidth(16)),
                      if (need.status == NeedStatus.draft)
                        DecoratedBox(
                          decoration: BoxDecoration(
                            color: theme.graphite,
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(16),
                              bottomLeft: Radius.circular(16),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                            ),
                            child: Center(
                              child: Text(
                                'Draft',
                                style: CustomTypography.fromColor(
                                  theme.shadowed,
                                ).k14Reg,
                              ),
                            ),
                          ),
                        )
                      else
                        Center(
                          child: Text(
                            '${need.amount}\$',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: CustomTypography.fromColor(
                              need.status == NeedStatus.past
                                  ? theme.graphite
                                  : theme.shadowed,
                            ).kInter20Bold,
                          ),
                        ),
                    ],
                  ),
                ),
                Gap(getRelativeHeight(8)),
                Divider(
                  height: 1,
                  thickness: 1,
                  color: theme.graphite,
                ),
                Gap(getRelativeHeight(14)),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    need.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: CustomTypography.fromColor(
                      need.status == NeedStatus.past
                          ? theme.graphite
                          : theme.ferngreen,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
