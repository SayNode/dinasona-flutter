import 'dart:async';

//import 'package:breez_liquid/breez_liquid.dart';
import 'package:flutter_breez_liquid/flutter_breez_liquid.dart' as liquid_sdk;
import 'package:rxdart/rxdart.dart';

import 'breez_base_service.dart';

class BreezSDKLiquid {
  factory BreezSDKLiquid() => _singleton;

  BreezSDKLiquid._internal() {
    initializeLogStream();
  }
  static final BreezSDKLiquid _singleton = BreezSDKLiquid._internal();

  liquid_sdk.BindingLiquidSdk? _instance;

  liquid_sdk.BindingLiquidSdk? get instance => _instance;

  Future<void> connect({
    required liquid_sdk.ConnectRequest req,
  }) async {
    try {
      _instance = await liquid_sdk.connect(req: req);
      _initializeEventsStream();
      _subscribeToSdkStreams();
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
    _unsubscribeFromSdkStreams();
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

  Future<dynamic> sendPayment({required String bolt11}) async {
    try {
      final liquid_sdk.PrepareSendResponse prepareSendResponse =
          await _instance!.prepareSendPayment(
        req: liquid_sdk.PrepareSendRequest(destination: bolt11),
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

  StreamSubscription<liquid_sdk.LogEntry>? _breezLogSubscription;

  Stream<liquid_sdk.LogEntry>? _breezLogStream;

  /// Initializes SDK log stream.
  ///
  /// Call once on your Dart entrypoint file, e.g.; `lib/main.dart`.
  void initializeLogStream() {
    _breezLogStream ??= liquid_sdk.breezLogStream().asBroadcastStream();
  }

  StreamSubscription<liquid_sdk.SdkEvent>? _breezEventsSubscription;

  Stream<liquid_sdk.SdkEvent>? _breezEventsStream;

  void _initializeEventsStream() {
    _breezEventsStream ??= _instance!.addEventListener().asBroadcastStream();
  }

  /// Subscribes to SDK's event & log streams.
  void _subscribeToSdkStreams() {
    _subscribeToEventsStream();
    _subscribeToLogStream();
  }

  final StreamController<liquid_sdk.GetInfoResponse> _walletInfoController =
      BehaviorSubject<liquid_sdk.GetInfoResponse>();

  Stream<liquid_sdk.GetInfoResponse> get walletInfoStream =>
      _walletInfoController.stream;

  final StreamController<liquid_sdk.Payment> _paymentResultStream =
      // ignore: always_specify_types
      StreamController.broadcast();

  final StreamController<List<liquid_sdk.Payment>> _paymentsController =
      BehaviorSubject<List<liquid_sdk.Payment>>();

  Stream<List<liquid_sdk.Payment>> get paymentsStream =>
      _paymentsController.stream;

  Stream<liquid_sdk.Payment> get paymentResultStream =>
      _paymentResultStream.stream;

  /* TODO: Liquid - Log statements are added for debugging purposes, should be removed after early development stage is complete & events are behaving as expected.*/
  /// Subscribes to SdkEvent's stream
  void _subscribeToEventsStream() {
    _breezEventsSubscription = _breezEventsStream?.listen(
      (liquid_sdk.SdkEvent event) async {
        if (event is liquid_sdk.SdkEvent_PaymentFailed) {
          _logStreamController.add(
            liquid_sdk.LogEntry(
              line: 'Payment Failed. ${event.details.destination}',
              level: 'WARN',
            ),
          );
          _paymentResultStream.addError(PaymentException(event.details));
        }
        if (event is liquid_sdk.SdkEvent_PaymentPending) {
          _logStreamController.add(
            liquid_sdk.LogEntry(
              line: 'Payment Pending. ${event.details.destination}',
              level: 'INFO',
            ),
          );
          _paymentResultStream.add(event.details);
        }
        if (event is liquid_sdk.SdkEvent_PaymentRefunded) {
          _logStreamController.add(
            liquid_sdk.LogEntry(
              line: 'Payment Refunded. ${event.details.destination}',
              level: 'INFO',
            ),
          );
          _paymentResultStream.add(event.details);
        }
        if (event is liquid_sdk.SdkEvent_PaymentRefundPending) {
          _logStreamController.add(
            liquid_sdk.LogEntry(
              line: 'Pending Payment Refund. ${event.details.destination}',
              level: 'INFO',
            ),
          );
          _paymentResultStream.add(event.details);
        }
        if (event is liquid_sdk.SdkEvent_PaymentSucceeded) {
          _logStreamController.add(
            liquid_sdk.LogEntry(
              line: 'Payment Succeeded. ${event.details.destination}',
              level: 'INFO',
            ),
          );
          _paymentResultStream.add(event.details);
        }
        if (event is liquid_sdk.SdkEvent_PaymentWaitingConfirmation) {
          _logStreamController.add(
            liquid_sdk.LogEntry(
              line:
                  'Payment Waiting Confirmation. ${event.details.destination}',
              level: 'INFO',
            ),
          );
          _paymentResultStream.add(event.details);
        }
        if (event is liquid_sdk.SdkEvent_Synced) {
          _logStreamController.add(
            const liquid_sdk.LogEntry(
              line: 'Received Synced event.',
              level: 'INFO',
            ),
          );
        }
        await _fetchWalletData();
      },
    );
  }

  final StreamController<liquid_sdk.LogEntry> _logStreamController =
      StreamController<liquid_sdk.LogEntry>.broadcast();

  Stream<liquid_sdk.LogEntry> get logStream => _logStreamController.stream;

  /// Subscribes to SDK's logs stream
  void _subscribeToLogStream() {
    // ignore: unnecessary_lambdas
    _breezLogSubscription = _breezLogStream?.listen(
      // ignore: unnecessary_lambdas
      (liquid_sdk.LogEntry logEntry) {
        _logStreamController.add(logEntry);
      },
      // ignore: always_specify_types
      onError: (e) {
        _logStreamController.addError(e as Object);
      },
    );
  }

  /// Unsubscribes from SDK's event & log streams.
  void _unsubscribeFromSdkStreams() {
    _breezEventsSubscription?.cancel();
    _breezLogSubscription?.cancel();
  }
}
