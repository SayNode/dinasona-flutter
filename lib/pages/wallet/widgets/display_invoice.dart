import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../service/theme_service.dart';
import '../../../theme/theme.dart';
import '../../../theme/typography.dart';
import '../../../util/util.dart';
import '../controllers/receive_payment_controller.dart';

class DisplayInvoice extends GetView<ReceivePaymentController> {
  const DisplayInvoice({super.key});

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Get.put(ThemeService()).theme;

    return Column(
      children: <Widget>[
        Text(
          '${controller.sendBTCInputBTC.text} BTC',
          style: CustomTypography.fromColor(theme.amberglow).k24Bold,
        ),
        Obx(
          () => QrImageView(
            data: controller.createdInvoiceBolt11.value,
          ),
        ),
        Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '${controller.createdInvoiceBolt11.value.substring(0, 5)}...${controller.createdInvoiceBolt11.value.substring(controller.createdInvoiceBolt11.value.length - 5, controller.createdInvoiceBolt11.value.length)}',
                style: CustomTypography.fromColor(theme.amberglow).k16SemiBold,
              ),
              Gap(getRelativeWidth(15)),
              IconButton(
                onPressed: () {
                  controller.invoiceIsGenerated.value = false;
                },
                icon: Icon(Icons.edit_outlined, color: theme.amberglow),
              ),
            ],
          ),
        ),
        Gap(getRelativeHeight(10)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: TextButton(
                onPressed: () async {
                  await Clipboard.setData(
                    ClipboardData(
                      text: controller.createdInvoiceBolt11.value,
                    ),
                  );
                },
                style: ButtonStyle(
                  padding: WidgetStateProperty.all(
                    EdgeInsets.symmetric(
                      vertical: getRelativeHeight(15),
                    ),
                  ),
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      side: BorderSide(
                        color: theme.graphite,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.copy, color: theme.graphite),
                    Gap(getRelativeHeight(10)),
                    Text(
                      'Copy',
                      style: CustomTypography.fromColor(theme.graphite)
                          .k16SemiBold,
                    ),
                  ],
                ),
              ),
            ),
            Gap(getRelativeWidth(20)),
            Expanded(
              child: TextButton(
                onPressed: () {
                  Share.share(
                    controller.createdInvoiceBolt11.value,
                    subject: 'Lightning Network Invoice'.tr,
                  );
                },
                style: ButtonStyle(
                  padding: WidgetStateProperty.all(
                    EdgeInsets.symmetric(
                      vertical: getRelativeHeight(15),
                    ),
                  ),
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      side: BorderSide(
                        color: theme.graphite,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.ios_share, color: theme.graphite),
                    Gap(getRelativeHeight(10)),
                    Text(
                      'Share',
                      style: CustomTypography.fromColor(theme.graphite)
                          .k16SemiBold,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
