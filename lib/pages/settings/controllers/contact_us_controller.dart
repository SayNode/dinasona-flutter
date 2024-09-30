import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../service/contact_service.dart';

class ContactUsController extends GetxController {
  final TextEditingController formController = TextEditingController();
  RxBool isButtonActive = false.obs;

  @override
  void onInit() {
    super.onInit();
    formController.addListener(() {
      isButtonActive.value = formController.text.isNotEmpty.obs.value;
    });
  }

  void send() {
    //TODO: Implement send function
    Get.put(ContactService()).submitMessage(formController.text);
  }
}
