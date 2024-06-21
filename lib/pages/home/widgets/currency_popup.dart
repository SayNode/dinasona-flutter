import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../service/theme_service.dart';
import '../../../theme/theme.dart';
import '../../../theme/typography.dart';
import '../../../util/util.dart';
import '../../../widgets/upward_popup.dart';
import '../controllers/currency_controller.dart';

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
      child: Material(
        child: Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: controller.currency.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(vertical: 7),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Material(
                  color: theme.snowfall,
                  borderRadius: BorderRadius.circular(10),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: () {
                      controller.chosenCurrency.value =
                          controller.currency[index]['code']!;
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
                            backgroundImage: AssetImage(
                              controller.currency[index]['image']!,
                            ),
                          ),
                          const SizedBox(width: 15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                controller.currency[index]['name']!,
                                style: CustomTypography.fromColor(
                                  theme.shadowed,
                                ).k16Reg,
                              ),
                              Text(
                                controller.currency[index]['code']!,
                                style: CustomTypography.fromColor(
                                  theme.shadowed,
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
      ),
    );
  }
}
