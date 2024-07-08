import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../service/user_state_service.dart';

class DonorPersonalDetailsController extends GetxController {
  RxBool loading = false.obs;

  final UserStateService userStateService = Get.find<UserStateService>();
  final TextEditingController fistNameController = TextEditingController();
  final TextEditingController secondNameController = TextEditingController();
  final TextEditingController loactionController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fistNameController.text = userStateService.user.value.name;
  }

  Future<void> save() async {
    //TODO: fix the backend call
    loading.value = true;
    await userStateService.updateUserInfo(<String, dynamic>{
      'name': fistNameController.text,
    });
    loading.value = false;
  }
}
