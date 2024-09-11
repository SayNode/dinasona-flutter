import 'package:breez_sdk/bridge_generated.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../service/theme_service.dart';
import '../../../theme/theme.dart';
import '../../../theme/typography.dart';
import '../../../util/util.dart';
import '../controllers/wallet_page_controller.dart';

class ListOfTransactions extends GetView<WalletPageController> {
  const ListOfTransactions({super.key});

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Get.put(ThemeService()).theme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Transactions'.tr,
          style: CustomTypography.fromColor(theme.shadowed).k24Bold,
        ),
        Obx(
          () => ListView.builder(
            padding: EdgeInsets.only(top: getRelativeHeight(15)),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: controller.transactions.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: EdgeInsets.only(bottom: getRelativeHeight(15)),
                child: Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(getRelativeWidth(5)),
                      decoration: BoxDecoration(
                        color: theme.silvershine,
                        borderRadius: BorderRadius.circular(13),
                      ),
                      child: Obx(
                        () => Transform.rotate(
                          angle: controller.transactions[index].status ==
                                  PaymentStatus.Pending
                              ? 0
                              : controller.transactions[index].paymentType ==
                                      PaymentType.Received
                                  ? 0.8
                                  : 3.9,
                          child: controller.transactions[index].status ==
                                  PaymentStatus.Pending
                              ? Icon(Icons.more_horiz, color: theme.shadowed)
                              : Icon(
                                  Icons.arrow_upward,
                                  color: controller.transactions[index]
                                              .paymentType ==
                                          PaymentType.Received
                                      ? theme.ferngreen
                                      : theme.inferno,
                                ),
                        ),
                      ),
                    ),
                    Gap(getRelativeWidth(15)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          controller.transactions[index].status ==
                                  PaymentStatus.Pending
                              ? 'waiting'.tr
                              : controller.transactions[index].status ==
                                      PaymentStatus.Complete
                                  ? controller.transactions[index]
                                              .paymentType ==
                                          PaymentType.Received
                                      ? 'done'.tr
                                      : controller.transactions[index]
                                                  .paymentType ==
                                              PaymentType.Sent
                                          ? 'spent'.tr
                                          : 'closed channel'.tr
                                  : 'failed'.tr,
                          style: CustomTypography.fromColor(theme.shadowed)
                              .k16SemiBold,
                        ),
                        Text(
                          getTimePassedString(
                            DateTime.fromMillisecondsSinceEpoch(
                              controller.transactions[index].paymentTime * 1000,
                            ),
                          ),
                          style:
                              CustomTypography.fromColor(theme.graphite).k14Reg,
                        ),
                      ],
                    ),
                    const Spacer(),
                    Obx(
                      () {
                        if (index < 0 ||
                            index >= controller.transactionAmounts.length) {
                          return CircularProgressIndicator(
                            color: theme.shadowed,
                          );
                        } else {
                          return Text(
                            '${controller.transactions[index].paymentType == PaymentType.Received ? '+' : '-'} ${controller.transactionAmounts[index].toStringAsFixed(3)}',
                            style: CustomTypography.fromColor(
                              controller.transactions[index].status ==
                                      PaymentStatus.Pending
                                  ? theme.shadowed
                                  : controller.transactions[index]
                                              .paymentType ==
                                          PaymentType.Received
                                      ? theme.ferngreen
                                      : theme.inferno,
                            ).k16SemiBold,
                          );
                        }
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
