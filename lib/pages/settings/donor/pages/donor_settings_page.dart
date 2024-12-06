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
import '../controllers/donor_settings_page_controller.dart';
import '../widgets/people_helped_widget.dart';
import 'personal_details_page.dart';

class DonorSettingsPage extends GetView<DonorSettingsPageController> {
  const DonorSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => controller.refreshPage(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Obx(
          () => SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: <Widget>[
                const Gap(20),
                ProfileWidget(
                  name: controller.user.name.isNotEmpty
                      ? controller.user.name.split(' ').map((String part) {
                          return part[0].toUpperCase() + part.substring(1);
                        }).join(' ')
                      : '',
                  location: controller.user.country.isNotEmpty
                      ? controller.user.country[0].toUpperCase() +
                          controller.user.country.substring(1)
                      : '',
                ),
                const Gap(12),
                PeopleHelpedWidget(
                  peopleHelped:
                      controller.donorStatistics.totalBeneficiariesDonatedTo,
                  countries: controller.donorStatistics.totalCountriesDonatedTo,
                ),
                const Gap(16),
                SettingsBar(
                  icon: Symbols.person,
                  title: 'Personal details'.tr,
                  onTap: () => Get.to(DonorPersonalDetailsPage.new),
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
      ),
    );
  }
}
