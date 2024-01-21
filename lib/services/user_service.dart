import 'dart:convert';
import 'dart:async';
import 'dart:io';

import 'package:http/http.dart';

import '../envs/environment.dart';
import '../models/user/learn_topic.dart';
import '../models/user/test_preparation.dart';
import '../models/user/user.dart';

class UserService {
  static final _baseUrl = EnvironmentConfig.apiUrl;

  static Future<Response> changePassword(
      {required String token,
      required String oldPassword,
      required String newPassword}) async {
    String url = '$_baseUrl/auth/change-password';
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    Map<String, String> body = {
      'password': oldPassword,
      'newPassword': newPassword
    };

    Response response =
        await post(Uri.parse(url), headers: headers, body: jsonEncode(body));
    final jsonDecode = json.decode(response.body);

    if (response.statusCode != 200) {
      throw Exception(jsonDecode['message']);
    }

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
      'learnTopics': learnTopics,
      'testPreparations': testPreparations,
      'studySchedule': studySchedule,
    };

    Response response =
        await put(Uri.parse(url), headers: headers, body: jsonEncode(body));

    final jsonDecode = json.decode(response.body);
    if (response.statusCode != 200) {
      throw Exception(json.decode(response.body)['message']);
    }
    return User.fromJson(jsonDecode['user']);
  }

  static Future<User?> updateAvatar({
    required String token,
    required File avatar,
  }) async {
    String url = '$_baseUrl/user/uploadAvatar';
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
      'Accept': '/',
      'Content-Type': 'multipart/form-data',
    };

    try {
      var request = MultipartRequest('POST', Uri.parse(url));
      request.headers.addAll(headers);

      String filename = avatar.path.split('/').last;

      var bytes = await avatar.readAsBytes();
      String? base64Image = base64Encode(bytes);

      // Use MultipartFile to attach the image
      request.files.add(MultipartFile(
        'avatar',
        ByteStream.fromBytes(base64Decode(base64Image)),
        bytes.length,
        filename: filename, // You can set the desired filename here
      ));

      var response = await request.send();

      if (response.statusCode == 200) {
        // Handle the response if needed
        var jsonResponse = await response.stream.bytesToString();
        var jsonDecode = json.decode(jsonResponse);
        return User.fromJson(jsonDecode['user']);
      } else {
        throw Exception(
            'Failed to upload avatar. Status code: ${response.statusCode}');
      }
    } catch (e) {
      return null; // or handle the error appropriately
    }
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
