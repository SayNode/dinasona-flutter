import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../service/theme_service.dart';
import '../../theme/theme.dart';
import '../../theme/typography.dart';
import '../../util/util.dart';

class ContactUsPopup extends StatelessWidget {
  const ContactUsPopup(this.sendingMessageSuccess, {super.key});

  final bool sendingMessageSuccess;

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Get.find<ThemeService>().theme;
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              sendingMessageSuccess ? Icons.check : Icons.error,
              size: getRelativeHeight(60),
              color: sendingMessageSuccess ? theme.ferngreen : theme.inferno,
            ),
            Text(
              (sendingMessageSuccess
                      ? 'Message sent'.tr
                      : 'Could not send message'.tr)
                  .tr,
              textAlign: TextAlign.center,
              style: CustomTypography.fromColor(theme.shadowed).k24Bold,
            ),
            Gap(getRelativeHeight(10)),
            Text(
              (sendingMessageSuccess
                      ? 'Thank you for taking the time to share your story with us. We will get back to you soon.'
                      : 'Please try again later.')
                  .tr,
              textAlign: TextAlign.center,
              style: CustomTypography.fromColor(theme.graphite).k16Reg,
            ),
          ],
        ),
      ),
    );
  }
}
