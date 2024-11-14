import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

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

  final UserStateService userStateService = Get.find<UserStateService>();

  @override
  void onInit() {
    super.onInit();
    fullNameController.text = userState.user.value.name;
    emailController.text = userState.user.value.email;
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
      final String dateOfBirth = DateFormat('yyyy-MM-dd').format(selectedDate);
      dateOfBirthController.value = dateOfBirth;
    }
  }

  Future<void> pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path);
      await userState.updateUserAvatar(file: selectedImage.value!);

      if (!userState.user.value.isDonor) {
        await userState.updateBeneficiaryImage(file: selectedImage.value!);
      }
    }
  }

  Future<void> submit() async {
    await userStateService.updateUserInfo(
      <String, dynamic>{
        'name': fullNameController.text,
        // 'email': emailController.text,
      },
    );
    await userStateService.updateBeneficiaryInfo(
      <String, dynamic>{
        'name': fullNameController.text,
        'city': locationController.text,
        'email': userStateService.user.value.email,
        'date_of_birth': dateOfBirthController.value,
        'description': descriptionTextController.text,
        'gender': _selectedGender.value.text.toLowerCase() == 'male' ? 0 : 1,
      },
    );

    await Get.to<void>(() => const CreateNewNeed());
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
