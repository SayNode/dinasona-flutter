import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../service/theme_service.dart';
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
    final CustomTheme diasonaTheme = Get.find<ThemeService>().theme;
    final double gap = getRelativeHeight(12);

    return CustomScaffold(
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
                  style:
                      CustomTypography.fromColor(diasonaTheme.shadowed).k24Bold,
                ),
              ),
              SizedBox(height: gap),
              Text(
                'Share key details to personalize your experience. Your information helps us connect you with the right support.'
                    .tr,
                style: CustomTypography.fromColor(diasonaTheme.graphite).k16Reg,
              ),
              SizedBox(height: gap),
              Form(
                child: Column(
                  children: <Widget>[
                    Obx(
                      () => Container(
                        margin: const EdgeInsets.all(20),
                        width: getRelativeWidth(100),
                        height: getRelativeHeight(100),
                        decoration: BoxDecoration(
                          border: Border.all(color: diasonaTheme.graphite),
                          shape: BoxShape.circle,
                          image: controller.selectedImage.value == null
                              ? null
                              : DecorationImage(
                                  image: FileImage(
                                    controller.selectedImage.value!,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(300),
                          onTap: () {
                            controller.pickImage(ImageSource.gallery);
                          },
                          child: controller.selectedImage.value == null
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
                          flex: 5,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              border: Border.all(color: diasonaTheme.graphite),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: DropdownButtonFormField<Gender>(
                              value: controller.selectedGender,
                              style: CustomTypography.fromColor(
                                diasonaTheme.shadowed,
                              ).k16Reg,
                              borderRadius: BorderRadius.circular(16),
                              dropdownColor: diasonaTheme.moonstone,
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
                                            Text(
                                              gender.text,
                                              style: CustomTypography.fromColor(
                                                gender.name ==
                                                        controller
                                                            .selectedGender.name
                                                    ? diasonaTheme.ferngreen
                                                    : diasonaTheme.shadowed,
                                              ).k16Reg,
                                            ),
                                            Icon(
                                              gender.icon,
                                              color: gender.name ==
                                                      controller
                                                          .selectedGender.name
                                                  ? diasonaTheme.ferngreen
                                                  : diasonaTheme.shadowed,
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
                          flex: 4,
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
                    DinasonaTextField(
                      controller: controller.locationController,
                      hintText: 'Location',
                    ),
                    SizedBox(height: gap),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: diasonaTheme.graphite),
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
                color: diasonaTheme.amberglow,
              ),
              SizedBox(height: gap),
              TextButton(
                onPressed: () => Get.back<void>(),
                child: Text(
                  'Skip',
                  style:
                      CustomTypography.fromColor(diasonaTheme.ferngreen).k16Reg,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
