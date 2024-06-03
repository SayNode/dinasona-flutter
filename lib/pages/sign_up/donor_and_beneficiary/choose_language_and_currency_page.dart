import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import '../controller/sign_up_controller.dart';

class ChooseLanguageAndCurrencyPage extends GetView<SignupController> {
  const ChooseLanguageAndCurrencyPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Text('Choose Language and Currency Page');
  }
}
