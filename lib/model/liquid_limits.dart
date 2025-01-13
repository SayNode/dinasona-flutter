class LiquidLimitsUserCurrency {
  LiquidLimitsUserCurrency({
    required this.send,
    required this.receive,
  });

  final LiquidLimitUserCurrency send;
  final LiquidLimitUserCurrency receive;
}

class LiquidLimitUserCurrency {
  LiquidLimitUserCurrency({
    required this.minUserCurrency,
    required this.maxUserCurrency,
  });

  final double minUserCurrency;
  final double maxUserCurrency;
}
