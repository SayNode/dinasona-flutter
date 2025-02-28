import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../service/theme_service.dart';
import '../../theme/theme.dart';
import '../../theme/typography.dart';
import '../../widgets/custom_scaffold.dart';
import 'widget/bullet_point_widget.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Get.find<ThemeService>().theme;
    return CustomScaffold(
      appBarTitle: 'About Dinasona'.tr,
      padding: true,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Give Directly with Dinasona'.tr,
                style: CustomTypography.fromColor(theme.shadowed).k16SemiBold,
              ),
            ),
            const Gap(12),
            BulletPointWidget(
              text: 'Give directly to those in need'.tr,
            ),
            const Gap(4),
            BulletPointWidget(
              text:
                  "No costly overheads – transactions cost: only 1% fee, with a minimum of CHF 0.50 or 1'000 Satoshi"
                      .tr,
            ),
            const Gap(4),
            BulletPointWidget(
              text:
                  'Money gets directly to the person you choose to give to'.tr,
            ),
            const Gap(4),
            BulletPointWidget(
              text:
                  'The person you give to can spend the money the same day in their local store'
                      .tr,
            ),
            const Gap(4),
            BulletPointWidget(
              text:
                  'You choose who to give to, even small amounts to cover basic necessities'
                      .tr,
            ),
            const Gap(4),
            BulletPointWidget(
              text:
                  'Dinasona allows charitable donors to select to donate to individual requests of people in need, in the socio-economic category, region, profile type of their choice.'
                      .tr,
            ),
            const Gap(4),
            BulletPointWidget(
              text:
                  'The donation reaches the benficiary the same day as they requested it for their immediate needs.'
                      .tr,
            ),
            const Gap(4),
            BulletPointWidget(
              text:
                  'Many potential donors hesitate in giving through traditional means as they would prefer a more immediate return of information on exactly who their money is going to.'
                      .tr,
            ),
            const Gap(4),
            BulletPointWidget(
              text:
                  'Dinasona trusts those in need to be most knowledgeable on their most urgent needs without having to have recourse to external actors or experts.'
                      .tr,
            ),
            const Gap(4),
            BulletPointWidget(
              text:
                  'Dinasona overcomes the language and illiteracy barriers by proposing a simple graphical explanation of how to ask for help in a dedicated smartphone application made available in poor communities. This eliminates the need for local interpreters who do not always add value to a donor – beneficiary relationship.'
                      .tr,
            ),
            const Gap(24),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'How does the basic Dinasona system work?'.tr,
                style: CustomTypography.fromColor(theme.shadowed).k16SemiBold,
              ),
            ),
            const Gap(12),
            BulletPointWidget(
              text:
                  'A person in need downloads the APP that shows pictures of items of basic necessity and how to request assistance to buy one or more of the basic commodities. The request is posted on the Dinasona application that is available to donors.'
                      .tr,
            ),
            const Gap(4),
            BulletPointWidget(
              text:
                  "Donors select potential beneficiary requests to send them funds. The donor pays online including 1% fee, with a minimum of CHF 0.50 or 1'000 Satoshi for the cost of transferring the money."
                      .tr,
            ),
            const Gap(4),
            BulletPointWidget(
              text:
                  ' The recipient receives a notification in the App on their mobile phone notifying them that funds have been credited to their account.'
                      .tr,
            ),
            const Gap(4),
            BulletPointWidget(
              text:
                  ' The beneficiary can then go to a local convenience store or kiosk to collect their money or go to an affiliated grocery store and buy commodities with their digital credit.'
                      .tr,
            ),
            const Gap(4),
            BulletPointWidget(
              text:
                  ' The donation should reach the beneficiary on the same day as long as the beneficiary goes to withdraw the funds or purchase the requested items.'
                      .tr,
            ),
            const Gap(4),
            BulletPointWidget(
              text:
                  ' Kiosks sometimes charge recipients a processing fee which is commonly accepted by mobile banking users. Dedicated kiosks for the particular mobile banking system of a user can allow for withdrawals without any deduction of fees.'
                      .tr,
            ),
            const Gap(4),
            BulletPointWidget(
              text:
                  " The donor then receives confirmation that the beneficiary has received the donation, including a breakdown of the 1% fee, with a minimum of CHF 0.50 or 1'000 Satoshi of transactional fees to deliver the donation."
                      .tr,
            ),
            const Gap(12),
          ],
        ),
      ),
    );
  }
}
