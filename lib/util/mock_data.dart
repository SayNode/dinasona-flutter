import '../model/currency_model.dart';

class MockData {
  static List<CurrencyModel> currency = <CurrencyModel>[
    CurrencyModel(
      imageUrl: 'assets/images/switzerland.png',
      name: 'Swiss Frank',
      code: 'CHF',
    ),
    CurrencyModel(
      imageUrl: 'assets/images/australia.png',
      name: 'Australian Dollar',
      code: 'AUD',
    ),
    CurrencyModel(
      imageUrl: 'assets/images/great_britain.png',
      name: 'British Pound',
      code: 'GBP',
    ),
    CurrencyModel(
      imageUrl: 'assets/images/canada.png',
      name: 'Canadian Dollar',
      code: 'CAD',
    ),
  ];
}
