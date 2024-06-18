import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../theme/color.dart';
import '../../theme/typography.dart';
import 'controllers/donor_home_page_controller.dart';

class DonorHomePage extends GetView<DonorHomePageController> {
  const DonorHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Text(
            "Hey, let's make a difference!".tr,
            style: CustomTypography.fromColor(LightColor.graphite).k24Bold,
          ),
        ],
      ),
    );
  }
}
