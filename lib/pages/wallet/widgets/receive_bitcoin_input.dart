import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../service/theme_service.dart';
import '../../../theme/theme.dart';
import '../../../theme/typography.dart';
import '../../../util/util.dart';
import '../../../widgets/dinasona_button.dart';
import '../controllers/receive_payment_controller.dart';

class ReceiveBitcoinInput extends GetView<ReceivePaymentController> {
  const ReceiveBitcoinInput({super.key});

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Get.put(ThemeService()).theme;

    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AutoSizeTextField(
              controller: controller.sendBTCInputBTC,
              fullwidth: false,
              cursorColor: theme.amberglow,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
              ],
              style: CustomTypography.fromColor(theme.amberglow).k24Bold,
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
            ),
            Text(
              'BTC',
              style: CustomTypography.fromColor(theme.amberglow).k24Bold,
            ),
          ],
        ),
        Gap(getRelativeHeight(10)),
        Transform.rotate(
          angle: 1.55,
          child: Icon(
            Icons.sync_alt,
            color: theme.shadowed,
            size: getRelativeWidth(25),
          ),
        ),
        Gap(getRelativeHeight(10)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AutoSizeTextField(
              controller: controller.sendBTCInputUserCurrency,
              fullwidth: false,
              cursorColor: theme.shadowed,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
              ],
              style: CustomTypography.fromColor(theme.shadowed).k24Bold,
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
            ),
            Text(
              r'$',
              style: CustomTypography.fromColor(theme.shadowed).k24Bold,
            ),
          ],
        ),
        Gap(getRelativeHeight(10)),
        TextField(
          controller: controller.userInvoiceMessage,
          decoration: InputDecoration(
            hintText: 'Description'.tr,
            contentPadding: EdgeInsets.symmetric(
              vertical: getRelativeHeight(20),
              horizontal: getRelativeWidth(15),
            ),
            hintStyle: CustomTypography.fromColor(theme.shadowed).k16Reg,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                color: theme.graphite,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                color: theme.graphite,
              ),
            ),
          ),
          style: CustomTypography.fromColor(theme.shadowed).k16Reg,
        ),
        Gap(getRelativeHeight(16)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: DinasonaButton(
                text: 'Reset'.tr,
                textColor: theme.amberglow,
                onPressed: () {
                  controller.sendBTCInputUserCurrency.text = '0.0';
                  controller.sendBTCInputBTC.text = '0.0';
                  controller.userInvoiceMessage.text = '';
                },
                color: theme.moonstone,
                customElevation: 0,
                borderColor: theme.amberglow,
              ),
            ),
            Gap(getRelativeWidth(10)),
            Expanded(
              child: Obx(
                () => DinasonaButton(
                  text: 'Create'.tr,
                  onPressed: () {
                    controller.createInvoice();
                  },
                  locked: () {
                    final double? parsedValue = double.tryParse(
                      controller.sendBTCUserCurrencyInputCheck.value,
                    );
                    return parsedValue == null || parsedValue < 1;
                  }(),
                  color: theme.amberglow,
                ),
              ),
            ),
          ],
        ),
        const Spacer(),
        GestureDetector(
          onTap: () => controller.helpPage(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SvgPicture.asset('assets/images/logos/question_mark.svg'),
              Gap(getRelativeWidth(6)),
              Text(
                'How to use my donation'.tr,
                style: CustomTypography.fromColor(theme.shadowed).k16SemiBold,
              ),
            ],
          ),
        ),
        Gap(getRelativeHeight(35)),
      ],
    );
  }
}
