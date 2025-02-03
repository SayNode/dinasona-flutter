import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../model/beneficiary.dart';
import '../../../../service/user_state_service.dart';

class BeneficiaryPersonalDetailsController extends GetxController {
  RxBool loading = false.obs;
  final DateFormat dateFormat = DateFormat('yyyy-MM-dd');
  final UserStateService userStateService = Get.find<UserStateService>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController birthdayController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final RxString gender = ''.obs;
  final RxString country = ''.obs;
  final RxBool isFormValid = false.obs;

  @override
  void onInit() {
    super.onInit();
    nameController.text = userStateService.user.value.name;
    country.value = userStateService.user.value.beneficiary.country;
    if (userStateService.user.value.beneficiary.dateOfBirth != null) {
      birthdayController.text = dateFormat
          .format(userStateService.user.value.beneficiary.dateOfBirth!);
    }
    descriptionController.text = userStateService.user.value.beneficiary.bio;

    gender.value = userStateService.user.value.beneficiary.gender == Gender.male
        ? 'Male'
        : userStateService.user.value.beneficiary.gender == Gender.female
            ? 'Female'
            : '';
    checkInputs();

    nameController.addListener(checkInputs);
    ever(country, (_) => checkInputs());
    birthdayController.addListener(checkInputs);
    descriptionController.addListener(checkInputs);
    ever(gender, (_) => checkInputs());
  }

  void checkInputs() {
    if (nameController.text.isNotEmpty &&
        country.value.isNotEmpty &&
        birthdayController.text.isNotEmpty &&
        descriptionController.text.isNotEmpty &&
        gender.value.isNotEmpty) {
      isFormValid.value = true;
    } else {
      isFormValid.value = false;
    }
  }

  Future<void> save() async {
    //TODO: fix the backend call
    loading.value = true;
    await userStateService.updateUserInfo(
      <String, dynamic>{
        'name': nameController.text,
        'country_string': country.value,
      },
    );

    await userStateService.updateBeneficiaryInfo(
      <String, dynamic>{
        'name': nameController.text,
        'country': country.value.toLowerCase(),
        'email': userStateService.user.value.email,
        'date_of_birth': birthdayController.text,
        'description': descriptionController.text,
        'gender': gender.toLowerCase() == 'male' ? 0 : 1,
      },
    );
    userStateService.user.refresh();
    loading.value = false;
    Get.back();
  }
}
