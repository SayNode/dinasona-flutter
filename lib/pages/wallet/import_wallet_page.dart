import 'package:auto_size_text/auto_size_text.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../service/theme_service.dart';
import '../../theme/theme.dart';
import '../../theme/typography.dart';
import '../../util/util.dart';
import '../../widgets/custom_scaffold.dart';
import '../../widgets/dinasona_button.dart';
import 'controllers/wallet_page_controller.dart';

class ImportWalletPage extends GetView<WalletPageController> {
  const ImportWalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Get.put(ThemeService()).theme;

    Expanded inputWidget(int index, TextEditingController inputController) {
      return Expanded(
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  AutoSizeText(
                    '$index. ',
                    minFontSize: 8,
                    maxLines: 1,
                    style:
                        CustomTypography.fromColor(theme.shadowed).k16SemiBold,
                  ),
                  Expanded(
                    child: TextField(
                      controller: inputController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: '',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return CustomScaffold(
      padding: true,
      appBarTitle: 'Import wallet'.tr,
      boldTitle: false,
      body: Column(
        children: <Widget>[
          Text(
            'Enter your seed phrase or public key to restore your existing wallet and access your funds.'
                .tr,
            style: CustomTypography.fromColor(theme.shadowed).k16Reg,
          ),
          Gap(getRelativeHeight(20)),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 4,
            itemBuilder: (BuildContext context, int index) {
              return Row(
                children: <Widget>[
                  inputWidget(
                    1 + index * 3,
                    controller.importSeedInputs[index * 3],
                  ),
                  inputWidget(
                    2 + index * 3,
                    controller.importSeedInputs[1 + index * 3],
                  ),
                  inputWidget(
                    3 + index * 3,
                    controller.importSeedInputs[2 + index * 3],
                  ),
                ],
              );
            },
          ),
          Gap(getRelativeHeight(40)),
          const Spacer(),
          DinasonaButton(
            text: 'Import'.tr,
            onPressed: () {
              final StringBuffer importSeedBuffer = StringBuffer();
              for (int i = 0; i < controller.importSeedInputs.length; i++) {
                importSeedBuffer.write(
                  '${i == 0 ? '' : ' '}${controller.importSeedInputs[i].text}',
                );
              }

              controller.importWallet(importSeedBuffer.toString());
            },
            color: theme.amberglow,
          ),
          Gap(getRelativeHeight(30)),
        ],
      ),
    );
  }
}
