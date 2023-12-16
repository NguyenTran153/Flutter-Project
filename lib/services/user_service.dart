import 'dart:convert';
import 'dart:async';

import 'package:http/http.dart';

import '../constants/base_url.dart';
import '../models/user/learn_topic.dart';
import '../models/user/test_preparation.dart';
import '../models/user/user.dart';

class UserService {
  static const _baseUrl = baseUrl;

  static Future<Response> changePassword(
      String oldPassword, String newPassword) async {
    String url = 'https://reqres.in/api/change-password';
    Map<String, String> headers = {'Content-Type': 'application/json'};
    Map<String, String> body = {
      'old_password': oldPassword,
      'new_password': newPassword
    };

    Response response =
        await post(Uri.parse(url), headers: headers, body: jsonEncode(body));

    return response;
  }

  static Future<User?> getUserInformation(String token) async {
    String url = '$_baseUrl/user/info';
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    Response response = await get(Uri.parse(url), headers: headers);

    final jsonDecode = json.decode(response.body);
    if (response.statusCode != 200) {
      return null;
    } else {
      return User.fromJson(jsonDecode['user']);
    }
  }

  static Future<User?> updateUserInformation({
    required String token,
    required String name,
    required String country,
    required String birthday,
    required String level,
    required List<String> learnTopics,
    required List<String> testPreparations,
    required String studySchedule,
  }) async {
    String url = '$_baseUrl/user/info';
    Map<String, String> headers = {
      'Content-Type': 'application/json;encoding=utf-8',
      'Authorization': 'Bearer $token',
    };
    Map<String, dynamic> body = {
      'name': name,
      'country': country,
      'birthday': birthday,
      'level': level,
      'learn_topics': learnTopics,
      'test_preparations': testPreparations,
      'study_schedule': studySchedule,
    };

    Response response =
        await put(Uri.parse(url), headers: headers, body: jsonEncode(body));

    final jsonDecode = json.decode(response.body);
    if (response.statusCode != 200) {
      return null;
    }
    return User.fromJson(jsonDecode['user']);
  }

  static Future<List<LearnTopic>> getLearningTopic(String token) async {
    final response = await get(
      Uri.parse('$_baseUrl/learn-topic'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    final jsonDecode = json.decode(response.body) as List;
    if (response.statusCode != 200) {
      throw Exception(json.decode(response.body)['message']);
    }
    return jsonDecode.map((e) => LearnTopic.fromJson(e)).toList();
  }

  static Future<List<TestPreparation>> getTestPreparation(String token) async {
    final response = await get(
      Uri.parse('$_baseUrl/test-preparation'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    final jsonDecode = json.decode(response.body) as List;
    if (response.statusCode != 200) {
      throw Exception(json.decode(response.body)['message']);
    }
    return jsonDecode.map((e) => TestPreparation.fromJson(e)).toList();
  }
}
