import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../model/need.dart';
import '../../../service/localization_controller.dart';
import '../../../service/theme_service.dart';
import '../../../service/wallet_service.dart';
import '../../../theme/theme.dart';
import '../../../theme/typography.dart';
import '../../../util/network_image_handler.dart';
import '../../../util/util.dart';
import '../../../widgets/dinasona_button.dart';
import '../../../widgets/upward_popup.dart';
import '../../beneficiary/beneficiary_page.dart';
import '../../create_new_need/wallet_instructions.dart';
import '../controllers/need_popup_controller.dart';
import 'need_field_chip.dart';

class NeedPopup extends GetView<NeedPopupController> {
  const NeedPopup({required this.need, super.key});

  final Need need;

  @override
  Widget build(BuildContext context) {
    Get.put(NeedPopupController(need: need));
    final LocalizationController localizationController =
        Get.find<LocalizationController>();
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
                        child: need.beneficiary.photoUrl == null ||
                                need.beneficiary.photoUrl!.isEmpty
                            ? const SizedBox()
                            : NetworkImageHandler(
                                url: need.beneficiary.photoUrl!,
                                height: getRelativeHeight(52),
                                width: getRelativeHeight(52),
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
                    child: Obx(() {
                      if (controller.isLoadingCurrency.value) {
                        return const CircularProgressIndicator();
                      }
                      return Text(
                        '${localizationController.selectedCurrency['sign']} ${controller.needAmountInUserCurrency.value.toStringAsFixed(1)}',
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
                for (final String url in need.images)
                  Padding(
                    padding: EdgeInsets.only(right: getRelativeWidth(10)),
                    child: AspectRatio(
                      aspectRatio: 1.25,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: url.isEmpty
                            ? const SizedBox()
                            : NetworkImageHandler(
                                url: url,
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
              locked: controller.isLocked(),
              onPressed: () => controller.donate(need),
            ),
          ),
          if (Get.find<WalletService>().balanceInUserCurrency < need.amount)
            Padding(
              padding: const EdgeInsets.all(8),
              child: Center(
                child: Get.find<WalletService>().isWalletConnected.value
                    ? Text(
                        'Not enough balance in your wallet'.tr,
                        style: CustomTypography.fromColor(
                          theme.graphite,
                        ).k16Reg,
                      )
                    : TextButton(
                        onPressed: () {
                          Get.to(
                            const InstructionsPage(
                              isDonation: true,
                            ),
                          );
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                            horizontal: getRelativeWidth(8),
                          ),
                          visualDensity: VisualDensity.compact,
                          foregroundColor: theme.graphite,
                        ),
                        child: Text(
                          'Please connect a wallet to donate!'.tr,
                          style: CustomTypography.fromColor(
                            theme.graphite,
                          ).k16Reg.copyWith(
                                decoration: TextDecoration.underline,
                              ),
                        ),
                      ),
              ),
            ),
        ],
      ),
    );
  }
}
