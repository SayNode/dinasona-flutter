import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../model/need.dart';
import '../../../service/localization_controller.dart';
import '../../../service/theme_service.dart';
import '../../../theme/theme.dart';
import '../../../theme/typography.dart';
import '../../../util/util.dart';
import '../../../widgets/dinasona_button.dart';
import '../../../widgets/upward_popup.dart';
import '../../beneficiary/beneficiary_page.dart';
import '../../edit_need/edit_need_page.dart';
import '../controllers/my_need_popup_controller.dart';
import 'need_field_chip.dart';

class MyNeedPopup extends GetView<MyNeedPopupController> {
  const MyNeedPopup({required this.need, super.key});

  final Need need;

  @override
  Widget build(BuildContext context) {
    //need.beneficiary.country = Get.find<UserStateService>().user.value.country;

    Get
      ..delete<MyNeedPopupController>()
      ..put(MyNeedPopupController(need: need));
    final LocalizationController localizationController =
        Get.find<LocalizationController>();
    final CustomTheme theme = Get.put(ThemeService()).theme;

    return UpwardPopup(
      title: '',
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
                        child: (need.beneficiary.photoUrl ?? '').isEmpty
                            ? const SizedBox()
                            : Image.network(
                                need.beneficiary.photoUrl!,
                                height: getRelativeHeight(52),
                                width: getRelativeHeight(52),
                                fit: BoxFit.cover,
                                errorBuilder: (
                                  BuildContext context,
                                  Object error,
                                  StackTrace? stackTrace,
                                ) =>
                                    const Icon(Icons.person),
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
                  need.status == NeedStatus.past
                      ? theme.graphite
                      : theme.ferngreen,
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
          if (need.images.isEmpty)
            const SizedBox()
          else
            SizedBox(
              height: getRelativeHeight(100),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  Gap(getRelativeWidth(20)),
                  for (final String url in need.images)
                    Padding(
                      padding: EdgeInsets.only(right: getRelativeWidth(10)),
                      child: AspectRatio(
                        aspectRatio: 1.25,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.network(
                            url,
                            fit: BoxFit.cover,
                            loadingBuilder: (
                              BuildContext context,
                              Widget child,
                              ImageChunkEvent? loadingProgress,
                            ) {
                              if (loadingProgress == null) {
                                return child;
                              }
                              return Center(
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    theme.ferngreen,
                                  ),
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              );
                            },
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
          if (need.status == NeedStatus.draft)
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getRelativeWidth(20),
              ),
              child: Column(
                children: <Widget>[
                  DinasonaButton(
                    text: 'Edit your need'.tr,
                    onPressed: () => Get.to<void>(
                      EditNeedPage(
                        need: need,
                      ),
                    ),
                  ),
                  Gap(getRelativeHeight(20)),
                  InkWell(
                    onTap: () => controller.deleteNeed(need.id),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        'Delete your need'.tr,
                        style: CustomTypography.fromColor(
                          theme.shadowed,
                        ).k16SemiBold,
                      ),
                    ),
                  ),
                ],
              ),
            )
          else if (need.status == NeedStatus.ongoing)
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Published ${controller.publishedDate()}',
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: CustomTypography.fromColor(
                    theme.graphite,
                  ).k14Reg,
                ),
              ),
            )
          else
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Donated ${controller.donatedDate()}',
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: CustomTypography.fromColor(
                    theme.graphite,
                  ).k14Reg,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
