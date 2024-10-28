import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../service/theme_service.dart';
import '../../theme/theme.dart';
import '../../theme/typography.dart';
import '../../util/util.dart';
import '../../widgets/custom_scaffold.dart';
import '../../widgets/dinasona_button.dart';
import 'controllers/import_wallet_controller.dart';
import 'widgets/import_wallet_input.dart';

class ImportWalletPage extends GetView<ImportWalletController> {
  const ImportWalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ImportWalletController controller = Get.put(ImportWalletController());
    final CustomTheme theme = Get.put(ThemeService()).theme;

    return CustomScaffold(
      padding: true,
      appBarTitle: 'Import wallet'.tr,
      boldTitle: false,
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Column(
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
                    ImportWalletInput(
                      1 + index * 3,
                      controller.importSeedInputs[index * 3],
                    ),
                    ImportWalletInput(
                      2 + index * 3,
                      controller.importSeedInputs[1 + index * 3],
                    ),
                    ImportWalletInput(
                      3 + index * 3,
                      controller.importSeedInputs[2 + index * 3],
                    ),
                  ],
                );
              },
            ),
            Gap(getRelativeHeight(40)),
            Obx(
              () => Text(
                controller.seedImportErrorMessage.value,
                style: CustomTypography.fromColor(theme.inferno).k16Reg,
              ),
            ),
            Gap(
              getRelativeHeight(
                controller.seedImportErrorMessage.value.isNotEmpty ? 40 : 0,
              ),
            ),
            const Spacer(),
            Obx(
              () => DinasonaButton(
                text: 'Import'.tr,
                locked: controller.reactiveImportSeedInputs
                    .any((String str) => str.isEmpty),
                onPressed: () {
                  final StringBuffer importSeedBuffer = StringBuffer();
                  for (int i = 0; i < controller.importSeedInputs.length; i++) {
                    importSeedBuffer.write(
                      '${i == 0 ? '' : ' '}${controller.importSeedInputs[i].text}',
                    );
                  }

                  if (importSeedBuffer.toString().isNotEmpty) {
                    controller.importWallet(
                      importSeedBuffer.toString().replaceAll('  ', ' '),
                    );
                  }
                },
                color: theme.amberglow,
              ),
            ),
            Gap(getRelativeHeight(30)),
          ],
        ),
      ),
    );
  }
}
