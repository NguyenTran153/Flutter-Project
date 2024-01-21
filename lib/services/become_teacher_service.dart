import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

import '../envs/environment.dart';

class BecomeTeacherService {
  static final _baseUrl = EnvironmentConfig.apiUrl;

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
    String url = '$_baseUrl/tutor/register';

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
      'avatar': avatar != null ? await MultipartFile.fromFile(avatar.path, filename: 'avatar.jpg') : null,
      'video': video != null ? await MultipartFile.fromFile(video.path, filename: 'video.mp4') : null,
    });

    formData.fields.removeWhere((element) => element.value == null);

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
      print(e);
      throw Exception(e);
    }
  }
}
