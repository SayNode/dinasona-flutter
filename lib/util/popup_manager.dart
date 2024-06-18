import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/donation.dart';
import '../pages/home/widgets/select_donation_fields_popup.dart';
import '../widgets/custom_popup.dart';
import '../widgets/story_popup.dart';
import '../widgets/upward_popup.dart';

class PopupManager {
  static Future<void> openStoryPopup() async {
    await openCustomPopup<void>(
      const StoryPopup(),
    );
  }

  static Future<List<DonationField>?> openSelectDonationFieldsPopup(
      List<DonationField> initialSelectedDonationFields) async {
    return Get.dialog<List<DonationField>>(
      SelectDonationFieldsPopup(
        initialSelectedDonationFields: initialSelectedDonationFields,
      ),
    );
  }
}
