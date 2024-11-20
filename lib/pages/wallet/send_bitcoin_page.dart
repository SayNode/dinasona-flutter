import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../model/need.dart';
import '../../service/localization_controller.dart';
import '../../service/theme_service.dart';
import '../../theme/theme.dart';
import '../../theme/typography.dart';
import '../../util/util.dart';
import '../../widgets/custom_scaffold.dart';
import '../../widgets/dinasona_button.dart';
import 'controllers/send_payment_controller.dart';
import 'widgets/qr_code_scanner_page.dart';

class SendBitcoinPage extends GetView<SendPaymentController> {
  const SendBitcoinPage({
    this.bolt11InvoiceFromQRCode = '',
    super.key,
    this.bolt11FromDonation,
    this.need,
  });

  final String? bolt11InvoiceFromQRCode;
  final String? bolt11FromDonation;
  final Need? need;

  @override
  Widget build(BuildContext context) {
    Get.put(SendPaymentController());

    final CustomTheme theme = Get.put(ThemeService()).theme;

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if ((bolt11InvoiceFromQRCode ?? '').isNotEmpty) {
        controller.bolt11Invoice.value = bolt11InvoiceFromQRCode!;
        controller.sendBTCInvoiceInput.text = controller.bolt11Invoice.value;

        await controller.getInvoiceAmount();
        unawaited(controller.getFees());
      }
      if ((bolt11FromDonation ?? '').isNotEmpty) {
        controller.bolt11Invoice.value = bolt11FromDonation!;
        controller.sendBTCInvoiceInput.text = controller.bolt11Invoice.value;

        await controller.getInvoiceAmount();
        unawaited(controller.getFees());
      }
      //controller.sendBTCPaymentError.value = '';
      //controller.invoiceDescription.value = '';
      //controller.sendPaymentTransactionFee.value = 0;
      //controller.sendPaymentSayNodeFee.value = 0;
      //await controller.getInvoiceAmount();
      //unawaited(controller.getFees());
    });

    return CustomScaffold(
      padding: true,
      appBarTitle: 'Send'.tr,
      boldTitle: false,
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Column(
          children: <Widget>[
            Obx(
              () => Text(
                '${controller.invoiceAmountBTC.value} BTC',
                style: CustomTypography.fromColor(theme.amberglow).k24Bold,
              ),
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
            Obx(
              () => Text(
                '${controller.invoiceAmountUserCurrency.value} ${Get.find<LocalizationController>().selectedCurrency['sign']}',
                style: CustomTypography.fromColor(theme.shadowed).k24Bold,
              ),
            ),
            Gap(getRelativeHeight(10)),
            TextField(
              controller: controller.sendBTCInvoiceInput,
              onChanged: (String value) async {
                await controller.getInvoiceAmount();
                unawaited(controller.getFees());
              },
              decoration: InputDecoration(
                hintText: 'Invoice'.tr,
                contentPadding: EdgeInsets.symmetric(
                  vertical: getRelativeHeight(20),
                  horizontal: getRelativeWidth(15),
                ),
                suffixIcon: Container(
                  margin: EdgeInsets.only(right: getRelativeWidth(10)),
                  decoration: BoxDecoration(
                    color: theme.silvershine,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  alignment: Alignment.center,
                  width: 70,
                  padding: const EdgeInsets.all(5),
                  child: GestureDetector(
                    onTap: () => Get.to<void>(() => const QrCodeScannerPage()),
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.flip, color: theme.graphite),
                        Text(
                          'Scan',
                          style:
                              CustomTypography.fromColor(theme.graphite).k14Reg,
                        ),
                      ],
                    ),
                  ),
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
            Gap(getRelativeHeight(10)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Transaction fee'.tr,
                  style: CustomTypography.fromColor(theme.shadowed).k16Reg,
                ),
                Obx(
                  () => Text(
                    '${controller.sendPaymentTransactionFee.value} sat${controller.sendPaymentTransactionFee.value == 1 ? '' : 's'}',
                    style: CustomTypography.fromColor(theme.shadowed).k16Reg,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                // TODO change to user currency
                AutoSizeText(
                  'SayNode Fee (1%, min CHF 0.50)'.tr,
                  maxLines: 1,
                  style: CustomTypography.fromColor(theme.shadowed).k16Reg,
                ),
                Obx(
                  () => Text(
                    '${controller.sendPaymentSayNodeFee.value} sat${controller.sendPaymentSayNodeFee.value == 1 ? '' : 's'}',
                    style: CustomTypography.fromColor(theme.shadowed).k16Reg,
                  ),
                ),
              ],
            ),
            Gap(getRelativeHeight(10)),
            Row(
              children: <Widget>[
                Obx(
                  () => Text(
                    controller.invoiceDescription.value.isNotEmpty
                        ? '${'Description'.tr}:\t'
                        : '',
                    style:
                        CustomTypography.fromColor(theme.shadowed).k16SemiBold,
                  ),
                ),
                Obx(
                  () => Text(
                    controller.invoiceDescription.value,
                    style: CustomTypography.fromColor(theme.shadowed).k16Reg,
                  ),
                ),
              ],
            ),
            Gap(getRelativeHeight(10)),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Obx(
                    () => Text(
                      controller.sendBTCPaymentError.value.isNotEmpty
                          ? '${'Error'.tr}:\t'
                          : '',
                      style: CustomTypography.fromColor(theme.shadowed)
                          .k16SemiBold,
                    ),
                  ),
                  Flexible(
                    child: Obx(
                      () => AutoSizeText(
                        controller.sendBTCPaymentError.value,
                        maxLines: 4,
                        style: CustomTypography.fromColor(theme.inferno).k16Reg,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Obx(
              () => DinasonaButton(
                text: 'Send'.tr,
                color: theme.amberglow,
                onPressed: () {
                  if (need != null) {
                    controller.sendPaymentWithFee(needForDonationObject: need);
                  }
                  controller.sendPaymentWithFee();
                },
                locked: controller.bolt11Invoice.value == '' ||
                    controller.feesCalculated.value == false,
              ),
            ),
            Gap(getRelativeHeight(30)),
          ],
        ),
      ),
    );
  }
}
