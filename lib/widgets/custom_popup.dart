import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../service/theme_service.dart';
import '../../theme/theme.dart';

Future<T?> openCustomPopup<T>(
  Widget body, {
  bool dismissible = true,
  Color? barrierColor,
  Color? backgroundColor,
}) async {
  final CustomTheme custonTheme = Get.find<ThemeService>().theme;
  final Color backgroundColor0 = backgroundColor ?? custonTheme.moonstone;

  return Get.dialog<T?>(
    barrierColor: barrierColor,
    barrierDismissible: dismissible,
    Center(
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(30),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: backgroundColor0,
              borderRadius: BorderRadius.circular(30),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: body,
            ),
          ),
        ),
      ),
    ),
  );
}
