import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../model/beneficiary.dart';
import '../../../service/theme_service.dart';
import '../../../service/user_state_service.dart';
import '../../root/controllers/beneficiary_root_controller.dart';

class PersonalDetailsController extends GetxController {
  Gender get selectedGender => _selectedGender.value;
  final Rx<Gender> _selectedGender = Gender.anonymous.obs;
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final RxString dateOfBirthController = ''.obs;
  final RxString country = ''.obs;
  final TextEditingController descriptionTextController =
      TextEditingController();
  final int descriptionMaxLenth = 300;
  final Rx<File?> selectedImage = Rx<File?>(null);
  UserStateService userState = Get.find<UserStateService>();
  set selectedGender(Gender value) {
    _selectedGender.value = value;
  }

  final DateFormat dateFormat = DateFormat('yyyy-MM-dd');

  BeneficiaryRootController beneficiaryRootController =
      Get.find<BeneficiaryRootController>();
  final UserStateService userStateService = Get.find<UserStateService>();

  @override
  void onInit() {
    super.onInit();
    fullNameController.text = userState.user.value.name;
    emailController.text = userState.user.value.email;
    _selectedGender.value = userState.user.value.beneficiary.gender;
    if (userState.user.value.beneficiary.dateOfBirth != null) {
      dateOfBirthController.value = dateFormat.format(
        userStateService.user.value.beneficiary.dateOfBirth!,
      );
    }
    if (userState.user.value.beneficiary.country.isNotEmpty) {
      country.value = userState.user.value.beneficiary.country;
    }
    if (userState.user.value.beneficiary.bio.isNotEmpty) {
      descriptionTextController.text = userState.user.value.beneficiary.bio;
    }
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

    final Map<String, dynamic> beneficiaryInfo = <String, dynamic>{};

    if (fullNameController.text.isNotEmpty) {
      beneficiaryInfo['name'] = fullNameController.text;
    }
    if (country.value.isNotEmpty) {
      beneficiaryInfo['country'] = country.value.toLowerCase();
    }
    if (dateOfBirthController.value.isNotEmpty) {
      beneficiaryInfo['date_of_birth'] = dateOfBirthController.value;
    }
    if (descriptionTextController.text.isNotEmpty) {
      beneficiaryInfo['description'] = descriptionTextController.text;
    }
    if (_selectedGender.value.title != Gender.anonymous.title) {
      beneficiaryInfo['gender'] =
          _selectedGender.value.title.toLowerCase() == 'male' ? 0 : 1;
    }

    if (beneficiaryInfo.isNotEmpty) {
      await userStateService.updateBeneficiaryInfo(beneficiaryInfo);
    }

    Get.back();
    beneficiaryRootController.changeTabIndex(1);
  }

  void skip() {
    Get.back();
    beneficiaryRootController.changeTabIndex(1);
  }

  @override
  void onClose() {
    fullNameController.dispose();
    emailController.dispose();
    country.value = '';
    descriptionTextController.dispose();
    super.onClose();
  }
}
