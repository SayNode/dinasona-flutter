import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../model/need.dart';
import '../service/localization_controller.dart';
import '../service/theme_service.dart';
import '../theme/theme.dart';
import '../theme/typography.dart';
import '../util/popup_manager.dart';
import '../util/util.dart';
import 'controller/alternate_need_card_controller.dart';

class AlternateNeedCard extends GetView<AlternateNeedCardController> {
  const AlternateNeedCard({
    required this.need,
    super.key,
  });

  final Need need;

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Get.put(ThemeService()).theme;
    final LocalizationController localizationController =
        Get.find<LocalizationController>();
    final AlternateNeedCardController controller = Get.put(
      AlternateNeedCardController(need: need),
      tag: 'controller_alternateNeedCard_${need.id}',
    );

    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: getRelativeHeight(100),
      ),
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
                  style: CustomTypography.fromColor(
                    theme.ferngreen,
                  ).k16SemiBold,
                ),
              ),
              Gap(getRelativeHeight(4)),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
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
