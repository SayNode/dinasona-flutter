import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/need_card.dart';
import '../controllers/beneficary_home_page_controller.dart';

class AllNeedsWidget extends GetView<BeneficiaryHomePageController> {
  const AllNeedsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          if (controller.needs.isEmpty)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  "If you haven't created any needs yet, create one and it will appear here.",
                  textAlign: TextAlign.center,
                ),
              ),
            )
          else
            ListView.builder(
              shrinkWrap: true,
              itemCount: controller.needs.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return Obx(() => NeedCard(need: controller.needs[index]));
              },
            ),
        ],
      ),
    );
  }
}
