import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../service/contact_service.dart';
import '../../../util/popup_manager.dart';

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

  Future<void> send() async {
    Get.back<void>();
    unawaited(
      PopupManager.openContactUsPopup(
        await Get.put(ContactService()).submitMessage(formController.text),
      ),
    );
  }
}
