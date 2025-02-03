import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../service/api_service.dart';
import '../../../service/auth_service.dart';
import '../../../service/storage/secure_storage_service.dart';
import '../../../service/storage/shared_storage_service.dart';
import '../../../service/storage/storage_service.dart';
import '../../../service/theme_service.dart';
import '../../../service/user_state_service.dart';
import '../../../service/wallet_service.dart';
import '../../../theme/theme.dart';
import '../../../theme/typography.dart';
import '../../../util/util.dart';
import '../../../widgets/dinasona_button.dart';
import '../../login/donor_and_beneficiary/login_page.dart';
import 'bullet_point_widget.dart';

class DeleteAccountBottomSheet extends StatelessWidget {
  const DeleteAccountBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Get.find<ThemeService>().theme;
    final UserStateService userStateService = Get.find<UserStateService>();
    final APIService apiService = Get.find<APIService>();
    final AuthService authService = Get.find<AuthService>();
    final SecureStorageService storageService =
        Get.find<StorageService>().secure;
    return Container(
      padding: const EdgeInsets.all(16),

      //add rounded corners to the bottom sheet
      decoration: BoxDecoration(
        color: theme.moonstone,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const SizedBox(),
                Text(
                  textAlign: TextAlign.center,
                  'Delete account'.tr,
                  style: CustomTypography.fromColor(theme.graphite).k16SemiBold,
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: Get.back,
                ),
              ],
            ),
            Text(
              textAlign: TextAlign.center,
              'Are you sure you want to delete your account?'.tr,
              style: CustomTypography.fromColor(theme.shadowed).k24Bold,
            ),
            const Gap(10),
            Container(
              padding: EdgeInsets.all(getRelativeWidth(15)),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(getRelativeWidth(4)),
                border: Border.all(
                  color: theme.inferno,
                ),
              ),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: 'Your account associated with',
                  style: CustomTypography.fromColor(theme.graphite).k16Reg,
                  children: <TextSpan>[
                    TextSpan(
                      text: ' ${userStateService.user.value.email} ',
                      style: CustomTypography.fromColor(theme.graphite)
                          .k16SemiBold,
                    ),
                    TextSpan(
                      text: 'will be deleted from Dinasona.'.tr,
                      style: CustomTypography.fromColor(theme.graphite).k16Reg,
                    ),
                  ],
                ),
              ),
            ),
            Gap(getRelativeHeight(15)),
            Text(
              'By submitting a request for Dinasona to delete your account, you understand and acknowledge that:'
                  .tr,
              style: CustomTypography.fromColor(theme.graphite).k16Reg,
            ),
            Gap(getRelativeHeight(15)),
            const BulletPointWidget(
              symbol: '1.',
              text: 'You will no longer be able to access your account',
              isBold: true,
            ),
            const BulletPointWidget(
              symbol: '2.',
              text:
                  'Account deletion requests will typically be completed within 30 days.',
              isBold: true,
            ),
            const BulletPointWidget(
              symbol: '3.',
              text:
                  'You will be logged out of the app after submitting your request.',
              isBold: true,
            ),
            const BulletPointWidget(
              symbol: '4.',
              text:
                  'A request to delete your account may also remove your personal data associated with your account from our system.',
              isBold: true,
            ),
            const Gap(10),
            DinasonaButton(
              color: theme.amberglow,
              text: 'Delete my account'.tr,
              onPressed: () async {
                try {
                  await Get.find<AuthService>().deleteUser();
                } catch (e) {
                  if (!e.toString().contains('u s e r _ n o t _ f o u n d')) {
                    throw Exception(e);
                  } else {
                    apiService.authenticationToken = '';
                    await storageService.delete('token');
                    // Disconnect other providers
                    await authService.disconnectProviders();
                  }
                }

                await Get.find<WalletService>().deleteUserWallet();
                userStateService.clear();
                await Get.find<SharedStorageService>().delete('language');
                await Get.offAll<void>(
                  () => const LoginPage(),
                  transition: Transition.upToDown,
                );
              },
            ),
            Gap(getRelativeHeight(20)),
          ],
        ),
      ),
    );
  }
}
