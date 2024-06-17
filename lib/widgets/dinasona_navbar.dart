import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

import '../service/theme_service.dart';
import '../theme/theme.dart';
import '../theme/typography.dart';

class DinasonaNavbar extends StatelessWidget {
  const DinasonaNavbar({
    required this.changeTabIndex,
    required this.tabIndex,
    super.key,
  });

  final void Function(int index) changeTabIndex;
  final RxInt tabIndex;

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Get.put(ThemeService()).theme;
    return Obx(
      () {
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
              currentIndex: tabIndex.value,
              backgroundColor: theme.moonstone,
              unselectedItemColor: theme.graphite,
              selectedItemColor: theme.ferngreen,
              unselectedLabelStyle:
                  CustomTypography.fromColor(theme.graphite).k14Reg,
              selectedLabelStyle:
                  CustomTypography.fromColor(theme.ferngreen).k14Reg,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(
                    Symbols.home,
                    fill: (tabIndex.value == 0) ? 1 : 0,
                    size: 36,
                  ),
                  label: 'Home',
                  backgroundColor: const Color.fromRGBO(36, 54, 101, 1),
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Symbols.volunteer_activism,
                    fill: (tabIndex.value == 1) ? 1 : 0,
                    size: 36,
                  ),
                  label: 'Donate',
                  backgroundColor: const Color.fromRGBO(36, 54, 101, 1),
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Symbols.person,
                    fill: (tabIndex.value == 2) ? 1 : 0,
                    size: 36,
                  ),
                  label: 'Profile',
                  backgroundColor: const Color.fromRGBO(36, 54, 101, 1),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
