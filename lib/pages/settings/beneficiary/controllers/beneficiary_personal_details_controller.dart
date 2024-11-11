import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../service/user_state_service.dart';

class BeneficiaryPersonalDetailsController extends GetxController {
  RxBool loading = false.obs;

  final UserStateService userStateService = Get.find<UserStateService>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController birthdayController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final RxString gender = ''.obs;

  @override
  void onInit() {
    super.onInit();
    nameController.text = userStateService.user.value.name;
    locationController.text = userStateService.user.value.beneficiary.location;
    if (userStateService.user.value.beneficiary.dateOfBirth != null) {
      final DateFormat dateFormat = DateFormat('yyyy-MM-dd');
      birthdayController.text = dateFormat
          .format(userStateService.user.value.beneficiary.dateOfBirth!);
    }
    descriptionController.text = userStateService.user.value.beneficiary.bio;
  }

  Future<void> save() async {
    //TODO: fix the backend call
    loading.value = true;
    await userStateService.updateUserInfo(
      <String, dynamic>{
        'name': nameController.text,
      },
    );

    await userStateService.updateBeneficiaryInfo(
      <String, dynamic>{
        'name': nameController.text,
        'city': locationController.text,
        'email': userStateService.user.value.email,
        'date_of_birth': birthdayController.text,
        'description': descriptionController.text,
        'gender': gender.toLowerCase() == 'male' ? 0 : 1,
      },
    );

    loading.value = false;
  }
}
