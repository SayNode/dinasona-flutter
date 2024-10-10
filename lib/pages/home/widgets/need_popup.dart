import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../model/need.dart';
import '../../../service/theme_service.dart';
import '../../../theme/theme.dart';
import '../../../theme/typography.dart';
import '../../../util/util.dart';
import '../../../widgets/dinasona_button.dart';
import '../../../widgets/upward_popup.dart';
import '../../beneficiary/beneficiary_page.dart';
import '../controllers/need_popup_controller.dart';
import 'need_field_chip.dart';

class NeedPopup extends GetView<NeedPopupController> {
  const NeedPopup({required this.need, super.key});

  final Need need;

  @override
  Widget build(BuildContext context) {
    Get.put(NeedPopupController(need: need));
    final CustomTheme theme = Get.put(ThemeService()).theme;
    return UpwardPopup(
      title: 'Donate'.tr,
      onClose: Get.back,
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getRelativeWidth(20),
            ),
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        Get
                          ..back()
                          ..to<void>(
                            () =>
                                BeneficiaryPage(beneficiary: need.beneficiary),
                          );
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(128),
                        child: need.beneficiary.photoUrl == null
                            ? const Icon(Icons.person)
                            : Image.network(
                                need.beneficiary.photoUrl!,
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
                            theme.shadowed,
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
                ],
              ),
            ),
          ),
          Gap(getRelativeHeight(8)),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getRelativeWidth(20),
            ),
            child: Divider(
              height: 1,
              thickness: 1,
              color: theme.graphite,
            ),
          ),
          Gap(getRelativeHeight(24)),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getRelativeWidth(20),
            ),
            child: Align(
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
          ),
          Gap(getRelativeHeight(14)),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getRelativeWidth(20),
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Wrap(
                spacing: getRelativeWidth(5),
                runSpacing: getRelativeHeight(6),
                children: <Widget>[
                  for (final AreaOfInterest field in need.areasOfInterest)
                    AreaOfInterestChip(field: field),
                ],
              ),
            ),
          ),
          Gap(getRelativeHeight(14)),
          SizedBox(
            height: getRelativeHeight(100),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                Gap(getRelativeWidth(20)),
                for (final String url in need.photoUrls)
                  Padding(
                    padding: EdgeInsets.only(right: getRelativeWidth(10)),
                    child: AspectRatio(
                      aspectRatio: 1.25,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(
                          url,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                Gap(getRelativeWidth(10)),
              ],
            ),
          ),
          Gap(getRelativeHeight(14)),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getRelativeWidth(20),
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                need.description,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: CustomTypography.fromColor(
                  theme.graphite,
                ).k16Reg,
              ),
            ),
          ),
          Gap(getRelativeHeight(20)),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getRelativeWidth(20),
            ),
            child: DinasonaButton(
              text: 'Donate now'.tr,
              onPressed: controller.donate,
            ),
          ),
        ],
      ),
    );
  }
}
