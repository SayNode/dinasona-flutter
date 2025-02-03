import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../model/need.dart';
import '../pages/beneficiary/beneficiary_page.dart';
import '../service/localization_controller.dart';
import '../service/theme_service.dart';
import '../theme/theme.dart';
import '../theme/typography.dart';
import '../util/network_image_handler.dart';
import '../util/popup_manager.dart';
import '../util/util.dart';
import 'controller/need_card_controller.dart';

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
    Get.delete<NeedCardController>(tag: 'controller_needCard_${need.id}');
    final NeedCardController controller = Get.put(
      NeedCardController(need: need),
      tag: 'controller_needCard_${need.id}',
    );
    final LocalizationController localizationController =
        Get.find<LocalizationController>();
    final CustomTheme theme = Get.put(ThemeService()).theme;

    return Container(
      margin: EdgeInsets.only(bottom: getRelativeHeight(10)),
      child: Material(
        color: theme.snowfall,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: need.status == NeedStatus.past
                ? theme.ferngreen
                : theme.snowfall,
            width: need.status == NeedStatus.past ? 2 : 1,
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
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(128),
                          child: Stack(
                            children: <Widget>[
                              if (need.beneficiary.photoUrl == null)
                                const Icon(Icons.person)
                              else
                                NetworkImageHandler(
                                  url: need.beneficiary.photoUrl!,
                                  height: getRelativeHeight(52),
                                  width: getRelativeHeight(52),
                                ),
                            ],
                          ),
                        ),
                      ),
                      Gap(getRelativeWidth(16)),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () => Get.to<void>(
                                () => BeneficiaryPage(
                                  beneficiary: need.beneficiary,
                                ),
                              ),
                              child: Text(
                                need.beneficiary.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: CustomTypography.fromColor(
                                  need.status == NeedStatus.past
                                      ? theme.graphite
                                      : theme.shadowed,
                                ).k16SemiBold,
                              ),
                            ),
                            Text(
                              need.beneficiary.country.isEmpty
                                  ? 'Other'.tr
                                  : need.beneficiary.country.length > 1
                                      ? need.beneficiary.country[0]
                                              .toUpperCase() +
                                          need.beneficiary.country.substring(1)
                                      : need.beneficiary.country,
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
                          child: Obx(() {
                            if (controller.isLoadingCurrency.value) {
                              return const CircularProgressIndicator();
                            }
                            return Text(
                              '${localizationController.selectedCurrency.value.sign} ${controller.needAmountInUserCurrency.value.toStringAsFixed(1)}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: CustomTypography.fromColor(
                                theme.shadowed,
                              ).kInter20Bold,
                            );
                          }),
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
