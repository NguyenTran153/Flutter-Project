import 'dart:convert';
import 'dart:async';

import 'package:http/http.dart';

import '../constants/base_url.dart';
import '../models/schedule/booking_info.dart';

class ScheduleService {
  static const _baseUrl = baseUrl;

  static Future<Map<String, dynamic>> getBookedClasses({
    required String token,
    required int page,
    required int perPage,
  }) async {
    final now = DateTime.now().millisecondsSinceEpoch;

    String url =
        '$_baseUrl/booking/list/student?page=$page&perPage=$perPage&dateTimeGte=$now&orderBy=meeting&sortBy=asc';
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    Response response = await get(Uri.parse(url), headers: headers);

    final jsonDecode = json.decode(response.body);
    if (response.statusCode != 200) {
      throw Exception(
          'Error: Cannot get upcoming classes. ${jsonDecode['message']}');
    }

    final List<dynamic> classes = jsonDecode['data']['rows'];
    return {
      'count': jsonDecode['data']['count'],
      'classes':
          classes.map((schedule) => BookingInfo.fromJson(schedule)).toList(),
    };
  }

  static Future<Map<String, dynamic>> getHistory({
    required String token,
    required int page,
    required int perPage,
  }) async {
    final now = DateTime.now().millisecondsSinceEpoch;

    String url =
        '$_baseUrl/booking/list/student?page=$page&perPage=$perPage&dateTimeLte=$now&orderBy=meeting&sortBy=desc';
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    Response response = await get(Uri.parse(url), headers: headers);

    final jsonDecode = json.decode(response.body);
    if (response.statusCode != 200) {
      throw Exception('Error: Cannot get history. ${jsonDecode['message']}');
    }

    final List<dynamic> classes = jsonDecode['data']['rows'];
    return {
      'count': jsonDecode['data']['count'],
      'classes':
          classes.map((schedule) => BookingInfo.fromJson(schedule)).toList(),
    };
  }

  static Future<String> cancelBookedClass({
    required List<String> scheduleDetailIds,
    required String token,
  }) async {
    String url = '$_baseUrl/booking/cancel';
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    Response response = await delete(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode({
        'scheduleDetailIds': scheduleDetailIds,
      }),
    );

    final jsonDecode = json.decode(response.body);
    if (response.statusCode != 200) {
      throw Exception(
          'Error: Cannot cancel class. ${jsonDecode['message']}');
    }

    return jsonDecode['message'];
  }
}
