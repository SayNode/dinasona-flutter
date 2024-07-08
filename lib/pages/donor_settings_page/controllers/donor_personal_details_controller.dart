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
    final List<String> nameParts = userStateService.user.value.name.split(' ');
    fistNameController.text = nameParts[0];
    secondNameController.text = nameParts.length > 1 ? nameParts[1] : '';
  }

  Future<void> save() async {
    //TODO: fix the backend call
    loading.value = true;

    await userStateService.updateUserInfo(<String, dynamic>{
      'name': '${fistNameController.text} ${secondNameController.text}',
    });
    loading.value = false;
  }
}
