import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

import '../pages/add/add_page.dart';
import '../pages/home/beneficary_home_page.dart';
import '../pages/profile/beneficiary_profile_page.dart';
import '../pages/wallet/wallet_page.dart';

enum BeneficaryItems {
  home,
  add,
  wallet,
  profile;

  String get name {
    switch (this) {
      case BeneficaryItems.home:
        return 'Home';
      case BeneficaryItems.add:
        return 'Add';
      case BeneficaryItems.wallet:
        return 'Wallet';
      case BeneficaryItems.profile:
        return 'Profile';
    }
  }

  IconData get icon {
    switch (this) {
      case BeneficaryItems.home:
        return Icons.home;
      case BeneficaryItems.add:
        return Icons.add;
      case BeneficaryItems.wallet:
        return Symbols.wallet;
      case BeneficaryItems.profile:
        return Icons.person;
    }
  }

  Widget get page {
    switch (this) {
      case BeneficaryItems.home:
        return const BeneficiaryHomePage();
      case BeneficaryItems.add:
        return const AddPage();
      case BeneficaryItems.wallet:
        return const WalletPage();
      case BeneficaryItems.profile:
        return const BeneficiaryProfilePage();
    }
  }
}

class BeneficiaryBottomNavigationBar extends StatelessWidget {
  const BeneficiaryBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Add',
        ),
        BottomNavigationBarItem(
          icon: Icon(Symbols.wallet),
          label: 'Wallet',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }
}
