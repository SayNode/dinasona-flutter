import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../../util/util.dart';
import '../../../../widgets/avatar_widget/avatar_widget.dart';
import '../../../../widgets/custom_scaffold.dart';
import '../controllers/beneficiary_personal_details_controller.dart';

class BeneficiaryPersonalDetailsPage
    extends GetView<BeneficiaryPersonalDetailsController> {
  const BeneficiaryPersonalDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBarTitle: 'Personal details'.tr,
      padding: true,
      body: Column(
        children: <Widget>[
          Gap(getRelativeHeight(42)),
          const AvatarWidget(),
          Gap(getRelativeHeight(42)),
        ],
      ),
    );
  }
}
