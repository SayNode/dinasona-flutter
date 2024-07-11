import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../service/theme_service.dart';
import '../../../theme/theme.dart';
import '../../../util/util.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({
    required this.selected,
    super.key,
  });

  final bool selected;

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Get.put(ThemeService()).theme;
    return Material(
      color: Colors.transparent,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: selected ? theme.ferngreen : theme.silvershine,
          borderRadius: BorderRadius.circular(10),
        ),
        child: SizedBox(
          width: getRelativeHeight(65),
          height: getRelativeHeight(5),
        ),
      ),
    );
  }
}
