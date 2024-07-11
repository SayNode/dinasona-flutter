import 'dart:convert';

import 'package:get/get.dart';

import '../model/need.dart';
import 'api_service.dart';
import 'logger_service.dart';
import 'package:http/http.dart' as http;

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
        print(response.body);
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
}
