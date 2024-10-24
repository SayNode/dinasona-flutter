import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../service/theme_service.dart';
import '../../theme/theme.dart';
import '../../theme/typography.dart';
import '../../util/util.dart';
import '../../widgets/custom_scaffold.dart';
import '../../widgets/dinasona_button.dart';
import 'controllers/send_receive_bitcoin_controller.dart';
import 'widgets/qr_code_scanner_page.dart';

class SendBitcoinPage extends GetView<SendReceiveBitcoinController> {
  const SendBitcoinPage({this.bolt11InvoiceFromQRCode = '', super.key});

  final String? bolt11InvoiceFromQRCode;

  @override
  Widget build(BuildContext context) {
    Get.put(SendReceiveBitcoinController());
    final CustomTheme theme = Get.put(ThemeService()).theme;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.bolt11Invoice.value = bolt11InvoiceFromQRCode ?? '';
      controller.sendBTCInvoiceInput.text = controller.bolt11Invoice.value;
      controller.sendBTCPaymentError.value = '';
      controller.invoiceDescription.value = '';
      controller.getInvoiceAmount();
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
                '${controller.invoiceAmountUserCurrency.value} \$',
                style: CustomTypography.fromColor(theme.shadowed).k24Bold,
              ),
            ),
            Gap(getRelativeHeight(10)),
            TextField(
              controller: controller.sendBTCInvoiceInput,
              onChanged: (String value) => controller.getInvoiceAmount(),
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
                  'Fee'.tr,
                  style: CustomTypography.fromColor(theme.shadowed).k16Reg,
                ),
                Text(
                  '1 sat',
                  style: CustomTypography.fromColor(theme.shadowed).k16Reg,
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
                  controller.sendBitcoin();
                },
                locked: controller.bolt11Invoice.value == '',
              ),
            ),
            Gap(getRelativeHeight(30)),
          ],
        ),
      ),
    );
  }
}
