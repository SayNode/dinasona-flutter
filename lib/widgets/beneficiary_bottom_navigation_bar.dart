import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

import '../pages/create_new_need/create_new_need.dart';
import '../pages/create_new_need/wallet_instructions.dart';
import '../pages/home/beneficary_home_page.dart';
import '../pages/settings/beneficiary/pages/beneficiary_settings_page.dart';
import '../pages/wallet/wallet_page.dart';
import '../service/theme_service.dart';
import '../service/wallet_service.dart';
import '../theme/theme.dart';
import '../theme/typography.dart';

enum BeneficaryItem {
  home,
  add,
  wallet,
  profile;

  String get name {
    switch (this) {
      case BeneficaryItem.home:
        return 'Home';
      case BeneficaryItem.add:
        return 'Add';
      case BeneficaryItem.wallet:
        return 'Wallet';
      case BeneficaryItem.profile:
        return 'Profile';
    }
  }

  IconData get icon {
    switch (this) {
      case BeneficaryItem.home:
        return Symbols.home;
      case BeneficaryItem.add:
        return Symbols.add;
      case BeneficaryItem.wallet:
        return Symbols.account_balance_wallet;
      case BeneficaryItem.profile:
        return Symbols.person;
    }
  }

  Widget get page {
    switch (this) {
      case BeneficaryItem.home:
        return const BeneficiaryHomePage();
      case BeneficaryItem.add:
        // Check if wallet is initialized
        if (Get.find<WalletService>().isWalletConnected.value) {
          return const CreateNewNeed();
        } else {
          return const InstructionsPage(
            isDonation: false,
          );
        }
      case BeneficaryItem.wallet:
        return const WalletPage();
      case BeneficaryItem.profile:
        return const BeneficiarySettingsPage();
    }
  }
}

class BeneficiaryBottomNavigationBar extends StatelessWidget {
  const BeneficiaryBottomNavigationBar({
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
          BoxShadow(color: Color.fromRGBO(1, 0, 0, 0.25), blurRadius: 4),
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
            for (final BeneficaryItem item in BeneficaryItem.values)
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
