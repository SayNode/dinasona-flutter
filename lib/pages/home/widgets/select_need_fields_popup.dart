import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/need.dart';
import '../../../util/util.dart';
import '../../../widgets/upward_popup.dart';
import '../controllers/select_need_fields_controller.dart';
import 'need_field_chip.dart';

class SelectNeedFieldsPopup extends GetView<SelectNeedFieldsController> {
  const SelectNeedFieldsPopup({
    required this.initialSelectedNeedFields,
    super.key,
  });

  final List<NeedField> initialSelectedNeedFields;

  @override
  Widget build(BuildContext context) {
    Get.put(SelectNeedFieldsController(initialSelectedNeedFields));
    return UpwardPopup(
      title: 'Categories'.tr,
      onClose: controller.close,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getRelativeWidth(20),
        ),
        child: Obx(
          () => Wrap(
            spacing: getRelativeWidth(5),
            runSpacing: getRelativeHeight(6),
            children: <Widget>[
              for (final NeedField field in NeedField.values)
                NeedFieldChip(
                  field: field,
                  selected: controller.selectedNeedFields.contains(field),
                  onTap: () => controller.selectedNeedFields.contains(field)
                      ? controller.selectedNeedFields.remove(field)
                      : controller.selectedNeedFields.add(field),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
