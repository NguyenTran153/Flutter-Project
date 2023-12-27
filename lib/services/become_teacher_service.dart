import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

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
    required int price,
    required String token,
  }) async {
    String url = '${_baseUrl}tutor/register';

    // Create FormData
    FormData formData = FormData.fromMap({
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
      'avatar': await MultipartFile.fromFile(avatar?.path ?? '', filename: 'avatar.jpg'),
      'video': await MultipartFile.fromFile(video?.path ?? '', filename: 'video.mp4'),
    });

    // Create Dio instance
    Dio dio = Dio();

    // Set headers
    dio.options.headers = {
      'Authorization': 'Bearer $token',
      'content-type': 'multipart/form-data',
      'Accept': '/',
    };

    try {
      // Send request
      Response response = await dio.put(url, data: formData);

      final jsonDecode = json.decode(response.toString());

      if (response.statusCode != 200) {
        throw Exception(jsonDecode['message']);
      }
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }
}
