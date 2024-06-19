import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/donation.dart';
import '../../../util/util.dart';
import '../../../widgets/upward_popup.dart';
import '../controllers/select_donation_fields_controller.dart';
import 'donation_field_chip.dart';

class SelectDonationFieldsPopup
    extends GetView<SelectDonationFieldsController> {
  const SelectDonationFieldsPopup({
    required this.initialSelectedDonationFields,
    super.key,
  });

  final List<DonationField> initialSelectedDonationFields;

  @override
  Widget build(BuildContext context) {
    Get.put(SelectDonationFieldsController(initialSelectedDonationFields));
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
              for (final DonationField donationField in DonationField.values)
                DonationFieldChip(
                  donationField: donationField,
                  selected:
                      controller.selectedDonationFields.contains(donationField),
                  onTap: () => controller.selectedDonationFields
                          .contains(donationField)
                      ? controller.selectedDonationFields.remove(donationField)
                      : controller.selectedDonationFields.add(donationField),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
