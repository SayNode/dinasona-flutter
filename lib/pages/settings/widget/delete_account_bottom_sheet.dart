import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../service/auth_service.dart';
import '../../../service/theme_service.dart';
import '../../../service/user_state_service.dart';
import '../../../theme/theme.dart';
import '../../../theme/typography.dart';
import '../../../util/util.dart';
import '../../../widgets/dinasona_button.dart';
import '../../choose_path_page.dart';
import 'bullet_point_widget.dart';

class DeleteAccountBottomSheet extends StatelessWidget {
  const DeleteAccountBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Get.find<ThemeService>().theme;
    final UserStateService userStateService = Get.find<UserStateService>();
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const SizedBox(),
              Text(
                textAlign: TextAlign.center,
                'Delet account'.tr,
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
          Text(
            textAlign: TextAlign.center,
            'Your account associated with email address here will be deleted from Dinasona.'
                .tr,
            style: CustomTypography.fromColor(theme.shadowed).k16Reg,
          ),
          Gap(getRelativeHeight(24)),
          const BulletPointWidget(
            symbol: '1.',
            text: 'You will no longer be able to access your account',
          ),
          const BulletPointWidget(
            symbol: '2.',
            text:
                'Account deletion requests will typically be completed within 30 days.',
          ),
          const BulletPointWidget(
            symbol: '3.',
            text:
                'You will be logged out of the app after submitting your request.',
          ),
          const BulletPointWidget(
            symbol: '4.',
            text:
                'A request to delete your account may also remove your personal data associated with your account from our system.',
          ),
          const Gap(10),
          DinasonaButton(
            color: theme.amberglow,
            text: 'Delete my account'.tr,
            onPressed: () async {
              await Get.find<AuthService>().deleteUser();
              userStateService.clear();
              await Get.offAll<void>(
                () => const ChosePathPage(),
                transition: Transition.upToDown,
              );
            },
          ),
        ],
      ),
    );
  }
}
