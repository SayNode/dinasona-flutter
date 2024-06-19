import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../model/need.dart';
import '../../theme/color.dart';
import '../../theme/typography.dart';
import '../../util/util.dart';
import '../../widgets/need_card.dart';
import 'controllers/donor_profile_page_controller.dart';

class DonorProfilePage extends GetView<DonorProfilePageController> {
  const DonorProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(DonorProfilePageController());
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: getRelativeHeight(20)),
        child: Column(
          children: <Widget>[
            Gap(getRelativeHeight(20)),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Donation history'.tr,
                style: CustomTypography.fromColor(LightColor.shadowed).k24Bold,
              ),
            ),
            Gap(getRelativeHeight(16)),
            Column(
              children: <Widget>[
                for (final Need need in controller.needsFulfilled)
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: getRelativeHeight(16),
                    ),
                    child: NeedCard(need: need),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
