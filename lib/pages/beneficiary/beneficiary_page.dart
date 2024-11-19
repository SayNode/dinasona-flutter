import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

import '../../model/beneficiary.dart';
import '../../model/need.dart';
import '../../service/theme_service.dart';
import '../../theme/theme.dart';
import '../../theme/typography.dart';
import '../../util/network_image_handler.dart';
import '../../util/util.dart';
import '../../widgets/alternate_need_card.dart';
import '../../widgets/custom_scaffold.dart';
import 'controllers/beneficiary_page_controller.dart';
import 'widgets/need_tab_chip.dart';

class BeneficiaryPage extends GetView<BeneficiaryPageController> {
  const BeneficiaryPage({required this.beneficiary, super.key});

  final Beneficiary beneficiary;

  @override
  Widget build(BuildContext context) {
    Get.put(BeneficiaryPageController(beneficiary: beneficiary));
    final CustomTheme theme = Get.put(ThemeService()).theme;
    return CustomScaffold(
      padding: true,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Gap(getRelativeHeight(20)),
            SizedBox(
              width: double.infinity,
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: getRelativeHeight(20)),
                    child: Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(256),
                        child: beneficiary.photoUrl == null
                            ? const Icon(Icons.person)
                            : NetworkImageHandler(
                                url: beneficiary.photoUrl!,
                                height: getRelativeHeight(200),
                                width: getRelativeHeight(200),
                              ),
                      ),
                    ),
                  ),
                  Material(
                    color: theme.shadowed.withOpacity(0.2),
                    shape: const CircleBorder(),
                    child: InkWell(
                      customBorder: const CircleBorder(),
                      onTap: Get.back,
                      child: Padding(
                        padding: EdgeInsets.all(getRelativeHeight(16)),
                        child: Icon(
                          Icons.arrow_back,
                          size: 20,
                          color: theme.moonstone,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Gap(getRelativeHeight(10)),
            Text(
              beneficiary.name,
              style: CustomTypography.fromColor(theme.shadowed).k24Bold,
            ),
            Gap(getRelativeHeight(20)),
            Row(
              children: <Widget>[
                Icon(
                  Symbols.location_on,
                  color: theme.graphite,
                ),
                Gap(getRelativeWidth(6)),
                Text(
                  beneficiary.location,
                  style: CustomTypography.fromColor(theme.graphite).k16Reg,
                ),
              ],
            ),
            Gap(getRelativeHeight(10)),
            Row(
              children: <Widget>[
                Icon(
                  Symbols.email,
                  color: theme.graphite,
                ),
                Gap(getRelativeWidth(6)),
                Text(
                  beneficiary.email,
                  style: CustomTypography.fromColor(theme.graphite).k16Reg,
                ),
              ],
            ),
            Gap(getRelativeHeight(10)),
            Row(
              children: <Widget>[
                Icon(
                  Symbols.transgender,
                  color: theme.graphite,
                ),
                Gap(getRelativeWidth(6)),
                Text(
                  beneficiary.gender.title,
                  style: CustomTypography.fromColor(theme.graphite).k16Reg,
                ),
              ],
            ),
            Gap(getRelativeHeight(10)),
            Row(
              children: <Widget>[
                Icon(
                  Symbols.calendar_month,
                  color: theme.graphite,
                ),
                Gap(getRelativeWidth(6)),
                Text(
                  beneficiary.dateOfBirth == null
                      ? '-- -- ----'
                      : DateFormat('dd MMM yyyy').format(
                          beneficiary.dateOfBirth!,
                        ),
                  style: CustomTypography.fromColor(theme.graphite).k16Reg,
                ),
              ],
            ),
            Gap(getRelativeHeight(20)),
            Text(
              beneficiary.bio,
              style: CustomTypography.fromColor(theme.graphite).k16Reg,
            ),
            Gap(getRelativeHeight(40)),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "@name's Requests".trParams(
                  <String, String>{'name': beneficiary.name.split(' ')[0]},
                ),
                style: CustomTypography.fromColor(theme.shadowed).kPoppins18Reg,
              ),
            ),
            Gap(getRelativeHeight(10)),
            Align(
              alignment: Alignment.centerLeft,
              child: Obx(
                () => Wrap(
                  spacing: getRelativeWidth(5),
                  children: <Widget>[
                    for (final NeedTab tab in NeedTab.values)
                      NeedTabChip(
                        text: tab.title,
                        onTap: () => controller.selectedTab.value = tab,
                        selected: controller.selectedTab.value == tab,
                      ),
                  ],
                ),
              ),
            ),
            Gap(getRelativeHeight(20)),
            FutureBuilder<void>(
              future: controller.getNeedsForUser(),
              builder: (
                BuildContext context,
                AsyncSnapshot<void> needsForBeneficiary,
              ) {
                if (needsForBeneficiary.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (needsForBeneficiary.hasError) {
                  return Center(
                    child: Text(
                      'Failed to load needs - an error occurred: ${needsForBeneficiary.error}',
                    ),
                  );
                }

                return Obx(
                  () {
                    final List<Need> effectiveNeeds =
                        controller.needs.where((Need need) {
                      switch (controller.selectedTab.value) {
                        case NeedTab.all:
                          return true;
                        case NeedTab.ongoing:
                          return need.status == NeedStatus.ongoing;
                        case NeedTab.past:
                          return need.status == NeedStatus.past;
                      }
                    }).toList();
                    return Column(
                      children: <Widget>[
                        for (final Need need in effectiveNeeds)
                          Padding(
                            padding: EdgeInsets.only(
                              bottom: getRelativeHeight(16),
                            ),
                            child: AlternateNeedCard(need: need),
                          ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
