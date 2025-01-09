import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Password {
  Password();
  int strength = 1;
  RxString text = 'weak'.obs;
  Color color = Colors.red;
  void update(int strength) {
    if (this.strength != strength) {
      switch (strength) {
        case 1:
          text.value = 'weak';
          color = Colors.red;
          this.strength = strength;
        case 2:
          text.value = 'average';
          color = Colors.orange;
          this.strength = strength;
        case 3:
          text.value = 'strong';
          color = Colors.lightGreen;
          this.strength = strength;
        case 4:
          text.value = 'very strong';
          color = Colors.green;
          this.strength = strength;
        default:
          text.value = 'weak';
          color = Colors.red;
          this.strength = strength;
      }
    }
  }
}

int determinePasswordStrength(String password) {
  int strength = 0;

  strength += password.contains(RegExp('[A-Z]')) ? 1 : 0;
  strength += password.contains(RegExp('[a-z]')) ? 1 : 0;
  strength += password.contains(RegExp(r'[-!@#$%^&*(),.?":{}|<>_]')) ? 1 : 0;
  strength += password.length >= 8 ? 10 : 0;
  if (strength < 12) {
    return 1;
  }
  if (strength == 12) {
    return 2;
  }
  if (strength == 13) {
    return 3;
  }
  if (strength > 13) {
    return 4;
  } else {
    return 1;
  }
}
