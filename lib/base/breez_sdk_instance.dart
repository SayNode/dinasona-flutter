import 'dart:async';

//import 'package:breez_liquid/breez_liquid.dart';
import 'package:flutter_breez_liquid/flutter_breez_liquid.dart' as liquid_sdk;
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

import '../pages/wallet/controllers/send_payment_controller.dart';
import '../service/logger_service.dart';
import 'breez_base_service.dart';

class BreezSDKLiquid {
  factory BreezSDKLiquid() => _singleton;

  BreezSDKLiquid._internal() {
    //initializeLogStream();
  }
  static final BreezSDKLiquid _singleton = BreezSDKLiquid._internal();

  liquid_sdk.BindingLiquidSdk? _instance;

  liquid_sdk.BindingLiquidSdk? get instance => _instance;

  Future<void> connect({
    required liquid_sdk.ConnectRequest req,
  }) async {
    try {
      _instance = await liquid_sdk.connect(req: req);

      //_initializeEventsStream();
      //_subscribeToSdkStreams();

      if (!eventStreamInitialized) {
        initializeEventsStream();
        Get.find<LoggerService>().log('Event stream initialized');
        eventStreamInitialized = true;
      }

      // TODO remove in production in the future
      subscribeToEventStream();
      await _fetchWalletData();
    } catch (e) {
      _instance = null;
      rethrow;
    }
  }

  void disconnect() {
    if (_instance == null) {
      throw Exception();
    }

    _instance!.disconnect();
    //_unsubscribeFromSdkStreams();
    unsubscribeFromEventStream();
    _instance = null;
  }

  Future<void> _fetchWalletData() async {
    await _getInfo();
    await listPayments();
  }

  Future<liquid_sdk.GetInfoResponse> _getInfo() async {
    final liquid_sdk.GetInfoResponse walletInfo = await _instance!.getInfo();
    _walletInfoController.add(walletInfo);
    return walletInfo;
  }

  // TODO Liquid Julien
  Future<dynamic> prepareReceivingTransaction({
    required int amountInSatoshi,
    required String description,
  }) async {
    /* final liquid_sdk.LightningPaymentLimitsResponse currentLightningLimits =
        await _instance!.fetchLightningLimits(); */

    //print('test Minimum amount: ${currentLightningLimits.receive.minSat} sats');
    //print('test Maximum amount: ${currentLightningLimits.receive.maxSat} sats');

    /* final liquid_sdk.PrepareReceiveResponse prepareResponse =
        await _instance!.prepareReceivePayment(
      req: liquid_sdk.PrepareReceiveRequest(
        paymentMethod: liquid_sdk.PaymentMethod.lightning,
        payerAmountSat: BigInt.from(amountInSatoshi),
      ),
    ); */

    //final BigInt receiveFeesSat = prepareResponse.feesSat;
  }

  Future<String> createInvoice({
    required String description,
    required int amountInSatoshi,
  }) async {
    try {
      // Create an invoice and set the invoice amount
      final liquid_sdk.PrepareReceiveResponse prepareResponse =
          await _instance!.prepareReceivePayment(
        req: liquid_sdk.PrepareReceiveRequest(
          paymentMethod: liquid_sdk.PaymentMethod.lightning,
          payerAmountSat: BigInt.from(amountInSatoshi),
        ),
      );

      final liquid_sdk.ReceivePaymentRequest receivePaymentRequest =
          liquid_sdk.ReceivePaymentRequest(
        description: description,
        prepareResponse: prepareResponse,
      );

      final liquid_sdk.ReceivePaymentResponse invoice =
          await _instance!.receivePayment(req: receivePaymentRequest);

      return invoice.destination;
    } catch (e) {
      // ignore: only_throw_errors
      throw 'Error creating invoice: $e';
    }
  }

  // Prepare sending a transaction
  // Get prepareSendResponse object back to check fees before proceeding with the payment
  Future<liquid_sdk.PrepareSendResponse> prepareSendingTransaction(
    String bolt11Invoice,
  ) async {
    final liquid_sdk.PrepareSendResponse prepareSendResponse =
        await _instance!.prepareSendPayment(
      req: liquid_sdk.PrepareSendRequest(
        destination: bolt11Invoice,
      ),
    );

    return prepareSendResponse;
  }

  // Either send a payment using the preparedSendData object or the bolt11 invoice
  // Using bolt11 directly will try to pay the invoice without checking fees
  Future<dynamic> sendPayment({
    liquid_sdk.PrepareSendResponse? preparedSendData,
    String? bolt11,
  }) async {
    try {
      if (preparedSendData == null && bolt11 == null) {
        throw Exception(
          'BreezService -- Error sending payment: Missing either preparedSendData or bolt11 involice parameters',
        );
      }

      final liquid_sdk.PrepareSendResponse prepareSendResponse =
          preparedSendData ??
              await _instance!.prepareSendPayment(
                req: liquid_sdk.PrepareSendRequest(destination: bolt11!),
              );

      final liquid_sdk.SendPaymentResponse sendPaymentResponse =
          await _instance!.sendPayment(
        req:
            liquid_sdk.SendPaymentRequest(prepareResponse: prepareSendResponse),
      );

      return sendPaymentResponse;
    } catch (e) {
      if (e.toString().replaceAll(RegExp(r'FrbAnyhowException\(|\)'), '') ==
          'Invoice already paid') {
        return 'Invoice already paid';
      }
      throw Exception('BreezService -- Error sending payment: $e');
    }
  }

  Future<int> getBalanceInSatoshis() async {
    final liquid_sdk.GetInfoResponse walletInfo = await _instance!.getInfo();
    final BigInt balanceSat = walletInfo.balanceSat;
    //final BigInt pendingSendSat = walletInfo.pendingSendSat;
    //final BigInt pendingReceiveSat = walletInfo.pendingReceiveSat;

    return balanceSat.toInt();
  }

  Future<List<liquid_sdk.Payment>> getPaymentHistory() async {
    try {
      final List<liquid_sdk.Payment> paymentsList = await listPayments();
      return paymentsList;
    } catch (e) {
      throw Exception('BreezService -- Error getting payment history: $e');
    }
  }

  Future<List<liquid_sdk.Payment>> listPayments() async {
    const liquid_sdk.ListPaymentsRequest req = liquid_sdk.ListPaymentsRequest();
    final List<liquid_sdk.Payment> paymentsList =
        await _instance!.listPayments(req: req);
    _paymentsController.add(paymentsList);

    return paymentsList;
  }

  final StreamController<liquid_sdk.GetInfoResponse> _walletInfoController =
      BehaviorSubject<liquid_sdk.GetInfoResponse>();

  Stream<liquid_sdk.GetInfoResponse> get walletInfoStream =>
      _walletInfoController.stream;

  final StreamController<liquid_sdk.Payment> _paymentResultStream =
      StreamController<liquid_sdk.Payment>.broadcast();

  final StreamController<List<liquid_sdk.Payment>> _paymentsController =
      BehaviorSubject<List<liquid_sdk.Payment>>();

  Stream<List<liquid_sdk.Payment>> get paymentsStream =>
      _paymentsController.stream;

  Stream<liquid_sdk.Payment> get paymentResultStream =>
      _paymentResultStream.stream;

  StreamSubscription<liquid_sdk.SdkEvent>? _breezEventSubscription;
  Stream<liquid_sdk.SdkEvent>? _breezEventStream;

  bool eventStreamInitialized = false;

  void initializeEventsStream() {
    _breezEventStream ??= _instance!.addEventListener().asBroadcastStream();
  }

  final StreamController<liquid_sdk.SdkEvent> _eventStreamController =
      StreamController<liquid_sdk.SdkEvent>.broadcast();
  Stream<liquid_sdk.SdkEvent> get eventStream => _eventStreamController.stream;

  void subscribeToEventStream() {
    final LoggerService loggerService = Get.find<LoggerService>();
    const String streamPrintPrefix = 'BREEZ_SDK_EVENT_STREAM: ';
    _breezEventSubscription = _breezEventStream?.listen(
      (liquid_sdk.SdkEvent event) async {
        if (event is liquid_sdk.SdkEvent_PaymentFailed) {
          _eventStreamController.add(
            event,
          );
          loggerService.log(
            '$streamPrintPrefix Payment Failed. ${event.details.destination}',
          );
          _paymentResultStream.addError(PaymentException(event.details));
          try {
            Get.find<SendPaymentController>().mainTransactionWentThrough.value =
                true;
          } catch (_) {}
        }
        if (event is liquid_sdk.SdkEvent_PaymentPending) {
          _eventStreamController.add(
            event,
          );
          loggerService.log(
            '$streamPrintPrefix Payment pending. ${event.details.destination}',
          );
          _paymentResultStream.add(event.details);
          try {
            Get.find<SendPaymentController>().mainTransactionWentThrough.value =
                false;
          } catch (_) {}
        }
        if (event is liquid_sdk.SdkEvent_PaymentRefunded) {
          _eventStreamController.add(
            event,
          );
          loggerService.log(
            '$streamPrintPrefix Payment refunded. ${event.details.destination}',
          );
          _paymentResultStream.add(event.details);
        }
        if (event is liquid_sdk.SdkEvent_PaymentRefundPending) {
          _eventStreamController.add(
            event,
          );
          loggerService.log(
            '$streamPrintPrefix Pending payment refund. ${event.details.destination}',
          );
        }
        if (event is liquid_sdk.SdkEvent_PaymentSucceeded) {
          _eventStreamController.add(
            event,
          );
          loggerService.log(
            '$streamPrintPrefix Payment succeeded. ${event.details.destination}',
          );
          try {
            Get.find<SendPaymentController>().mainTransactionWentThrough.value =
                true;
          } catch (_) {}
        }
        if (event is liquid_sdk.SdkEvent_PaymentWaitingConfirmation) {
          _eventStreamController.add(
            event,
          );
          loggerService.log(
            '$streamPrintPrefix Payment waiting confirmation. ${event.details.destination}',
          );
        }
        if (event is liquid_sdk.SdkEvent_Synced) {
          _eventStreamController.add(
            event,
          );
          loggerService.log(
            '$streamPrintPrefix Synchronized',
          );
        }
        await _fetchWalletData();
      },
    );
  }

  void unsubscribeFromEventStream() {
    _breezEventSubscription?.cancel();
  }
}
