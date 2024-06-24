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
          const AvatarWidget(),
          Gap(getRelativeHeight(42)),
          DinasonaTextField(
            hintText: 'Name'.tr,
            controller: controller.nameController,
          ),
          const Gap(6),
          DinasonaTextField(
            hintText: 'Location'.tr,
            controller: controller.loactionController,
          ),
          const Spacer(),
          Obx(
            () {
              return DinasonaButton(
                text: 'Save'.tr,
                onPressed: controller.save,
                loading: controller.loading.value,
              );
            },
          ),
          Gap(getRelativeHeight(80)),
        ],
      ),
    );
  }
}
