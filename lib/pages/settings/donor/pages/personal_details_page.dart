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
    return CustomScaffold(
      appBarTitle: 'Personal details'.tr,
      padding: true,
      body: Column(
        children: <Widget>[
          const AvatarWidget(),
          Gap(getRelativeHeight(42)),
          DinasonaTextField(
            hintText: 'First name'.tr,
            hintColor: diasonaTheme.graphite,
            hintStyle: CustomTypography.fromColor(diasonaTheme.graphite).k16Reg,
            textStyle: CustomTypography.fromColor(diasonaTheme.graphite).k16Reg,
            controller: controller.fistNameController,
          ),
          const Gap(6),
          DinasonaTextField(
            hintText: 'Last name'.tr,
            hintColor: diasonaTheme.graphite,
            hintStyle: CustomTypography.fromColor(diasonaTheme.graphite).k16Reg,
            textStyle: CustomTypography.fromColor(diasonaTheme.graphite).k16Reg,
            controller: controller.secondNameController,
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
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
                hintStyle:
                    CustomTypography.fromColor(diasonaTheme.graphite).k16Reg,
                hintText: 'Location'.tr,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
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
              onChanged: (String? value) {
                controller.location.value = value!;
              },
            ),
          ),
          // DropdownButton<String>(
          //   onChanged: (String? newValue) {
          //     controller.location.value = newValue!;
          //   },
          //   items: <String>['Switzerland', 'Other']
          //       .map<DropdownMenuItem<String>>((String value) {
          //     return DropdownMenuItem<String>(
          //       value: value,
          //       child: Text(value),
          //     );
          //   }).toList(),
          // ),
          const Spacer(),
          Obx(
            () {
              return DinasonaButton(
                text: 'Save'.tr,
                onPressed: controller.save,
                loading: controller.loading.value,
              );
            },
          ),
          Gap(getRelativeHeight(80)),
        ],
      ),
    );
  }
}
