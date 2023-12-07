import 'dart:async';
import 'dart:convert';

import 'package:flutter_project/constants/base_url.dart';
import 'package:http/http.dart';

import '../models/tutor/tutor.dart';

class TutorService {
  Future<void> getListTutor() async {
    String url = 'https://reqres.in/api/users?page=2';
    Map<String, String> headers = {'Content-Type': 'application/json'};

    Response response = await get(Uri.parse(url), headers: headers);

    final jsonDecode = json.decode(response.body);

    if (response.statusCode != 200) {
      throw Exception(jsonDecode['message']);
    }
  }

  Future<void> writeReviewForTutor() async {
    String url = 'https://reqres.in/api/users?page=2';
    Map<String, String> headers = {'Content-Type': 'application/json'};

    Response response = await get(Uri.parse(url), headers: headers);

    final jsonDecode = json.decode(response.body);

    if (response.statusCode != 200) {
      throw Exception(jsonDecode['message']);
    }
  }

  Future<void> getTutorInformationById() async {
    String url = 'https://reqres.in/api/users?page=2';
    Map<String, String> headers = {'Content-Type': 'application/json'};

    Response response = await get(Uri.parse(url), headers: headers);

    final jsonDecode = json.decode(response.body);

    if (response.statusCode != 200) {
      throw Exception(jsonDecode['message']);
    }
  }

  static Future<Map<String, dynamic>> searchTutor({
    required String token,
    String search = '',
    required int page,
    required int perPage,
    required Map<String, bool> nationality,
    required List<String> specialties,
  }) async {
    final response = await post(
      Uri.parse('$baseUrl/tutor/search'),
      headers: {
        'Content-Type': 'application/json;encoding=utf-8',
        'Authorization': 'Bearer $token',
      },
      body: json.encode({
        'page': page,
        'perPage': perPage,
        'search': search,
        'filters': {
          'specialties': specialties,
          'nationality': nationality,
        },
      }),
    );

    final jsonDecode = json.decode(response.body);

    if (response.statusCode != 200) {
      throw Exception(jsonDecode['message']);
    }

    final List<dynamic> tutors = jsonDecode['rows'];

    return {
      'count': jsonDecode['count'],
      'tutors': tutors.map((tutor) => Tutor.fromJson(tutor)).toList(),
    };
  }

  static Future<void> addTutorToFavorite({
    required String token,
    required String userId,
  }) async {
    final response = await post(
      Uri.parse('$baseUrl/user/manageFavoriteTutor'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode(
        {
          'tutorId': userId,
        },
      ),
    );

    final jsonDecode = json.decode(response.body);
    if (response.statusCode != 200) {
      throw Exception(jsonDecode['message']);
    }
  }

  static Future<void> reportTutor({
    required String token,
    required String userId,
    required String content,
  }) async {
    final response = await post(
      Uri.parse('$baseUrl/report'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode(
        {
          'tutorId': userId,
          'content': content,
        },
      ),
    );

    final jsonDecode = json.decode(response.body);
    if (response.statusCode != 200) {
      throw Exception(jsonDecode(['message']));
    }
  }
}