import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:material_symbols_icons/symbols.dart';

import 'about_page.dart';
import 'controllers/donor_settings_page_controller.dart';
import 'personal_details_page.dart';
import 'widgets/footer_widget.dart';
import 'widgets/people_helped_widget.dart';
import 'widgets/profile_widget.dart';
import 'widgets/settings_bar.dart';

class DonorSettingsPage extends GetView<DonorSettingsPageController> {
  const DonorSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const Gap(48),
              ProfileWidget(
                name: controller.user.name,
                location: 'Location Placeholder',
              ),
              const Gap(12),
              const PeopleHelpedWidget(
                peopleHelped: -1,
                amountDonated: -1,
                countries: -1,
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
                onTap: () {
                  //TODO: Implement personal details page
                },
              ),
              const Gap(6),
              SettingsBar(
                icon: Symbols.contact_support,
                title: 'Contact us'.tr,
                onTap: () {
                  //TODO: Implement personal details page
                },
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
    );
  }
}
