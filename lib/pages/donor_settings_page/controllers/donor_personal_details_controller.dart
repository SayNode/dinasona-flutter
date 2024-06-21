import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../service/user_state_service.dart';

class DonorPersonalDetailsController extends GetxController {
  RxBool loading = false.obs;

  final UserStateService userStateService = Get.find<UserStateService>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController loactionController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    firstNameController.text = userStateService.user.value.firstName;
    lastNameController.text = userStateService.user.value.lastName;
  }

  Future<void> save() async {
    //TODO: fix the backend call
    loading.value = true;
    await userStateService.updateUserInfo(<String, dynamic>{
      'first_name': firstNameController.text,
      'last_name': lastNameController.text,
    });
    loading.value = false;
  }
}
