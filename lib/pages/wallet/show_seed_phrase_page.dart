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
import 'confirm_seed_phrase_page.dart';
import 'controllers/create_wallet_controller.dart';

class ShowSeedPhrasePage extends GetView<CreateWalletController> {
  const ShowSeedPhrasePage({super.key});

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Get.put(ThemeService()).theme;
    final CreateWalletController controller = Get.put(CreateWalletController());
    final List<String> seedPhrase = controller.seedPhrase.split(' ');

    return CustomScaffold(
      padding: true,
      showBackButtonInAppBar: false,
      appBarTitle: 'Your seed phrase'.tr,
      boldTitle: false,
      body: Column(
        children: <Widget>[
          Text(
            'Write down this 12-word phrase and store it in a safe place. It’s the only way to recover your wallet. Never share it with anyone.'
                .tr,
            style: CustomTypography.fromColor(theme.shadowed).k16Reg,
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
                        '${1 + index * 3}. ${seedPhrase[index * 3]}',
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
                        '${2 + index * 3}. ${seedPhrase[1 + index * 3]}',
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
                        '${3 + index * 3}. ${seedPhrase[2 + index * 3]}',
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
          DinasonaButton(
            text: 'Yes, I wrote it down'.tr,
            color: theme.amberglow,
            onPressed: () {
              Get.to<void>(() => const ConfirmSeedPhrasePage());
            },
          ),
          Gap(getRelativeHeight(30)),
        ],
      ),
    );
  }
}
