import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_breez_liquid/flutter_breez_liquid.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../model/need.dart';
import '../../../service/api_service.dart';
import '../../../service/breez_service.dart';
import '../../../service/currency_conversion_service.dart';
import '../../../service/logger_service.dart';
import '../../../service/wallet_service.dart';
import '../../../util/constants.dart';
import '../../../util/popup_manager.dart';
import '../../../util/util.dart';

class SendPaymentController extends GetxController {
  final CurrencyConversionService currencyConversionService =
      Get.find<CurrencyConversionService>();
  final APIService apiService = Get.find<APIService>();
  final LoggerService loggerService = Get.find<LoggerService>();
  BreezService breezService = Get.find<BreezService>();
  RxString invoiceAmountBTC = '0.0'.obs;
  RxString invoiceAmountUserCurrency = '0.0'.obs;
  RxString invoiceDescription = ''.obs;
  RxString bolt11Invoice = ''.obs;
  final TextEditingController sendBTCInvoiceInput = TextEditingController();
  final RxString sendBTCPaymentError = ''.obs;
  final RxInt sendPaymentTransactionFee = 0.obs;
  final RxInt sendPaymentSayNodeFee = 0.obs;
  late PrepareSendResponse preparedMainTransation;
  late PrepareSendResponse preparedSayNodeTransaction;
  final RxBool feesCalculated = false.obs;
  final RxBool mainTransactionWentThrough = false.obs;

  Future<void> getFees() async {
    feesCalculated.value = false;
    int tmpTransactionfee = 0;

    if (sendBTCPaymentError.value.isNotEmpty) {
      return;
    }
    if (bolt11Invoice.value.isEmpty) {
      sendPaymentTransactionFee.value = 0;
      sendPaymentSayNodeFee.value = 0;
      return;
    }
    if (double.parse(invoiceAmountUserCurrency.value) >=
        Get.find<WalletService>().balanceInUserCurrency.value) {
      sendBTCPaymentError.value = 'Insufficient balance'.tr;
    }
    try {
      // Prepare main transaction
      preparedMainTransation =
          await breezService.prepareSendingTransaction(bolt11Invoice.value);

      tmpTransactionfee = preparedMainTransation.feesSat.toInt();
      sendPaymentTransactionFee.value = tmpTransactionfee;

      // SayNode fee calculation
      if (!Constants.devMode) {
        final double saynodeVariableFeeInUserCurrency =
            await currencyConversionService.convertBitcoinToUserCurrency(
          double.parse(invoiceAmountBTC.value) * 0.01,
        );

        final double saynodeVariableFeeInCHF =
            (await currencyConversionService.fetchFiatCHFRate()) *
                saynodeVariableFeeInUserCurrency;

        final double breezMinimumTransactionAmountInCHF =
            (await currencyConversionService.fetchFiatCHFRate()) *
                (await currencyConversionService
                    .convertBitcoinToUserCurrency(0.00001));

        if (saynodeVariableFeeInCHF >= 0.5 &&
            saynodeVariableFeeInCHF >= breezMinimumTransactionAmountInCHF) {
          sendPaymentSayNodeFee.value =
              ((double.parse(invoiceAmountBTC.value) * 100000000) * 0.01)
                  .toInt();
        } else if (breezMinimumTransactionAmountInCHF >= 0.5) {
          sendPaymentSayNodeFee.value = 1000;
        } else {
          sendPaymentSayNodeFee.value = ((await currencyConversionService
                      .convertUserCurrencyToBitcoin(
                    0.5 / (await currencyConversionService.fetchFiatCHFRate()),
                  )) *
                  100000000)
              .toInt();
        }

        // Prepare SayNode fee transaction
        final String sayNodeFeeInvoice = await getSayNodeFeeInvoice(
          sendPaymentSayNodeFee.value.toDouble(),
          // Need id is static for now - might change this in the future to create payment statistics
          999,
        );
        preparedSayNodeTransaction =
            await breezService.prepareSendingTransaction(sayNodeFeeInvoice);
      }

      // Transaction fees are the sum of the Main transaction fee and the SayNode transaction fee
      if (!Constants.devMode) {
        sendPaymentTransactionFee.value =
            tmpTransactionfee + preparedSayNodeTransaction.feesSat.toInt();
      } else {
        sendPaymentTransactionFee.value = tmpTransactionfee;
      }
    } catch (e) {
      // Invalid invoice provided
      loggerService.log('Error getting invoice: $e');
      if (e.toString().contains('Invoice has expired')) {
        sendBTCPaymentError.value =
            'Invoice has expired or has already been paid'.tr;
      } else if (e.toString().contains('selfTransferNotSupported')) {
        sendBTCPaymentError.value = 'Self transfer is not supported'.tr;
      } else if (e.toString().contains('insufficientFunds')) {
        sendBTCPaymentError.value = 'Insufficient balance'.tr;
      } else {
        sendBTCPaymentError.value = 'Invoice is invalid'.tr;
      }
      return;
    }
    feesCalculated.value = true;
  }

  Future<Map<String, double>> getInvoiceAmount() async {
    try {
      sendBTCPaymentError.value = '';
      final LNInvoice invoice = await breezService.parseInvoice(
        sendBTCInvoiceInput.text,
      );
      bolt11Invoice.value = sendBTCInvoiceInput.text;
      invoiceDescription.value = invoice.description ?? '';

      double btcAmount = invoice.amountMsat!.toInt() / 100000000000;

      if (btcAmount.toString().contains('.') &&
          btcAmount.toString().split('.')[1].length > 20) {
        btcAmount = double.parse(
          (invoice.amountMsat!.toInt() / 100000000000).toStringAsFixed(20),
        );
      }

      invoiceAmountBTC.value = btcAmount.toString();
      invoiceAmountUserCurrency.value =
          (await Get.find<CurrencyConversionService>()
                  .convertBitcoinToUserCurrency(
        btcAmount,
      ))
              .toString();

      return <String, double>{
        'btc': btcAmount,
        'userCurrency': double.parse(invoiceAmountUserCurrency.value),
      };
    } catch (e) {
      if (sendBTCInvoiceInput.text.length > 2) {
        sendBTCPaymentError.value = 'Invalid invoice'.tr;
      }

      invoiceAmountBTC.value = '0.0';
      invoiceAmountUserCurrency.value = '0.0';
      invoiceDescription.value = '';
      sendPaymentTransactionFee.value = 0;
      sendPaymentSayNodeFee.value = 0;
      loggerService.log('Error getting invoice amount: $e');

      return <String, double>{
        'btc': 0,
        'userCurrency': 0,
      };
    }
  }

  Future<String> getSayNodeFeeInvoice(double feeInSatoshis, int needId) async {
    final String url =
        Uri.https(Constants.apiDomain, '/need/add_invoice/').toString();
    try {
      final http.Response response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          HttpHeaders.authorizationHeader:
              'Bearer ${apiService.authenticationToken}',
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'value': feeInSatoshis,
          'description': 'SayNode fee invoice ::$needId',
        }),
      );
      if (response.statusCode == 200) {
        loggerService.log(response.body);

        return ((jsonDecode(response.body) as Map<String, dynamic>)['result']
                as Map<String, dynamic>)['payment_request']
            .toString();
      } else {
        loggerService.log(
          'Failed to fetch SayNode fee invoice: StatusCode: ${response.statusCode}, ${response.body}',
        );

        return '';
      }
    } catch (e) {
      loggerService.log('Error while fetching SayNode fee invoice: $e');
      rethrow;
    }
  }

  Future<void> waitForTransactionCompletion() async {
    const Duration listeningDuration = Duration(minutes: 1);

    final Timer timer = Timer(listeningDuration, () {
      // Main transaction timed out
      // TODO add popup info that the payment is taking a bit longer
      return;
    });

    while (!mainTransactionWentThrough.value) {
      await Future<void>.delayed(const Duration(seconds: 2));

      if (!timer.isActive) {
        break;
      }
    }

    // finished before timeout
    if (mainTransactionWentThrough.value) {
      timer.cancel();
      return;
    }
  }

  Future<void> sendPaymentWithFee({Need? needForDonationObject}) async {
    bool canStartPayment = false;

    // Create a donation object for the backend
    if (needForDonationObject != null) {
      try {
        final http.Response createDonationResponse =
            await createDonationObject(needForDonationObject);

        if (createDonationResponse.statusCode != 201) {
          // ignore: avoid_dynamic_calls
          if (jsonDecode(createDonationResponse.body)['message'] ==
              'Donation already exists for this need') {
            await PopupManager.donationErrorPopup(
              'Donation already exists for this need'.tr,
            );
            canStartPayment = false;
          } else {
            await PopupManager.donationErrorPopup(
              'Donation could not be created. Please try again later.'.tr,
            );
            canStartPayment = false;
          }
        } else {
          canStartPayment = true;
        }
      } catch (e) {
        await PopupManager.donationErrorPopup(
          'Donation could not be created. Please try again later.'.tr,
        );
        canStartPayment = false;
      }
    } else {
      canStartPayment = true;
    }

    if (canStartPayment) {
      if (Get.context != null) {
        showLoadingDialog(Get.context!);
      }

      // Pay the beneficiary invoice
      mainTransactionWentThrough.value = false;
      final dynamic mainTransactionPaymentResponse =
          await sendBitcoin(preparedSendResponse: preparedMainTransation);

      if (mainTransactionPaymentResponse is SendPaymentResponse) {
        if (mainTransactionPaymentResponse.payment.status ==
                PaymentState.failed ||
            mainTransactionPaymentResponse.payment.status ==
                PaymentState.timedOut) {
          sendBTCPaymentError.value = 'Payment failed. Please try again.'.tr;

          if (Get.context != null) {
            hideLoadingDialog(Get.context!);
          }

          return;
        }
      } else {
        sendBTCPaymentError.value = mainTransactionPaymentResponse.toString();

        if (Get.context != null) {
          hideLoadingDialog(Get.context!);
        }

        return;
      }

      // Currently can't do two transactions simultaneously
      // Therefore we wait for the main transaction
      await waitForTransactionCompletion();

      if (!Constants.devMode) {
        // Pay the SayNode fee
        final dynamic sayNodeFeeTransactionPaymentResponse =
            await sendBitcoin(preparedSendResponse: preparedSayNodeTransaction);

        if (sayNodeFeeTransactionPaymentResponse is SendPaymentResponse) {
          if (sayNodeFeeTransactionPaymentResponse.payment.status ==
                  PaymentState.failed ||
              sayNodeFeeTransactionPaymentResponse.payment.status ==
                  PaymentState.timedOut) {
            sendBTCPaymentError.value = 'Payment failed. Please try again.'.tr;

            if (Get.context != null) {
              hideLoadingDialog(Get.context!);
            }

            return;
          } else {
            Future<void>.delayed(
              const Duration(milliseconds: 1000),
              PopupManager.openContributionPopup,
            );
            await Get.find<WalletService>().getTransactions();
            await Get.find<WalletService>().getBalanceInUserCurrency();

            Get.back<void>();
          }
        } else {
          sendBTCPaymentError.value =
              sayNodeFeeTransactionPaymentResponse.toString();
        }
      } else {
        Future<void>.delayed(
          const Duration(milliseconds: 1000),
          PopupManager.openContributionPopup,
        );
        await Get.find<WalletService>().getTransactions();
        await Get.find<WalletService>().getBalanceInUserCurrency();

        Get.back<void>();
      }

      if (Get.context != null) {
        hideLoadingDialog(Get.context!);
      }
    }
  }

  Future<dynamic> sendBitcoin({
    PrepareSendResponse? preparedSendResponse,
    String? bolt11Invoice,
  }) async {
    try {
      final dynamic paymentResponse = await breezService.sendPayment(
        preparedSendData: preparedSendResponse,
        bolt11Invoice: bolt11Invoice,
      );

      return paymentResponse;
    } catch (e) {
      sendBTCPaymentError.value = 'Insufficient outgoing balance'.tr;
      loggerService.log('Error sending payment: $e');
      return 'Invoice already paid or expired';
    }
  }

  Future<http.Response> createDonationObject(Need need) async {
    final String url =
        Uri.https(Constants.apiDomain, '/donation/create/').toString();

    try {
      final http.Response response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          HttpHeaders.authorizationHeader:
              'Bearer ${apiService.authenticationToken}',
          'Content-Type': 'application/json',
        },
        body: json.encode(<String, Object>{
          'need': need.id.toString(),
          'amount': need.amount, // This can be int or double
        }),
      );

      if (response.statusCode == 201) {
        loggerService.log(
          'Donation object for need with id ${need.id} created successfully',
        );
      } else {
        loggerService.log(
          'Failed to create donation object for need with id ${need.id}. Got status code: ${response.statusCode}, ${response.body}',
        );
      }
      return response;
    } catch (e) {
      loggerService.log(
        'Error creating donation object for need with id ${need.id}: $e',
      );
      throw Exception(
        'Error creating donation object for need with id ${need.id}: $e',
      );
    }
  }
}
