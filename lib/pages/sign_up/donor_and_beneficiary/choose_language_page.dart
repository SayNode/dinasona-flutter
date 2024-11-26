import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../service/localization_controller.dart';
import '../../../service/theme_service.dart';
import '../../../theme/theme.dart';
import '../../../theme/typography.dart';
import '../../../widgets/custom_scaffold.dart';
import '../controller/sign_up_controller.dart';
import 'choose_currency_page.dart';

class ChooseLanguagePage extends GetView<SignupController> {
  const ChooseLanguagePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final CustomTheme dinasonaTheme = Get.put(ThemeService()).theme;
    final LocalizationController localizationController = Get.find<LocalizationController>();

    return CustomScaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        physics: const ScrollPhysics(),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Choose language'.tr,
                  style: CustomTypography.fromColor(dinasonaTheme.shadowed).k36Bold,
                ),
                Material(
                  color: dinasonaTheme.moonstone,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: localizationController.supportedLanguageList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        width: double.infinity,
                        height: 50,
                        margin: const EdgeInsets.symmetric(vertical: 7),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Material(
                          color: dinasonaTheme.snowfall,
                          borderRadius: BorderRadius.circular(10),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(10),
                            onTap: () async {
                              await localizationController.changeLanguage(
                                localizationController.supportedLanguageList[index],
                              );
                              unawaited(
                                Get.to<void>(
                                  () => const ChooseCurrencyPage(),
                                ),
                              );
                            },
                            child: Center(
                              child: Text(
                                localizationController.supportedLanguageList[index].languageName,
                                style: CustomTypography.fromColor(
                                  dinasonaTheme.shadowed,
                                ).k16Reg,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
