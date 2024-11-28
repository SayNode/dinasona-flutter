import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../service/theme_service.dart';
import '../../theme/theme.dart';
import '../../theme/typography.dart';
import '../../util/util.dart';
import '../../widgets/custom_scaffold.dart';
import '../create_new_need/wallet_instructions.dart';
import 'controller/help_payment_page_controller.dart';

class HelpPaymentPage extends GetView<HelpPageController> {
  const HelpPaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Get.put(ThemeService()).theme;
    return CustomScaffold(
      padding: true,
      appBarTitle: ''.tr,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Gap(getRelativeHeight(10)),
            Text(
              'How to receive donations'.tr,
              style: CustomTypography.fromColor(theme.shadowed).k24Bold,
              textAlign: TextAlign.center,
            ),
            Gap(getRelativeHeight(25)),
            NumberedInstructionsWidget(
              number: 1,
              text:
                  'Once you have set up your wallet, you can receive donations from others.'
                      .tr,
            ),
            Gap(getRelativeHeight(10)),
            NumberedInstructionsWidget(
              number: 2,
              text:
                  'Next choose the amount you wish to receive in either USD or BTC'
                      .tr,
            ),
            Gap(getRelativeHeight(10)),
            NumberedInstructionsWidget(
              number: 3,
              text:
                  'Next click on the create button to generate a invoice number'
                      .tr,
            ),
            Gap(getRelativeHeight(10)),
            NumberedInstructionsWidget(
              number: 4,
              text:
                  'Share the invoice number with the person who will be sending you the donation by either clicking the share button or copy and paste the invoice number directly to the donor.'
                      .tr,
            ),
            Gap(getRelativeHeight(20)),
            Image.asset(
              'assets/images/receive_btc.png',
              width: getRelativeWidth(300),
            ),
            Gap(getRelativeHeight(20)),
            Image.asset(
              'assets/images/qr_code.png',
              width: getRelativeWidth(300),
            ),
            Gap(getRelativeHeight(20)),
            Text(
              'How to send donations'.tr,
              style: CustomTypography.fromColor(theme.shadowed).k24Bold,
              textAlign: TextAlign.center,
            ),
            Gap(getRelativeHeight(25)),
            NumberedInstructionsWidget(
              number: 1,
              text:
                  'Once you have set up your wallet, you can send donations to others.'
                      .tr,
            ),
            Gap(getRelativeHeight(10)),
            NumberedInstructionsWidget(
              number: 2,
              text:
                  'You can either copy and paste the invoice number into the text field or press the scan button to scan the qr code with your camera'
                      .tr,
            ),
            Gap(getRelativeHeight(10)),
            NumberedInstructionsWidget(
              number: 3,
              text:
                  'You do not need to adjust the amount as the invoice number provided has this information already. You simply have to just click send. Pay attention it is the correct invoice number.'
                      .tr,
            ),
            Gap(getRelativeHeight(20)),
            Image.asset(
              'assets/images/send_btc.png',
            ),
            Gap(getRelativeHeight(20)),
          ],
        ),
      ),
    );
  }
}
