import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../model/need.dart';
import '../../theme/color.dart';
import '../../theme/typography.dart';
import '../../util/util.dart';
import '../../widgets/need_card.dart';
import 'controllers/donor_home_page_controller.dart';
import 'widgets/need_field_chip.dart';
import 'widgets/select_need_fields_popup.dart';

class DonorHomePage extends GetView<DonorHomePageController> {
  const DonorHomePage({super.key});

  Widget generateDonationsInField(NeedField field) {
    final List<Need> donationsInField = controller.recommendedDonations
        .where(
          (Need e) => e.fields.contains(field),
        )
        .toList();
    return donationsInField.isEmpty
        ? Container()
        : Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: getRelativeWidth(20),
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        field.title,
                        style: CustomTypography.fromColor(LightColor.shadowed)
                            .k20Bold,
                      ),
                      const Gap(6),
                      Image.asset(
                        field.asset,
                        height: getRelativeHeight(20),
                      ),
                      const Spacer(),
                      Material(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(8),
                          onTap: () => controller.seeAll(field),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(
                              getRelativeWidth(8),
                              getRelativeHeight(5),
                              getRelativeWidth(4),
                              getRelativeHeight(4),
                            ),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  'See all'.tr,
                                  style: CustomTypography.fromColor(
                                    LightColor.shadowed,
                                  ).k14Reg,
                                ),
                                const Gap(2),
                                const Icon(
                                  Icons.chevron_right,
                                  color: LightColor.shadowed,
                                  size: 16,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Gap(getRelativeHeight(6)),
              Align(
                alignment: Alignment.centerLeft,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: <Widget>[
                      Gap(getRelativeWidth(20)),
                      for (final Need donation in donationsInField)
                        Padding(
                          padding: EdgeInsets.only(right: getRelativeWidth(15)),
                          child: SizedBox(
                            width: getRelativeWidth(320),
                            child: NeedCard(need: donation),
                          ),
                        ),
                      Gap(getRelativeWidth(5)),
                    ],
                  ),
                ),
              ),
              Gap(getRelativeHeight(20)),
            ],
          );
  }

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
              child: Obx(
                () => Wrap(
                  spacing: getRelativeWidth(5),
                  runSpacing: getRelativeHeight(6),
                  children: <Widget>[
                    for (final NeedField field in controller.favoriteFields)
                      NeedFieldChip(field: field),
                    SizedBox(
                      height: getRelativeHeight(40),
                      child: Material(
                        color: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(128),
                          side: const BorderSide(
                            color: LightColor.shadowed,
                          ),
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(128),
                          onTap: () => controller.openExploreMore(
                            child: SelectNeedFieldsPopup(
                              initialSelectedNeedFields:
                                  controller.favoriteFields,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: getRelativeWidth(16),
                              vertical: getRelativeHeight(8),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'Explore more'.tr,
                                  style: CustomTypography.fromColor(
                                    LightColor.graphite,
                                  ).k14Reg,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Gap(getRelativeHeight(16)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: getRelativeWidth(20)),
            child: Row(
              children: <Widget>[
                Text(
                  'Recommended for you ❤️'.tr,
                  style:
                      CustomTypography.fromColor(LightColor.shadowed).k20Bold,
                ),
                const Spacer(),
                Material(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(8),
                    onTap: () => controller.seeAll(null),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                        getRelativeWidth(8),
                        getRelativeHeight(5),
                        getRelativeWidth(4),
                        getRelativeHeight(4),
                      ),
                      child: Row(
                        children: <Widget>[
                          Text(
                            'See all'.tr,
                            style: CustomTypography.fromColor(
                              LightColor.shadowed,
                            ).k14Reg,
                          ),
                          const Gap(2),
                          const Icon(
                            Icons.chevron_right,
                            color: LightColor.shadowed,
                            size: 16,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Gap(getRelativeHeight(6)),
          Align(
            alignment: Alignment.centerLeft,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: <Widget>[
                  Gap(getRelativeWidth(20)),
                  for (final Need donation in controller.recommendedDonations)
                    Padding(
                      padding: EdgeInsets.only(right: getRelativeWidth(15)),
                      child: SizedBox(
                        width: getRelativeWidth(320),
                        child: NeedCard(need: donation),
                      ),
                    ),
                  Gap(getRelativeWidth(5)),
                ],
              ),
            ),
          ),
          Gap(getRelativeHeight(20)),
          for (final NeedField field in controller.favoriteFields)
            generateDonationsInField(field),
        ],
      ),
    );
  }
}
