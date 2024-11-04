import 'package:auto_size_text/auto_size_text.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../service/theme_service.dart';
import '../../../theme/theme.dart';
import '../../../theme/typography.dart';
import '../../../util/util.dart';
import '../controllers/create_wallet_controller.dart';

class ConfirmWalletSeedphraseInput extends GetView<CreateWalletController> {
  const ConfirmWalletSeedphraseInput(
    this.index,
    this.confirmationIndex, {
    super.key,
  });

  final int index;
  final int confirmationIndex;

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Get.put(ThemeService()).theme;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          controller.seedConfirmationInputs[confirmationIndex].value = '';
          controller.seedPhraseTapIndex.value = confirmationIndex;
        },
        child: Container(
          margin: EdgeInsets.all(getRelativeWidth(5)),
          child: DottedBorder(
            borderType: BorderType.RRect,
            dashPattern: const <double>[5, 4],
            padding: EdgeInsets.symmetric(horizontal: getRelativeWidth(5)),
            radius: const Radius.circular(35),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: getRelativeWidth(10)),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(35),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: getRelativeHeight(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    AutoSizeText(
                      '$index. ',
                      minFontSize: 8,
                      maxLines: 1,
                      style: CustomTypography.fromColor(theme.shadowed)
                          .k16SemiBold,
                    ),
                    Expanded(
                      child: Obx(
                        () => AutoSizeText(
                          controller
                              .seedConfirmationInputs[confirmationIndex].value,
                          style: CustomTypography.fromColor(theme.shadowed)
                              .k16SemiBold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
