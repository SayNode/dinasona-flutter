import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../pages/login/donor_and_beneficiary/login_page.dart';
import '../../service/api_service.dart';
import '../../service/auth_service.dart';
import '../../service/storage/secure_storage_service.dart';
import '../../service/storage/storage_service.dart';
import '../../service/theme_service.dart';
import '../../service/user_state_service.dart';
import '../../service/wallet_service.dart';
import '../../theme/theme.dart';
import '../../theme/typography.dart';
import '../../util/util.dart';
import '../dinasona_button.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Get.find<ThemeService>().theme;
    final UserStateService userStateService = Get.find<UserStateService>();
    final APIService apiService = Get.find<APIService>();
    final AuthService authService = Get.find<AuthService>();
    final SecureStorageService storageService =
        Get.find<StorageService>().secure;

    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Image.asset(
              'assets/images/logout.png',
              width: 90,
              height: 90,
            ),
            Gap(getRelativeHeight(20)),
            Text(
              'Log out'.tr,
              style: CustomTypography.fromColor(theme.shadowed).k24Bold,
            ),
            Text(
              textAlign: TextAlign.center,
              'Are you sure you want to log out? You will also be logged out of your wallet.'
                  .tr,
              style: CustomTypography.fromColor(theme.graphite).k16Reg,
            ),
            Gap(getRelativeHeight(10)),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                DinasonaButton(
                  expand: false,
                  color: theme.silvershine,
                  text: 'Log out'.tr,
                  textColor: theme.graphite,
                  onPressed: () async {
                    try {
                      await Get.find<AuthService>().logout();
                    } catch (e) {
                      if (!e
                          .toString()
                          .contains('u s e r _ n o t _ f o u n d')) {
                        throw Exception(e);
                      } else {
                        apiService.authenticationToken = '';
                        // Disconnect other providers
                        await authService.disconnectProviders();
                        await storageService.delete('token');
                      }
                    }

                    // Technically doesn't delete the wallet itself but the user's connection to it -> logout
                    await Get.find<WalletService>().deleteUserWallet();
                    Get.find<WalletService>().isWalletConnected.value = false;
                    userStateService.clear();
                    await Get.offAll<void>(
                      () => const LoginPage(),
                      transition: Transition.upToDown,
                    );
                  },
                  padding: EdgeInsets.all(getRelativeWidth(14)),
                ),
                Gap(getRelativeWidth(30)),
                DinasonaButton(
                  expand: false,
                  color: theme.amberglow,
                  text: 'Cancel'.tr,
                  onPressed: () => Get.back<void>(),
                  padding: EdgeInsets.all(getRelativeWidth(14)),
                ),
              ],
            ),
          ],
        ),
      ),
    );

    /* return AlertDialog(
      icon: Image.asset(
        'assets/images/logout.png',
        width: 90,
        height: 90,
      ),
      title: Text(
        'Log out'.tr,
        style: CustomTypography.fromColor(theme.shadowed).k24Bold,
      ),
      content: Text(
        'Are you sure you want to log out?'.tr,
        style: CustomTypography.fromColor(theme.graphite).k16Reg,
      ),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actions: <Widget>[
        DinasonaButton(
          expand: false,
          color: theme.silvershine,
          text: 'Log out'.tr,
          textColor: theme.graphite,
          onPressed: () async {
            await Get.find<AuthService>().logout();
            userStateService.clear();
            await Get.offAll<void>(
              () => const ChosePathPage(),
              transition: Transition.upToDown,
            );
          },
          padding: const EdgeInsets.all(16),
        ),
      ],
    ); */
  }
}
