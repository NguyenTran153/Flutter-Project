import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';

import '../envs/environment.dart';
import '../models/course/course.dart';

class CourseService {
  static final _baseUrl = EnvironmentConfig.apiUrl;

  static Future<Map<String, dynamic>> getListCourseWithPagination({
    required String token,
    required int page,
    required int size,
    required String search,
  }) async {
    String url =
        '$_baseUrl/course?page=$page&size=$size${search.isNotEmpty ? '&q=$search' : ''}';
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    Response response = await get(Uri.parse(url), headers: headers);

    final jsonDecode = json.decode(response.body);

    if (response.statusCode != 200) {
      throw Exception(jsonDecode['message']);
    }

    final List<dynamic> courses = jsonDecode['data']['rows'];
    return {
      'count': jsonDecode['data']['count'],
      'courses': courses.map((e) => Course.fromJson(e)).toList(),
    };
  }

  static Future<Course> getCourseDetailById(
      {required String token, required String courseId}) async {
    String url = '$_baseUrl/course/$courseId';
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    Response response = await get(Uri.parse(url), headers: headers);

    final jsonDecode = json.decode(response.body);

    if (response.statusCode != 200) {
      throw Exception(jsonDecode['message']);
    }

    return Course.fromJson(jsonDecode['data']);
  }
}
