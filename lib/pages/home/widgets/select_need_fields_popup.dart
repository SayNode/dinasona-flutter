import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../model/need.dart';
import '../../../theme/color.dart';
import '../../../util/util.dart';
import '../../../widgets/dinasona_button.dart';
import '../../../widgets/upward_popup.dart';
import '../controllers/select_need_fields_controller.dart';
import 'need_field_chip.dart';

class SelectAreasOfInterestPopup
    extends GetView<SelectAreasOfInterestController> {
  const SelectAreasOfInterestPopup({
    required this.initialSelectedAreasOfInterest,
    super.key,
  });

  final List<AreaOfInterest> initialSelectedAreasOfInterest;

  @override
  Widget build(BuildContext context) {
    Get.put(SelectAreasOfInterestController(initialSelectedAreasOfInterest));
    return UpwardPopup(
      title: 'Categories'.tr,
      onClose: Get.back,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getRelativeWidth(20),
        ),
        child: Column(
          children: <Widget>[
            Obx(
              () => SizedBox(
                width: double.infinity,
                child: Wrap(
                  spacing: getRelativeWidth(5),
                  runSpacing: getRelativeHeight(6),
                  children: <Widget>[
                    for (final AreaOfInterest field in AreaOfInterest.values)
                      AreaOfInterestChip(
                        field: field,
                        selected:
                            controller.selectedAreasOfInterest.contains(field),
                        onTap: () => controller.selectedAreasOfInterest
                                .contains(field)
                            ? controller.selectedAreasOfInterest.remove(field)
                            : controller.selectedAreasOfInterest.add(field),
                      ),
                  ],
                ),
              ),
            ),
            Gap(getRelativeHeight(32)),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Expanded(
                  child: DinasonaButton(
                    expand: false,
                    text: 'Reset'.tr,
                    customElevation: 0,
                    onPressed: Get.back,
                    padding: EdgeInsets.all(getRelativeHeight(10)),
                    color: LightColor.moonstone,
                    textColor: LightColor.graphite,
                    borderColor: LightColor.silvershine,
                    borderSize: 1,
                  ),
                ),
                const Gap(10),
                Expanded(
                  child: Obx(
                    () => DinasonaButton(
                      expand: false,
                      customElevation: 0,
                      padding: EdgeInsets.all(getRelativeHeight(10)),
                      text: 'See MOCK needs'.tr,
                      color: LightColor.amberglow,
                      onPressed: controller.close,
                      locked: controller.selectedAreasOfInterest.isEmpty,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
