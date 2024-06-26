import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../service/theme_service.dart';
import '../../theme/theme.dart';
import '../../theme/typography.dart';
import '../../util/util.dart';
import '../../widgets/custom_scaffold.dart';
import '../../widgets/dinasona_button.dart';

class RateAppScreen extends StatelessWidget {
  const RateAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Get.put(ThemeService()).theme;
    return CustomScaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Card(
            elevation: 5,
            color: theme.moonstone,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Image.asset('assets/images/stars.png'),
                  Gap(getRelativeHeight(10)),
                  Text(
                    'Your opinion matter to us'.tr,
                    style: CustomTypography.fromColor(theme.shadowed).k24Bold,
                  ),
                  Text(
                    'Share your experience to help us improve!'.tr,
                    style: CustomTypography.fromColor(theme.graphite).k16Reg,
                  ),
                  Gap(getRelativeHeight(20)),
                  DinasonaButton(
                    text: 'Rate us',
                    onPressed: () {
                      //todo: implement rate us
                    },
                  ),
                  Gap(getRelativeHeight(20)),
                  InkWell(
                    onTap: Get.back,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        'Remind me later'.tr,
                        style:
                            CustomTypography.fromColor(theme.graphite).k16Reg,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
