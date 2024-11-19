import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../model/beneficiary.dart';
import '../../../model/need.dart';
import '../../../service/api_service.dart';
import '../../../util/mock_data.dart';

enum NeedTab {
  all,
  ongoing,
  past;

  String get title {
    switch (this) {
      case NeedTab.all:
        return 'All';
      case NeedTab.ongoing:
        return 'Ongoing';
      case NeedTab.past:
        return 'Past';
    }
  }
}

class BeneficiaryPageController extends GetxController {
  BeneficiaryPageController({required this.beneficiary});

  final Beneficiary beneficiary;
  RxList<Need> needs = <Need>[].obs;

  Rx<NeedTab> selectedTab = NeedTab.all.obs;

  @override
  void onInit() {
    needs.value = MockData.needs;
    super.onInit();
  }

  Future<List<Need>> getNeedsForUser() async {
    try {
      final APIService apiService = Get.find<APIService>();
      final http.Response response = await apiService.get(
        '/need/beneficiary/${beneficiary.userId}/',
      );
      if (response.statusCode == 200) {
        final List<Map<String, dynamic>> needList =
            List<Map<String, dynamic>>.from(
          jsonDecode(utf8.decode(response.bodyBytes)) as List<dynamic>,
        );
        return needList.map(Need.fromJson).toList();
      } else {
        throw Exception(
          'Failed to load needs for user - got status code ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Failed to load needs - an exception occurred: $e');
    }
  }
}
