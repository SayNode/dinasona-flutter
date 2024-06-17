import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../service/theme_service.dart';
import '../../../theme/theme.dart';
import '../../../theme/typography.dart';

class TabHeaderWidget extends StatelessWidget {
  const TabHeaderWidget({
    required this.text,
    required this.selected,
    super.key,
    this.onTap,
  });
  final String text;
  final bool selected;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final RxDouble width = 0.0.obs;
    final ThemeService service = Get.find<ThemeService>();
    final CustomTheme theme = service.theme;
    final Size screenSize = MediaQuery.of(context).size;
    return Material(
      color: selected ? theme.ferngreen.withOpacity(0.1) : Colors.transparent,
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(10),
      ),
      child: InkWell(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              height: screenSize.height * 0.01,
            ),
            Text(
              text,
              maxLines: 1,
              style: CustomTypography.fromColor(
                selected ? theme.ferngreen : theme.graphite,
              ).k14Reg,
            ),
            SizedBox(
              height: screenSize.height * 0.01,
            ),
            Obx(() {
              return SizedBox(
                width: width.value + screenSize.width * 0.21,
                child: Divider(
                  color: selected
                      ? theme.ferngreen
                      : theme.graphite.withOpacity(0.5),
                  thickness: 2,
                  height: 1,
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
