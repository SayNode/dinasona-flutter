import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../model/beneficiary.dart';
import '../../service/theme_service.dart';
import '../../service/user_state_service.dart';
import '../../theme/theme.dart';
import '../../theme/typography.dart';
import '../../util/util.dart';
import '../../widgets/custom_scaffold.dart';
import '../../widgets/dinasona_button.dart';
import '../../widgets/dinasona_textfield.dart';
import 'controller/personal_details_controller.dart';

class PersonalDetailsPage extends GetView<PersonalDetailsController> {
  const PersonalDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(PersonalDetailsController());
    final CustomTheme dinasonaTheme = Get.find<ThemeService>().theme;
    final double gap = getRelativeHeight(12);
    final UserStateService userStateService = Get.find<UserStateService>();

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: CustomScaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
              top: getRelativeHeight(80),
              left: getRelativeWidth(20),
              right: getRelativeWidth(20),
            ),
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Personal details'.tr,
                    style: CustomTypography.fromColor(dinasonaTheme.shadowed)
                        .k24Bold,
                  ),
                ),
                SizedBox(height: gap),
                Text(
                  'Share key details to personalize your experience. Your information helps us connect you with the right support.'
                      .tr,
                  style:
                      CustomTypography.fromColor(dinasonaTheme.graphite).k16Reg,
                ),
                SizedBox(height: gap),
                Form(
                  child: Column(
                    children: <Widget>[
                      Obx(
                        () => Container(
                          margin: const EdgeInsets.all(20),
                          width: getRelativeWidth(106),
                          height: getRelativeWidth(106),
                          decoration: BoxDecoration(
                            border: Border.all(color: dinasonaTheme.graphite),
                            shape: BoxShape.circle,
                            image: controller.userStateService.user.value.avatar
                                    .isNotEmpty
                                ? DecorationImage(
                                    image: NetworkImage(
                                      controller
                                          .userStateService.user.value.avatar,
                                    ),
                                    fit: BoxFit.cover,
                                  )
                                : controller.selectedImage.value == null
                                    ? null
                                    : DecorationImage(
                                        image: FileImage(
                                          controller.selectedImage.value!,
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(1000),
                            onTap: () {
                              controller.pickImage(ImageSource.gallery);
                            },
                            child: controller.selectedImage.value == null &&
                                    controller.userStateService.user.value
                                        .avatar.isEmpty
                                ? SizedBox(
                                    width: getRelativeWidth(30),
                                    child: SvgPicture.asset(
                                      'assets/images/add_photo.svg',
                                      fit: BoxFit.scaleDown,
                                    ),
                                  )
                                : const SizedBox.shrink(),
                          ),
                        ),
                      ),
                      DinasonaTextField(
                        controller: controller.fullNameController,
                        hintText: 'Full name',
                      ),
                      SizedBox(height: gap),
                      DinasonaTextField(
                        controller: controller.emailController,
                        hintText: 'Email',
                      ),

                      SizedBox(height: gap),
                      // gender & DOB
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: dinasonaTheme.graphite),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: DropdownButtonFormField<Gender>(
                                isExpanded: true,
                                value: controller.selectedGender,
                                style: CustomTypography.fromColor(
                                  dinasonaTheme.shadowed,
                                ).k16Reg,
                                borderRadius: BorderRadius.circular(16),
                                dropdownColor: dinasonaTheme.moonstone,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide.none,
                                  ),
                                  hintText: 'Gender',
                                ),
                                items: Gender.values
                                    .map<DropdownMenuItem<Gender>>(
                                        (Gender gender) {
                                  return DropdownMenuItem<Gender>(
                                    value: gender,
                                    child: Column(
                                      children: <Widget>[
                                        Obx(
                                          () => Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Flexible(
                                                child: AutoSizeText(
                                                  gender.title,
                                                  minFontSize: 9,
                                                  maxFontSize: 16,
                                                  maxLines: 1,
                                                  style: CustomTypography
                                                      .fromColor(
                                                    gender.name ==
                                                            controller
                                                                .selectedGender
                                                                .name
                                                        ? dinasonaTheme
                                                            .ferngreen
                                                        : dinasonaTheme
                                                            .shadowed,
                                                  ).k16Reg,
                                                ),
                                              ),
                                              Icon(
                                                gender.icon,
                                                color: gender.name ==
                                                        controller
                                                            .selectedGender.name
                                                    ? dinasonaTheme.ferngreen
                                                    : dinasonaTheme.shadowed,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                                onChanged: (Gender? value) {
                                  controller.selectedGender = value!;
                                },
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Obx(
                              () => TextField(
                                onTap: () => controller.selectDate(context),
                                readOnly: true,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  hintText: controller
                                          .dateOfBirthController.value.isEmpty
                                      ? 'Date of birth'
                                      : controller.dateOfBirthController.value,
                                  suffixIcon: const Icon(Icons.calendar_month),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: gap),
                      Card(
                        shadowColor: Colors.transparent,
                        margin: EdgeInsets.zero,
                        color: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(getRelativeWidth(16)),
                          ),
                          side: BorderSide(
                            color: dinasonaTheme.graphite,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: DropdownButtonFormField<String>(
                            hint: Text(
                              'Country',
                              style: CustomTypography.fromColor(
                                dinasonaTheme.graphite,
                              ).k16Reg,
                            ),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                            value: userStateService
                                        .user.value.beneficiary.country
                                        .toLowerCase() ==
                                    'switzerland'
                                ? 'Switzerland'
                                : userStateService
                                            .user.value.beneficiary.country
                                            .toLowerCase() ==
                                        'other'
                                    ? 'Other'
                                    : null,
                            items: <String>[
                              'Switzerland',
                              'Other',
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: CustomTypography.fromColor(
                                    dinasonaTheme.shadowed,
                                  ).k16Reg,
                                ),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              controller.country.value = newValue!;
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: gap),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: dinasonaTheme.graphite),
                        ),
                        child: Column(
                          children: <Widget>[
                            TextField(
                              controller: controller.descriptionTextController,
                              maxLength: controller.descriptionMaxLenth,
                              decoration: const InputDecoration(
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                hintText: 'Description',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: gap),
                DinasonaButton(
                  text: 'Continue',
                  onPressed: controller.submit,
                  color: dinasonaTheme.amberglow,
                ),
                SizedBox(height: gap),
                TextButton(
                  onPressed: () => controller.skip(),
                  child: Text(
                    'Skip',
                    style: CustomTypography.fromColor(dinasonaTheme.ferngreen)
                        .k16Reg,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
