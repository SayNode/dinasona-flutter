import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../service/theme_service.dart';
import '../../../theme/theme.dart';
import '../../../theme/typography.dart';
import '../../../widgets/custom_scaffold.dart';
import '../controller/sign_up_controller.dart';
import 'sign_up_page.dart';

class ChooseCurrencyPage extends GetView<SignupController> {
  const ChooseCurrencyPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final CustomTheme dinasonaTheme = Get.put(ThemeService()).theme;
    Get.put(SignupController());
    final List<Map<String, String>> languages = <Map<String, String>>[
      <String, String>{
        'name': 'Swiss Frank',
        'code': 'CHF',
        'image': 'assets/images/switzerland.png',
      },
      <String, String>{
        'name': 'Australian Dollar',
        'code': 'AUD',
        'image': 'assets/images/australia.png',
      },
      <String, String>{
        'name': 'British Pound',
        'code': 'GBP',
        'image': 'assets/images/great_britain.png',
      },
      <String, String>{
        'name': 'Canadian Dollar',
        'code': 'CAD',
        'image': 'assets/images/canada.png',
      }
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
                  'Choose currency'.tr,
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
                              controller.chosenCurrency.value =
                                  languages[index]['code']!;

                              Get.to<void>(
                                () => const SignupPage(),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 10,
                              ),
                              child: Row(
                                children: <Widget>[
                                  CircleAvatar(
                                    radius: 24,
                                    backgroundImage:
                                        AssetImage(languages[index]['image']!),
                                  ),
                                  const SizedBox(width: 15),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        languages[index]['name']!,
                                        style: CustomTypography.fromColor(
                                          dinasonaTheme.shadowed,
                                        ).k16Reg,
                                      ),
                                      Text(
                                        languages[index]['code']!,
                                        style: CustomTypography.fromColor(
                                          dinasonaTheme.shadowed,
                                        ).k16Reg,
                                      ),
                                    ],
                                  ),
                                ],
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
