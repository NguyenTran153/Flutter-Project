import 'dart:convert';
import 'dart:async';

import 'package:http/http.dart';

import '../constants/base_url.dart';
import '../models/user/learn_topic.dart';
import '../models/user/test_preparation.dart';

class UserService {
  static const _baseUrl = baseUrl;

  static Future<Response> changePassword(String oldPassword, String newPassword) async {
    String url = 'https://reqres.in/api/change-password';
    Map<String, String> headers = {'Content-Type': 'application/json'};
    Map<String, String> body = {'old_password': oldPassword, 'new_password': newPassword};

    Response response = await post(Uri.parse(url),
        headers: headers, body: jsonEncode(body));

    return response;
  }

  static Future<Response> getInformation() async {
    String url = 'https://reqres.in/api/get-information';
    Map<String, String> headers = {'Content-Type': 'application/json'};

    Response response = await get(Uri.parse(url), headers: headers);

    return response;
  }

  static Future<Response> updateInformation(String name, String phoneNumber, String address) async {
    String url = 'https://reqres.in/api/update-information';
    Map<String, String> headers = {'Content-Type': 'application/json'};
    Map<String, String> body = {'name': name, 'phone_number': phoneNumber, 'address': address};

    Response response = await post(Uri.parse(url),
        headers: headers, body: jsonEncode(body));

    return response;
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