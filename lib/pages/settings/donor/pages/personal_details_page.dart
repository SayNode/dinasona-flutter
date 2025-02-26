import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../../service/theme_service.dart';
import '../../../../theme/theme.dart';
import '../../../../theme/typography.dart';
import '../../../../util/util.dart';
import '../../../../widgets/avatar_widget/avatar_widget.dart';
import '../../../../widgets/custom_scaffold.dart';
import '../../../../widgets/dinasona_button.dart';
import '../../../../widgets/dinasona_textfield.dart';
import '../controllers/donor_personal_details_controller.dart';

class DonorPersonalDetailsPage extends GetView<DonorPersonalDetailsController> {
  DonorPersonalDetailsPage({super.key});
  final CustomTheme diasonaTheme = Get.find<ThemeService>().theme;

  @override
  Widget build(BuildContext context) {
    final RegExp invalidCharacters = RegExp(r"[^a-zA-Z\s\-\'\.]");

    return GestureDetector(
      onTap: () {
        final FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: CustomScaffold(
        appBarTitle: 'Personal details'.tr,
        padding: true,
        body: Column(
          children: <Widget>[
            const AvatarWidget(),
            Gap(getRelativeHeight(42)),
            Obx(
              () => DinasonaTextField(
                hintText: 'First name'.tr,
                borderColor: controller.firstName.value.isEmpty
                    ? diasonaTheme.graphite
                    : invalidCharacters.hasMatch(controller.firstName.value)
                        ? diasonaTheme.inferno
                        : diasonaTheme.ferngreen,
                hintColor: diasonaTheme.graphite,
                hintStyle:
                    CustomTypography.fromColor(diasonaTheme.graphite).k16Reg,
                textStyle:
                    CustomTypography.fromColor(diasonaTheme.graphite).k16Reg,
                controller: controller.fistNameController,
                onChanged: (String firstName) =>
                    controller.firstName.value = firstName,
                maxLength: 30,
              ),
            ),
            const Gap(6),
            Obx(
              () => DinasonaTextField(
                hintText: 'Last name'.tr,
                borderColor: controller.lastName.value.isEmpty
                    ? diasonaTheme.graphite
                    : invalidCharacters.hasMatch(controller.lastName.value)
                        ? diasonaTheme.inferno
                        : diasonaTheme.ferngreen,
                hintColor: diasonaTheme.graphite,
                hintStyle:
                    CustomTypography.fromColor(diasonaTheme.graphite).k16Reg,
                textStyle:
                    CustomTypography.fromColor(diasonaTheme.graphite).k16Reg,
                controller: controller.secondNameController,
                onChanged: (String lastName) =>
                    controller.lastName.value = lastName,
                maxLength: 30,
              ),
            ),
            const Gap(6),
            DecoratedBox(
              decoration: BoxDecoration(
                border: Border.all(color: diasonaTheme.graphite),
                borderRadius: BorderRadius.circular(16),
              ),
              child: DropdownButtonFormField<String>(
                // isExpanded: true,
                icon: const Icon(Icons.keyboard_arrow_down_sharp),
                dropdownColor: diasonaTheme.moonstone,
                borderRadius: BorderRadius.circular(16),
                hint: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Location'.tr,
                    style: CustomTypography.fromColor(diasonaTheme.graphite)
                        .k16Reg,
                  ),
                ),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  hintStyle:
                      CustomTypography.fromColor(diasonaTheme.graphite).k16Reg,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: getRelativeWidth(12)),
                ),
                items: <String>['Switzerland', 'Other']
                    .map<DropdownMenuItem<String>>((String country) {
                  return DropdownMenuItem<String>(
                    value: country,
                    child: Text(
                      country,
                      style: CustomTypography.fromColor(diasonaTheme.graphite)
                          .k16Reg,
                    ),
                  );
                }).toList(),
                value: controller.country.value.isEmpty
                    ? null
                    : controller.country.value.capitalizeFirst,
                onChanged: (String? value) {
                  controller.country.value = value!;
                },
              ),
            ),
            const Spacer(),
            Obx(
              () {
                return DinasonaButton(
                  text: 'Save'.tr,
                  onPressed: controller.save,
                  locked: controller.firstName.value.isEmpty ||
                      controller.lastName.value.isEmpty ||
                      invalidCharacters.hasMatch(controller.firstName.value) ||
                      invalidCharacters.hasMatch(controller.lastName.value),
                  loading: controller.loading.value,
                );
              },
            ),
            Gap(getRelativeHeight(80)),
          ],
        ),
      ),
    );
  }
}
