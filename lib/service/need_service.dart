import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../model/need.dart';
import 'api_service.dart';
import 'logger_service.dart';

class NeedService extends GetxService {
  APIService apiService = Get.find<APIService>();

  Future<List<Need>> getPublishedNeeds() async {
    try {
      Get.find<LoggerService>()
          .log('NeedService.getPublishedNeeds() called...');

      final http.Response response = await apiService.get(
        '/need',
      );
      if (response.statusCode == 200) {
        final List<Map<String, dynamic>> needList =
            List<Map<String, dynamic>>.from(
          jsonDecode(utf8.decode(response.bodyBytes)) as List<dynamic>,
        );
        Get.find<LoggerService>().log(
          'NeedService.getPublishedNeeds() - got ${needList.length} needs',
        );
        return needList.map(Need.fromJson).toList();
      } else {
        throw Exception(
          'Failed to load needs - got status code ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Failed to load needs - an exception occurred: $e');
    }
  }

  Future<List<Need>> getDonatehistory() async {
    try {
      final http.Response response = await apiService.get('/donation/donor');

      if (response.statusCode == 200) {
        final List<Map<String, dynamic>> needList =
            List<Map<String, dynamic>>.from(
          jsonDecode(utf8.decode(response.bodyBytes)) as List<dynamic>,
        );
        Get.find<LoggerService>().log(
          'NeedService.getDonatehistory() - got ${needList.length} needs',
        );
        return needList.map(Need.fromJson).toList();
      } else {
        throw Exception(
          'Failed to load donate needs - got status code ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception(
        'Failed to load donate needs - an exception occurred: $e',
      );
    }
  }

  String _getAreasOfInterestStringArray(List<AreaOfInterest> areas) {
    return areas
        .map((AreaOfInterest area) => (area.index + 1).toString())
        .join(',');
  }

  Future<List<Need>> getPublishedNeedsMatchingAreasOfInterest(
    List<AreaOfInterest> areas,
  ) async {
    try {
      Get.find<LoggerService>().log(
        'NeedService.getPublishedNeedsMatchingAreasOfInterest() called...',
      );

      const String url = 'need/filter/';

      final http.Response response = await apiService.get(
        url,
        queryParameters: <String, dynamic>{
          'areas_of_interest': _getAreasOfInterestStringArray(areas),
        },
      );
      if (response.statusCode == 200) {
        final List<Map<String, dynamic>> needList =
            List<Map<String, dynamic>>.from(
          jsonDecode(utf8.decode(response.bodyBytes)) as List<dynamic>,
        );
        Get.find<LoggerService>().log(
          'NeedService.getPublishedNeedsMatchingAreasOfInterest() - got ${needList.length} needs',
        );
        return needList.map(Need.fromJson).toList();
      } else {
        throw Exception(
          'Failed to load needs - got status code ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Failed to load needs - an exception occurred: $e');
    }
  }

  Future<Map<String, int>> getAmoutOfNeeds() async {
    try {
      Get.find<LoggerService>().log(
        'NeedService.getAmoutOfNeeds() called...',
      );

      const String url = '/need/total/amount';

      final http.Response response = await apiService.get(
        url,
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> needList = Map<String, dynamic>.from(
          jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>,
        );
        Get.find<LoggerService>().log(
          'NeedService.getAmoutOfNeeds() - got ${needList.length} needs',
        );
        final Map<String, int> needs =
            Map<String, int>.from(needList['result'] as Map<String, dynamic>);
        return needs;
      } else {
        throw Exception(
          'Failed to load needs - got status code ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Failed to load needs - an exception occurred: $e');
    }
  }

  Future<Need> createNewNeed(
    String title,
    String description,
    String amount,
    String status,
    List<int> areaOfInterest,
  ) async {
    try {
      Get.find<LoggerService>().log(
        'NeedService.createNewNeed() called...',
      );

      const String url = '/need/create';

      final http.Response response = await apiService.post(
        url,
        body: <String, dynamic>{
          'title': title,
          'description': description,
          'amount': amount,
          'status': status,
          'area_of_interest': areaOfInterest,
        },
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> need = Map<String, dynamic>.from(
          jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>,
        );
        Get.find<LoggerService>().log(
          'NeedService.createNewNeed() - created new need',
        );
        return Need.fromJson(need);
      } else {
        throw Exception(
          'Failed to create new need - got status code ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Failed to create new need - an exception occurred: $e');
    }
  }
}
