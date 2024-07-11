import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../service/theme_service.dart';
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
    final CustomTheme theme = Get.find<ThemeService>().theme;
    return CustomScaffold(
      appBarTitle: 'Personal details'.tr,
      actions: <Widget>[
        TextButton(
          onPressed: () => Get.to(() => const EditBeneficiaryPage()),
          child: Text(
            'Edit'.tr,
            style: CustomTypography.fromColor(theme.ferngreen).k16SemiBold,
          ),
        ),
      ],
      padding: true,
      body: Column(
        children: <Widget>[
          Gap(getRelativeHeight(42)),
          const AvatarWidget(),
          Gap(getRelativeHeight(42)),
          Text(
            'name placeholder'.tr,
            style: CustomTypography.fromColor(theme.shadowed).k24Bold,
          ),
          const Gap(12),
          Row(
            children: <Widget>[
              Icon(Symbols.location_on, color: theme.graphite),
              const Gap(6),
              Text(
                'location placeholder'.tr,
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
                'email placeholder'.tr,
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
                'gender placeholder'.tr,
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
                'birthdate placeholder'.tr,
                style: CustomTypography.fromColor(theme.graphite).k16Reg,
              ),
            ],
          ),
          const Gap(12),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Description placeholder'.tr,
              style: CustomTypography.fromColor(theme.graphite).k16Reg,
            ),
          ),
        ],
      ),
    );
  }
}
