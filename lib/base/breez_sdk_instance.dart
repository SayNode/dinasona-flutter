import 'dart:async';

//import 'package:breez_liquid/breez_liquid.dart';
import 'package:flutter_breez_liquid/flutter_breez_liquid.dart' as liquid_sdk;
import 'package:rxdart/rxdart.dart';

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
      _initializeEventsStream(_instance!);
      _subscribeToSdkStreams(_instance!);
      await _fetchWalletData(_instance!);
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

  Future<void> _fetchWalletData(liquid_sdk.BindingLiquidSdk sdk) async {
    await _getInfo(sdk);
    await _listPayments(sdk: sdk);
  }

  Future<liquid_sdk.GetInfoResponse> _getInfo(
    liquid_sdk.BindingLiquidSdk sdk,
  ) async {
    final liquid_sdk.GetInfoResponse walletInfo = await sdk.getInfo();
    _walletInfoController.add(walletInfo);
    return walletInfo;
  }

  Future<String> createInvoice({
    required String description,
    required int amountInSatoshi,
  }) async {
    // Fetch the Receive lightning limits
    final liquid_sdk.LightningPaymentLimitsResponse currentLightningLimits =
        await _instance!.fetchLightningLimits();
    print('test Minimum amount: ${currentLightningLimits.receive.minSat} sats');
    print('test Maximum amount: ${currentLightningLimits.receive.maxSat} sats');

    // Create an invoice and set the invoice amount
    final liquid_sdk.PrepareReceiveResponse prepareResponse =
        await _instance!.prepareReceivePayment(
      req: liquid_sdk.PrepareReceiveRequest(
        paymentMethod: liquid_sdk.PaymentMethod.lightning,
        payerAmountSat: BigInt.from(amountInSatoshi),
      ),
    );

    // If the fees are acceptable, continue to create the Receive Payment
    final BigInt receiveFeesSat = prepareResponse.feesSat;
    print("test Fees: $receiveFeesSat sats");

    final liquid_sdk.ReceivePaymentRequest receivePaymentRequest =
        liquid_sdk.ReceivePaymentRequest(
      description: description,
      prepareResponse: prepareResponse,
    );

    final liquid_sdk.ReceivePaymentResponse invoice =
        await _instance!.receivePayment(req: receivePaymentRequest);

    print('test: bolt11 ${invoice.destination}');

    return invoice.destination;
  }

  Future<List<liquid_sdk.Payment>> _listPayments({
    required liquid_sdk.BindingLiquidSdk sdk,
  }) async {
    const liquid_sdk.ListPaymentsRequest req = liquid_sdk.ListPaymentsRequest();
    final List<liquid_sdk.Payment> paymentsList =
        await sdk.listPayments(req: req);
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

  void _initializeEventsStream(liquid_sdk.BindingLiquidSdk sdk) {
    _breezEventsStream ??= sdk.addEventListener().asBroadcastStream();
  }

  /// Subscribes to SDK's event & log streams.
  void _subscribeToSdkStreams(liquid_sdk.BindingLiquidSdk sdk) {
    _subscribeToEventsStream(sdk);
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
  void _subscribeToEventsStream(liquid_sdk.BindingLiquidSdk sdk) {
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
        await _fetchWalletData(sdk);
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
