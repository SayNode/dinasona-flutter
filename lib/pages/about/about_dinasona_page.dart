import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../service/theme_service.dart';
import '../../theme/theme.dart';
import '../../theme/typography.dart';
import '../../widgets/custom_scaffold.dart';
import '../../util/util.dart';

class AboutDinasonaPage extends StatelessWidget {
  const AboutDinasonaPage({super.key});

  static const Map<String, List<String>> info = <String, List<String>>{
    'Give Directly with Dinasona': <String>[
      'Give directly to those in need',
      "No costly overheads – transactions cost: 1% fee, with a minimum of CHF 0.50 or 1'000 Satoshi",
      'Money gets directly to the person you choose to give to',
      'The person you give to can spend the money the same day in their local store',
      'You choose who to give to, even small amounts to cover basic necessities',
      'Dinasona allows charitable donors to select to donate to individual requests of people in need, in the socio economic category, region, profile type of their choice.',
      'The donation reaches the beneficiary the same day as they requested it for their immediate needs.',
      'Many potential donors hesitate in giving through traditional means as they would prefer a more immediate return of information on exactly who their money is going to.',
      'Dinasona trusts those in need to be most knowledgeable on their most urgent needs without having to have recourse to external actors or experts.',
      'Dinasona overcomes the language and illiteracy barriers by proposing a simple graphical explanation of how to ask for help in a dedicated smartphone application made available in poor communities. This eliminates the need for local interpreters who do not always add value to a donor – beneficiary relationship.',
    ],
    'How does the basic Dinasona system work?': <String>[
      'A person in need downloads the APP that shows pictures of items of basic necessity and how to request assistance to buy one or more of the basic commodities. The request is posted on the Dinasona application that is available to donors.',
      "Donors select potential beneficiary requests to send them funds. The donor pays online including 1% fee, with a minimum of CHF 0.50 or 1'000 Satoshi for the cost of transferring the money.",
      'The recipient receives a notification in the App on their mobile phone notifying them that funds have been credited to their account.',
      'The beneficiary can then go to a local convenience store or kiosk to collect their money or go to an affiliated grocery store and buy commodities with their digital credit.',
      'The donation should reach the beneficiary on the same day as long as the beneficiary goes to withdraw the funds or purchase the requested items.',
      'Kiosks sometimes charge recipients a processing fee which is commonly accepted by mobile banking users. Dedicated kiosks for the particular mobile banking system of a user can allow for withdrawals without any deduction of fees.',
      "The donor then receives confirmation that the beneficiary has received the donation, including a breakdown of the 1% fee, with a minimum of CHF 0.50 or 1'000 Satoshi of transactional fees to deliver the donation.",
    ],
  };

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Get.put(ThemeService()).theme;
    return CustomScaffold(
      appBarTitle: 'About Dinasona'.tr,
      body: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getRelativeWidth(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                for (final MapEntry<String, List<String>> e in info.entries)
                  Padding(
                    padding: EdgeInsets.only(bottom: getRelativeHeight(24)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          e.key,
                          style: CustomTypography.fromColor(
                            theme.shadowed,
                          ).k16SemiBold,
                        ),
                        Gap(getRelativeHeight(8)),
                        for (final String s in e.value)
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                '  •  ',
                                style:
                                    CustomTypography.fromColor(theme.shadowed)
                                        .k16Reg,
                              ),
                              Expanded(
                                child: Text(
                                  s,
                                  style:
                                      CustomTypography.fromColor(theme.shadowed)
                                          .k16Reg,
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
