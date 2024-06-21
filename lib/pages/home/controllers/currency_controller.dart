import 'package:get/get.dart';

class CurrencyController extends GetxController {
  RxString chosenCurrency = ''.obs;
  final List<Map<String, String>> currency = <Map<String, String>>[
    <String, String>{
      'name': 'Swiss Frank',
      'code': 'CHF',
      'image': 'assets/images/switzerland.png',
    },
    <String, String>{
      'name': 'Australian Dollar',
      'code': 'AUD',
      'image': 'assets/images/australia.png',
    },
    <String, String>{
      'name': 'British Pound',
      'code': 'GBP',
      'image': 'assets/images/great_britain.png',
    },
    <String, String>{
      'name': 'Canadian Dollar',
      'code': 'CAD',
      'image': 'assets/images/canada.png',
    }
  ];
}
