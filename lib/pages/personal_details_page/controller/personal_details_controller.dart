import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../service/theme_service.dart';
import '../../../service/user_state_service.dart';
import '../../create_new_need/create_new_need.dart';

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
  final Rx<File?> selectedImage = Rx<File?>(null);
  UserStateService userState = Get.find<UserStateService>();
  set selectedGender(Gender value) {
    _selectedGender.value = value;
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: Get.find<ThemeService>().theme.amberglow,
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );
    if (selectedDate != null) {
      final DateTime dateOfBirth = selectedDate.toLocal();
      dateOfBirthController.value = dateOfBirth.toString().split(' ')[0];
    }
  }

  Future<void> pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path);
      await userState.updateAvatar(file: selectedImage.value!);
    }
  }

  void submit() {
    // TODO implement submit
    Get.to<void>(() => const CreateNewNeed());
    log('Image: ${selectedImage.value?.path}');
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
