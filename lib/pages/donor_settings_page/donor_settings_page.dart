import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:material_symbols_icons/symbols.dart';

import 'widgets/footer_widget.dart';
import 'widgets/people_helped_widget.dart';
import 'widgets/profile_widget.dart';
import 'widgets/settings_bar.dart';

class DonorSettingsPage extends StatelessWidget {
  const DonorSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const Gap(48),
            const ProfileWidget(
              imageUrl: '',
              name: 'Name Placeholder',
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
              onTap: () {
                //TODO: Implement personal details page
              },
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
              icon: Symbols.globe_asia,
              title: 'About Dinasona'.tr,
              onTap: () {
                //TODO: Implement personal about page
              },
            ),
            const Gap(6),
            SettingsBar(
              icon: Symbols.logout,
              title: 'Log out'.tr,
              onTap: () {
                //TODO: Implement personal logout
              },
            ),
            const Gap(6),
            SettingsBar(
              icon: Symbols.delete,
              title: 'Delete account'.tr,
              onTap: () {
                //TODO: Implement personal delete account
              },
            ),
            const FooterWidget(),
          ],
        ),
      ),
    );
  }
}
