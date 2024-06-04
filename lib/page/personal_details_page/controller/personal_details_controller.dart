import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum Gender {
  male('Male', Icons.male),
  female('Female', Icons.female),
  other('Prefer not to say', Icons.sentiment_satisfied_alt);

  const Gender(this.text, this.icon);
  final String text;
  final IconData icon;
}

class PersonalDetailsController extends GetxController {
  Gender get selectedGender => _selectedGender.value;
  final Rx<Gender> _selectedGender = Gender.other.obs;
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final RxString dateOfBirthController = ''.obs;
  final TextEditingController locationController = TextEditingController();
  final TextEditingController descriptionTextController =
      TextEditingController();
  final int descriptionMaxLenth = 300;

  set selectedGender(Gender value) {
    _selectedGender.value = value;
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (selectedDate != null) {
      final DateTime dateOfBirth = selectedDate.toLocal();
      dateOfBirthController.value = dateOfBirth.toString().split(' ')[0];
    }
  }

  void submit() {
    log('Full Name: ${fullNameController.text}');
    log('Email: ${emailController.text}');
    log('Gender: ${_selectedGender.value.text}');
    log('Date of Birth: ${dateOfBirthController.value}');
    log('Location: ${locationController.text}');
    log('Description: ${descriptionTextController.text}');
  }

  @override
  void onClose() {
    fullNameController.dispose();
    emailController.dispose();
    locationController.dispose();
    descriptionTextController.dispose();
    super.onClose();
  }
}
