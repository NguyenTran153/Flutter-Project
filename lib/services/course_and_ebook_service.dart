import 'dart:async';
import 'dart:convert';

import 'package:flutter_project/constants/base_url.dart';
import 'package:http/http.dart';

class CourseService {
  Future<void> getListCourse({
    required Function(List) onSuccess,
  }) async {
    String url = '$baseUrl/course';
    Map<String, String> headers = {'Content-Type': 'application/json'};

    Response response = await get(Uri.parse(url), headers: headers);

    final jsonDecode = json.decode(response.body);

    if (response.statusCode != 200) {
      throw Exception(jsonDecode['message']);
    }

    final listCourse = jsonDecode['data'];
    await onSuccess(listCourse);
  }

  Future<void> getCourseDetailById({
    required String id,
    required Function(Map) onSuccess,
  }) async {
    String url = '$baseUrl/course/$id';
    Map<String, String> headers = {'Content-Type': 'application/json'};

    Response response = await get(Uri.parse(url), headers: headers);

    final jsonDecode = json.decode(response.body);

    if (response.statusCode != 200) {
      throw Exception(jsonDecode['message']);
    }

    final courseDetail = jsonDecode['data'];
    await onSuccess(courseDetail);
  }
}