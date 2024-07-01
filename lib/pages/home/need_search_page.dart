import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../model/need.dart';
import '../../util/util.dart';
import '../../widgets/custom_scaffold.dart';
import '../../widgets/need_card.dart';
import 'controllers/need_search_page_controller.dart';
import 'widgets/need_field_chip.dart';

class NeedSearchPage extends GetView<NeedSearchPageController> {
  const NeedSearchPage({required this.fields, super.key});

  final List<AreaOfInterest> fields;

  @override
  Widget build(BuildContext context) {
    Get.put(NeedSearchPageController(fields));
    return CustomScaffold(
      padding: true,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Gap(getRelativeHeight(20)),
            Align(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                width: double.infinity,
                child: Wrap(
                  spacing: getRelativeWidth(5),
                  runSpacing: getRelativeHeight(6),
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: <Widget>[
                    IconButton(
                      onPressed: Get.back,
                      icon: const Icon(Icons.arrow_back),
                    ),
                    for (final AreaOfInterest field in fields)
                      AreaOfInterestChip(field: field),
                  ],
                ),
              ),
            ),
            Gap(getRelativeHeight(16)),
            Obx(
              () => Column(
                children: <Widget>[
                  for (final Need need in controller.needs)
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: getRelativeHeight(16),
                      ),
                      child: NeedCard(need: need),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
