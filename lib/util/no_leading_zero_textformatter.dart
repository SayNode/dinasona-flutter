import 'package:flutter/services.dart';

class NoLeadingZeroFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final String text = newValue.text;

    if (text.isEmpty) {
      return newValue;
    }

    if (text == '0' || text == '0.') {
      return newValue;
    }

    if (text.startsWith('0') && !text.startsWith('0.')) {
      return oldValue;
    }

    if (RegExp(r'^\d*\.?\d*$').hasMatch(text)) {
      return newValue;
    }

    return oldValue;
  }
}
