import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/need.dart';
import '../../../service/need_service.dart';
import '../../../util/popup_manager.dart';
import '../../see_all/see_all_page.dart';
import '../need_search_page.dart';

class DonorHomePageController extends GetxController {
  RxList<AreaOfInterest> defaultAreasOfInterest = <AreaOfInterest>[].obs;
  RxList<Need> needs = <Need>[].obs;
  final NeedService needService = Get.find<NeedService>();

  @override
  Future<void> onInit() async {
    // Default areas of interest - as per the Figma
    defaultAreasOfInterest.addAll(AreaOfInterest.values.take(1));

    // Get all needs for the areas of interest
    needs.value = await Get.find<NeedService>()
        .getPublishedNeedsMatchingAreasOfInterest(defaultAreasOfInterest);
    super.onInit();
  }

  Future<void> openExploreMore({Widget? child}) async {
    final List<AreaOfInterest>? fields =
        await PopupManager.openSelectAreasOfInterestPopup(
      defaultAreasOfInterest,
    );
    if (fields != null) {
      unawaited(
        Get.to<void>(
          () => NeedSearchPage(fields: fields),
        ),
      );
    }
  }

  Future<void> seeAll(AreaOfInterest field, List<Need> donationsInField) async {
    await Get.to<void>(
      () => SeeAllPage(
        field: field,
        donationsInField: donationsInField,
      ),
    );
  }
}
