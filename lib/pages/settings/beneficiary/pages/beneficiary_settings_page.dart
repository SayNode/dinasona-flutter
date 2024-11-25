import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../about_page.dart';
import '../../change_password_page.dart';
import '../../contact_us_page.dart';
import '../../widget/footer_widget.dart';
import '../../widget/profile_widget.dart';
import '../../widget/settings_bar.dart';
import '../controllers/beneficiary_settings_page_controller.dart';
import '../widgets/help_recieved_widget.dart';
import 'beneficiary_personal_details_page.dart';

class BeneficiarySettingsPage
    extends GetView<BeneficiarySettingsPageController> {
  const BeneficiarySettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: RefreshIndicator(
        onRefresh: () => controller.refreshPage(),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: <Widget>[
              const Gap(20),
              Obx(
                () => ProfileWidget(
                  name: controller.user.name,
                  location: controller.user.beneficiary.location,
                ),
              ),
              const Gap(12),
              Obx(
                () => HelpedRecievedWidget(
                  peopleHelped:
                      controller.beneficiaryStatistics.totalPeopleDonated,
                  amountDonated: controller
                      .beneficiaryStatistics.totalAmountDonated
                      .toDouble(),
                  needsClosed:
                      controller.beneficiaryStatistics.totalNeedsClosed,
                ),
              ),
              const Gap(16),
              SettingsBar(
                icon: Symbols.person,
                title: 'Personal details'.tr,
                onTap: () => Get.to(BeneficiaryPersonalDetailsPage.new),
              ),
              const Gap(6),
              SettingsBar(
                icon: Symbols.password,
                title: 'Change password'.tr,
                onTap: () => Get.to(() => const ChangePasswordPage()),
              ),
              const Gap(6),
              SettingsBar(
                icon: Symbols.contact_support,
                title: 'Contact us'.tr,
                onTap: () => Get.to(() => const ContactUsPage()),
              ),
              const Gap(6),
              const Gap(6),
              SettingsBar(
                icon: Symbols.globe_asia,
                title: 'About Dinasona'.tr,
                onTap: () => Get.to(() => const AboutPage()),
              ),
              const Gap(6),
              SettingsBar(
                icon: Symbols.logout,
                title: 'Log out'.tr,
                onTap: controller.logout,
              ),
              const Gap(6),
              SettingsBar(
                icon: Symbols.delete,
                title: 'Delete account'.tr,
                onTap: controller.deleteAccount,
              ),
              const FooterWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
