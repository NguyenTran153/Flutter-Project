import 'dart:convert';
import 'dart:async';
import 'dart:io';

import 'package:http/http.dart';

import '../constants/base_url.dart';

class BecomeTeacherService {
  static const _baseUrl = baseUrl;

  static Future<Response> becomeTeacher({
    required String name,
    required String country,
    required String birthday,
    required String interests,
    required String education,
    required String experience,
    required String profession,
    required String languages,
    required String bio,
    required String targetStudents,
    required String specialties,
    File? avatar,
    File? video,
    required String price,
    required String token,
  }) async {
    String url = '${_baseUrl}tutor/register';
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
    };
    Map<String, String> body = {
      'name': name,
      'country': country,
      'birthday': birthday,
      'interests': interests,
      'education': education,
      'experience': experience,
      'profession': profession,
      'languages': languages,
      'bio': bio,
      'targetStudents': targetStudents,
      'specialties': specialties,
      'price': price,
    };
    Response response =
        await put(Uri.parse(url), headers: headers, body: jsonEncode(body));
    final jsonDecode = json.decode(response.body);

    if (response.statusCode != 200) {
      throw Exception(jsonDecode['message']);
    }

    return response;
  }
}
