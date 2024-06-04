import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../service/theme_service.dart';
import '../../theme/theme.dart';
import '../../theme/typography.dart';
import '../../util/util.dart';
import '../../widget/custom_scaffold.dart';
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
                  'Personal details',
                  style:
                      CustomTypography.fromColor(diasonaTheme.shadowed).k24Bold,
                ),
              ),
              SizedBox(height: gap),
              Text(
                'Share key details to personalize your experience. Your information helps us connect you with the right support.',
                style: CustomTypography.fromColor(diasonaTheme.graphite).k16Reg,
              ),
              SizedBox(height: gap),
              Form(
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.all(20),
                      width: getRelativeWidth(100),
                      height: getRelativeHeight(100),
                      decoration: BoxDecoration(
                        border: Border.all(color: diasonaTheme.graphite),
                        shape: BoxShape.circle,
                      ),
                      child: InkWell(
                        onTap: () {
                          //TODO add photo
                        },
                        child: SizedBox(
                          width: getRelativeWidth(30),
                          child: SvgPicture.asset(
                            'asset/images/add_photo.svg',
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                      ),
                    ),
                    TextField(
                      controller: controller.fullNameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        hintText: 'Full name',
                      ),
                    ),
                    SizedBox(height: gap),
                    TextField(
                      controller: controller.emailController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        hintText: 'Email',
                      ),
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
                              borderRadius: BorderRadius.circular(16),
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
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(gender.text),
                                          Icon(gender.icon),
                                        ],
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
                    TextField(
                      controller: controller.locationController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        hintText: 'Location',
                      ),
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
              Container(
                alignment: Alignment.center,
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: getRelativeHeight(20)),
                decoration: BoxDecoration(
                  color: diasonaTheme.amberglow,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: InkWell(
                  onTap: controller.submit,
                  child: Text(
                    'Continue',
                    style: CustomTypography.fromColor(diasonaTheme.moonstone)
                        .k16SemiBold,
                  ),
                ),
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
