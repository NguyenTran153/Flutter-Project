import 'dart:async';
import 'dart:convert';

import 'package:flutter_project/constants/base_url.dart';
import 'package:http/http.dart';

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

  Future<void> searchTutor() async {
    String url = 'https://reqres.in/api/users?page=2';
    Map<String, String> headers = {'Content-Type': 'application/json'};

    Response response = await get(Uri.parse(url), headers: headers);

    final jsonDecode = json.decode(response.body);

    if (response.statusCode != 200) {
      throw Exception(jsonDecode['message']);
    }
  }

  Future<void> addTutorToFavoriteList() async {
    String url = 'https://reqres.in/api/users?page=2';
    Map<String, String> headers = {'Content-Type': 'application/json'};

    Response response = await get(Uri.parse(url), headers: headers);

    final jsonDecode = json.decode(response.body);

    if (response.statusCode != 200) {
      throw Exception(jsonDecode['message']);
    }
  }
}