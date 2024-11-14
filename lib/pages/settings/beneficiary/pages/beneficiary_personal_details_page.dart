import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../model/beneficiary.dart';
import '../../../../service/theme_service.dart';
import '../../../../service/user_state_service.dart';
import '../../../../theme/theme.dart';
import '../../../../theme/typography.dart';
import '../../../../util/util.dart';
import '../../../../widgets/avatar_widget/avatar_widget.dart';
import '../../../../widgets/custom_scaffold.dart';
import 'edit_beneficiary_details_page.dart';

class BeneficiaryPersonalDetailsPage extends StatelessWidget {
  const BeneficiaryPersonalDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final UserStateService userStateService = Get.find<UserStateService>();
    final CustomTheme theme = Get.find<ThemeService>().theme;
    final DateFormat dateFormat = DateFormat('yyyy-MM-dd');

    return CustomScaffold(
      appBarTitle: 'Personal details'.tr,
      actions: <Widget>[
        TextButton(
          onPressed: () async {
            await userStateService.fetchBeneficiaryInfo();
            await Get.off<void>(() => const EditBeneficiaryPage());
          },
          child: Text(
            'Edit'.tr,
            style: CustomTypography.fromColor(theme.ferngreen).k16SemiBold,
          ),
        ),
      ],
      padding: true,
      body: FutureBuilder<void>(
        future: userStateService.fetchBeneficiaryInfo(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error while fetching user data'.tr),
            );
          } else {
            return Column(
              children: <Widget>[
                Gap(getRelativeHeight(42)),
                const AvatarWidget(),
                Gap(getRelativeHeight(42)),
                Text(
                  userStateService.user.value.name.isEmpty
                      ? 'Name placeholder'.tr
                      : userStateService.user.value.name,
                  style: CustomTypography.fromColor(theme.shadowed).k24Bold,
                ),
                const Gap(12),
                Row(
                  children: <Widget>[
                    Icon(Symbols.location_on, color: theme.graphite),
                    const Gap(6),
                    Text(
                      userStateService.user.value.beneficiary.location.isEmpty
                          ? 'location placeholder'.tr
                          : userStateService.user.value.beneficiary.location,
                      style: CustomTypography.fromColor(theme.graphite).k16Reg,
                    ),
                  ],
                ),
                const Gap(8),
                Row(
                  children: <Widget>[
                    Icon(Symbols.mail, color: theme.graphite),
                    const Gap(6),
                    Text(
                      userStateService.user.value.email.isEmpty
                          ? 'email placeholder'.tr
                          : userStateService.user.value.email,
                      style: CustomTypography.fromColor(theme.graphite).k16Reg,
                    ),
                  ],
                ),
                const Gap(8),
                Row(
                  children: <Widget>[
                    Icon(Symbols.male, color: theme.graphite),
                    const Gap(6),
                    Text(
                      userStateService.user.value.beneficiary.gender ==
                              Gender.anonymous
                          ? 'gender placeholder'.tr
                          : userStateService.user.value.beneficiary.gender ==
                                  Gender.male
                              ? 'Male'.tr
                              : 'Female'.tr,
                      style: CustomTypography.fromColor(theme.graphite).k16Reg,
                    ),
                  ],
                ),
                const Gap(8),
                Row(
                  children: <Widget>[
                    Icon(Symbols.location_on, color: theme.graphite),
                    const Gap(6),
                    Text(
                      userStateService.user.value.beneficiary.dateOfBirth ==
                              null
                          ? 'Birthday placeholder'.tr
                          : dateFormat.format(
                              userStateService
                                  .user.value.beneficiary.dateOfBirth!,
                            ),
                      style: CustomTypography.fromColor(theme.graphite).k16Reg,
                    ),
                  ],
                ),
                const Gap(12),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    userStateService.user.value.beneficiary.bio.isEmpty
                        ? 'Description placeholder'.tr
                        : userStateService.user.value.beneficiary.bio,
                    style: CustomTypography.fromColor(theme.graphite).k16Reg,
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
