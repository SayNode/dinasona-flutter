import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/currency_model.dart';
import '../../../service/localization_controller.dart';
import '../../../service/theme_service.dart';
import '../../../theme/theme.dart';
import '../../../theme/typography.dart';
import '../../../widgets/custom_scaffold.dart';
import '../../root/beneficiary_root_page.dart';
import '../controller/sign_up_controller.dart';

class ChooseCurrencyPage extends GetView<SignupController> {
  const ChooseCurrencyPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final CustomTheme dinasonaTheme = Get.put(ThemeService()).theme;
    Get.put(SignupController());
    final List<CurrencyModel> currencies =
        Get.find<LocalizationController>().supportedCurrencies;

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
                    itemCount: currencies.length,
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
                            onTap: () async {
                              await controller
                                  .saveUserCurrency(currencies[index].code);
                              unawaited(
                                Get.to<void>(
                                  () => const BeneficiaryRootPage(),
                                ),
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
                                        AssetImage(currencies[index].image),
                                  ),
                                  const SizedBox(width: 15),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        currencies[index].name,
                                        style: CustomTypography.fromColor(
                                          dinasonaTheme.shadowed,
                                        ).k16Reg,
                                      ),
                                      Text(
                                        currencies[index].sign,
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
