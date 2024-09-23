import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

import '../pages/donate/donate_page.dart';
import '../pages/home/donor_home_page.dart';
import '../pages/settings/donor/pages/donor_settings_page.dart';
import '../pages/wallet/wallet_page.dart';
import '../service/theme_service.dart';
import '../theme/theme.dart';
import '../theme/typography.dart';

enum DonorItem {
  home,
  donate,
  wallet,
  profile;

  String get name {
    switch (this) {
      case DonorItem.home:
        return 'Home';
      case DonorItem.donate:
        return 'Donate';
      case DonorItem.wallet:
        return 'Wallet';
      case DonorItem.profile:
        return 'Profile';
    }
  }

  IconData get icon {
    switch (this) {
      case DonorItem.home:
        return Symbols.home;
      case DonorItem.donate:
        return Symbols.volunteer_activism;
      case DonorItem.wallet:
        return Symbols.account_balance_wallet;
      case DonorItem.profile:
        return Symbols.person;
    }
  }

  Widget get page {
    switch (this) {
      case DonorItem.home:
        return const DonorHomePage();
      case DonorItem.donate:
        return const DonatePage();
      case DonorItem.wallet:
        return const WalletPage();
      case DonorItem.profile:
        return const DonorSettingsPage();
    }
  }
}

class DonorBottomNavigationBar extends StatelessWidget {
  const DonorBottomNavigationBar({
    required this.changeTabIndex,
    required this.tabIndex,
    super.key,
  });

  final void Function(int index) changeTabIndex;
  final int tabIndex;

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Get.put(ThemeService()).theme;
    return DecoratedBox(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.25), blurRadius: 4),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: BottomNavigationBar(
          showUnselectedLabels: true,
          showSelectedLabels: true,
          onTap: changeTabIndex,
          currentIndex: tabIndex,
          backgroundColor: theme.moonstone,
          unselectedItemColor: theme.graphite,
          selectedItemColor: theme.ferngreen,
          unselectedLabelStyle:
              CustomTypography.fromColor(theme.graphite).k14Reg,
          selectedLabelStyle:
              CustomTypography.fromColor(theme.ferngreen).k14Reg,
          items: <BottomNavigationBarItem>[
            for (final DonorItem item in DonorItem.values)
              BottomNavigationBarItem(
                icon: Icon(
                  item.icon,
                  fill: (tabIndex == item.index) ? 1 : 0,
                  size: 36,
                ),
                label: item.name,
                backgroundColor: theme.moonstone,
              ),
          ],
        ),
      ),
    );
  }
}
