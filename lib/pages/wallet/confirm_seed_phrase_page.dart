import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../service/theme_service.dart';
import '../../theme/theme.dart';
import '../../theme/typography.dart';
import '../../util/util.dart';
import '../../widgets/custom_scaffold.dart';
import '../../widgets/dinasona_button.dart';
import 'controllers/create_wallet_controller.dart';
import 'widgets/confirm_wallet_seedphrase_input.dart';

class ConfirmSeedPhrasePage extends GetView<CreateWalletController> {
  const ConfirmSeedPhrasePage({super.key});

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Get.put(ThemeService()).theme;
    final Random randomNumber = Random();
    final List<String> seedPhrase = controller.seedPhrase.split(' ');
    final Set<int> uniqueSeedPhraseIndexes = <int>{};
    while (uniqueSeedPhraseIndexes.length < 3) {
      uniqueSeedPhraseIndexes.add(randomNumber.nextInt(seedPhrase.length));
    }
    final List<int> randomSeedPhraseIndexes = uniqueSeedPhraseIndexes.toList();

    final List<String> seedPhraseChecks = <String>[
      seedPhrase[randomSeedPhraseIndexes[0]],
      seedPhrase[randomSeedPhraseIndexes[1]],
      seedPhrase[randomSeedPhraseIndexes[2]],
    ];

    // ignore: cascade_invocations
    seedPhrase.shuffle();

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: CustomScaffold(
        padding: true,
        showBackButtonInAppBar: false,
        appBarTitle: 'Confirm seed phrase'.tr,
        boldTitle: false,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Select each word in the order it was presented to you'.tr,
              style: CustomTypography.fromColor(theme.shadowed).k16Reg,
            ),
            Gap(getRelativeHeight(40)),
            Row(
              children: <Widget>[
                ConfirmWalletSeedphraseInput(
                  randomSeedPhraseIndexes[0] + 1,
                  controller.seedConfirmationInput1,
                ),
                ConfirmWalletSeedphraseInput(
                  randomSeedPhraseIndexes[1] + 1,
                  controller.seedConfirmationInput2,
                ),
                ConfirmWalletSeedphraseInput(
                  randomSeedPhraseIndexes[2] + 1,
                  controller.seedConfirmationInput3,
                ),
              ],
            ),
            Gap(getRelativeHeight(40)),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: seedPhrase.length ~/ 3,
              itemBuilder: (BuildContext context, int index) {
                return Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.all(
                          getRelativeWidth(2.5),
                        ),
                        padding: EdgeInsets.all(getRelativeWidth(5)),
                        decoration: BoxDecoration(
                          color: theme.silvershine,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: AutoSizeText(
                          seedPhrase[index * 3],
                          minFontSize: 8,
                          maxLines: 1,
                          style: CustomTypography.fromColor(theme.shadowed)
                              .k16SemiBold,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.all(
                          getRelativeWidth(2.5),
                        ),
                        padding: EdgeInsets.all(getRelativeWidth(5)),
                        decoration: BoxDecoration(
                          color: theme.silvershine,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: AutoSizeText(
                          seedPhrase[1 + index * 3],
                          minFontSize: 8,
                          maxLines: 1,
                          style: CustomTypography.fromColor(theme.shadowed)
                              .k16SemiBold,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.all(
                          getRelativeWidth(2.5),
                        ),
                        padding: EdgeInsets.all(getRelativeWidth(5)),
                        decoration: BoxDecoration(
                          color: theme.silvershine,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: AutoSizeText(
                          seedPhrase[2 + index * 3],
                          minFontSize: 8,
                          maxLines: 1,
                          style: CustomTypography.fromColor(theme.shadowed)
                              .k16SemiBold,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
            Gap(getRelativeHeight(20)),
            const Spacer(),
            Obx(
              () => DinasonaButton(
                text: 'Confirm seed phrase'.tr,
                color: theme.amberglow,
                locked: controller.userHasEnteredSeedPhrase.value,
                onPressed: () {
                  controller.validateSeedPhrase(seedPhraseChecks);
                },
              ),
            ),
            Gap(getRelativeHeight(30)),
          ],
        ),
      ),
    );
  }
}
