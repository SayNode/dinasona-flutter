import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../service/user_state_service.dart';

class BeneficiaryPersonalDetailsController extends GetxController {
  RxBool loading = false.obs;

  final UserStateService userStateService = Get.find<UserStateService>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController loactionController = TextEditingController();
  final TextEditingController birthdayController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    nameController.text = userStateService.user.value.name;
  }

  Future<void> save() async {
    //TODO: fix the backend call
    loading.value = true;
    await userStateService.updateUserInfo(<String, dynamic>{
      'name': nameController.text,
    });
    loading.value = false;
  }
}
