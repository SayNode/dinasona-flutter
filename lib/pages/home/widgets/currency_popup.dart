import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../service/theme_service.dart';
import '../../../theme/theme.dart';
import '../../../theme/typography.dart';
import '../../../util/util.dart';
import '../../../widgets/dinasona_textfield.dart';
import '../../../widgets/upward_popup.dart';
import '../controllers/currency_controller.dart';
import 'currency_tile_widget.dart';

class CurrencyPopup extends GetView<CurrencyController> {
  const CurrencyPopup({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(CurrencyController());
    final CustomTheme theme = Get.put(ThemeService()).theme;
    return UpwardPopup(
      title: 'Choose currency'.tr,
      onClose: Get.back,
      height: getRelativeHeight(400),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Material(
          color: theme.moonstone,
          child: Column(
            children: <Widget>[
              DinasonaTextField(
                prefix: Icon(
                  Icons.search,
                  color: theme.graphite,
                  size: getRelativeHeight(24),
                ),
                hintText: 'Type a currency',
                controller: controller.searchController,
                backgroundColor: theme.silvershine,
                borderColor: theme.silvershine,
              ),
              Gap(getRelativeHeight(20)),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Your recent currencies'.tr,
                    style: CustomTypography.fromColor(
                      theme.shadowed,
                    ).k14Reg,
                  ),
                ),
              ),
              CurrencyTileWidget(
                imageUrl: controller.chosenCurrency.value.image,
                code: controller.chosenCurrency.value.code,
                name: controller.chosenCurrency.value.name,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'All currencies'.tr,
                    style: CustomTypography.fromColor(
                      theme.shadowed,
                    ).k14Reg,
                  ),
                ),
              ),
              SizedBox(
                height: getRelativeHeight(350),
                child: ListView.builder(
                  itemCount: controller.currency.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(vertical: 7),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: CurrencyTileWidget(
                        imageUrl: controller.currency[index].image,
                        code: controller.currency[index].code,
                        name: controller.currency[index].name,
                        onTap: () {
                          controller.chosenCurrency.value =
                              controller.currency[index];
                          Get.back();
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
