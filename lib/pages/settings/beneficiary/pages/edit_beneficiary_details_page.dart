import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../model/beneficiary.dart';
import '../../../../service/theme_service.dart';
import '../../../../service/user_state_service.dart';
import '../../../../theme/theme.dart';
import '../../../../theme/typography.dart';
import '../../../../util/util.dart';
import '../../../../widgets/avatar_widget/avatar_widget.dart';
import '../../../../widgets/custom_scaffold.dart';
import '../../../../widgets/dinasona_button.dart';
import '../../../../widgets/dinasona_textfield.dart';
import '../controllers/beneficiary_personal_details_controller.dart';

class EditBeneficiaryPage
    extends GetView<BeneficiaryPersonalDetailsController> {
  const EditBeneficiaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final UserStateService userStateService = Get.find<UserStateService>();
    final CustomTheme theme = Get.find<ThemeService>().theme;
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, Object? result) async {
        if (didPop) {
          return;
        }
        final NavigatorState navigator = Navigator.of(context);

        await userStateService.fetchBeneficiaryInfo();

        navigator.pop(result);
      },
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: CustomScaffold(
          resizeToAvoidBottomInset: true,
          padding: true,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Personal details'.tr,
                    style: CustomTypography.fromColor(theme.shadowed).k24Bold,
                  ),
                  const Gap(12),
                  Text(
                    'Share key details to personalize your experience. Your information helps us connect you with the right support.'
                        .tr,
                    style: CustomTypography.fromColor(theme.graphite).k16Reg,
                  ),
                  Gap(getRelativeHeight(42)),
                  const Center(child: AvatarWidget()),
                  Gap(getRelativeHeight(42)),
                  DinasonaTextField(
                    hintText: 'Full name'.tr,
                    controller: controller.nameController,
                    textStyle:
                        CustomTypography.fromColor(theme.shadowed).k16Reg,
                    hintStyle:
                        CustomTypography.fromColor(theme.graphite).k16Reg,
                  ),
                  const Gap(6),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Card(
                          shadowColor: Colors.transparent,
                          margin: EdgeInsets.zero,
                          color: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(getRelativeWidth(16)),
                            ),
                            side: BorderSide(
                              color: theme.graphite,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: DropdownButtonFormField<String>(
                              hint: Text(
                                'Gender',
                                style:
                                    CustomTypography.fromColor(theme.graphite)
                                        .k16Reg,
                              ),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                              value: userStateService
                                          .user.value.beneficiary.gender ==
                                      Gender.male
                                  ? 'Male'
                                  : userStateService
                                              .user.value.beneficiary.gender ==
                                          Gender.female
                                      ? 'Female'
                                      : null,
                              items: <String>[
                                'Male',
                                'Female',
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: CustomTypography.fromColor(
                                      theme.shadowed,
                                    ).k16Reg,
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                controller.gender.value = newValue!;
                              },
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Card(
                          shadowColor: Colors.transparent,
                          margin: EdgeInsets.zero,
                          color: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(getRelativeWidth(16)),
                            ),
                            side: BorderSide(
                              color: theme.graphite,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: TextFormField(
                              style: CustomTypography.fromColor(theme.shadowed)
                                  .k16Reg,
                              controller: controller
                                  .birthdayController, // Assume you have a controller for birthday
                              decoration: InputDecoration(
                                hintText: 'Birthday'.tr,
                                hintStyle:
                                    CustomTypography.fromColor(theme.graphite)
                                        .k16Reg,
                                border: InputBorder.none,
                                // Match the styling with DinasonaTextFields
                              ),
                              readOnly: true, // To prevent manual editing
                              onTap: () async {
                                final DateTime? pickedDate =
                                    await showDatePicker(
                                  context: context,
                                  initialDate: Get.find<UserStateService>()
                                          .user
                                          .value
                                          .beneficiary
                                          .dateOfBirth ??
                                      DateTime(1960),
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime.now(),
                                );
                                if (pickedDate != null) {
                                  // Format and set the date in controller
                                  controller.birthdayController.text =
                                      DateFormat('yyyy-MM-dd')
                                          .format(pickedDate);
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Gap(6),
                  DinasonaTextField(
                    hintText: 'Location'.tr,
                    controller: controller.locationController,
                    textStyle:
                        CustomTypography.fromColor(theme.shadowed).k16Reg,
                    hintStyle:
                        CustomTypography.fromColor(theme.graphite).k16Reg,
                  ),
                  const Gap(6),
                  DinasonaTextField(
                    hintText: 'Description'.tr,
                    controller: controller.descriptionController,
                    textStyle:
                        CustomTypography.fromColor(theme.shadowed).k16Reg,
                    hintStyle:
                        CustomTypography.fromColor(theme.graphite).k16Reg,
                    maxLines: 5,
                  ),
                  const Gap(25),
                  Obx(
                    () {
                      return DinasonaButton(
                        text: 'Save'.tr,
                        onPressed: controller.save,
                        locked: !controller.isFormValid.value,
                        loading: controller.loading.value,
                      );
                    },
                  ),
                  Gap(getRelativeHeight(80)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
