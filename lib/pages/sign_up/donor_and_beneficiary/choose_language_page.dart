import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
    Get.put(SignupController());
    final List<String> languages = <String>[
      'Deutsch',
      'English',
      'العربية',
      '中文',
      'Guniandi',
      'chiTonga',
    ];

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
                  style: CustomTypography.fromColor(dinasonaTheme.shadowed)
                      .k36Bold,
                ),
                Material(
                  color: dinasonaTheme.moonstone,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: languages.length,
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
                            onTap: () {
                              controller.chosenLanguage.value =
                                  languages[index];
                              Get.to<void>(() => const ChooseCurrencyPage());
                            },
                            child: Center(
                              child: Text(
                                languages[index],
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
