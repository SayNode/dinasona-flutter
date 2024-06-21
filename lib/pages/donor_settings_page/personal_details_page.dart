import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../util/util.dart';
import '../../widgets/avatar_widget/avatar_widget.dart';
import '../../widgets/custom_scaffold.dart';
import '../../widgets/dinasona_button.dart';
import '../../widgets/dinasona_textfield.dart';
import 'controllers/donor_personal_details_controller.dart';

class DonorPersonalDetailsPage extends GetView<DonorPersonalDetailsController> {
  const DonorPersonalDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBarTitle: 'Personal details'.tr,
      padding: true,
      body: Column(
        children: <Widget>[
          AvatarWidget(imageUrl: controller.imageUrl),
          Gap(getRelativeHeight(42)),
          DinasonaTextField(
            hintText: 'First Name'.tr,
            controller: controller.firstNameController,
          ),
          const Gap(6),
          DinasonaTextField(
            hintText: 'Last Name'.tr,
            controller: controller.lastNameController,
          ),
          const Gap(6),
          DinasonaTextField(
            hintText: 'Location'.tr,
            controller: controller.loactionController,
          ),
          const Spacer(),
          DinasonaButton(text: 'Save'.tr, onPressed: controller.save),
          Gap(getRelativeHeight(80)),
        ],
      ),
    );
  }
}
