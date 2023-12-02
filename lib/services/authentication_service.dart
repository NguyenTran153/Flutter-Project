import 'dart:convert';

import 'package:http/http.dart';

class AuthenticationService {
  static const String _baseUrl = 'https://reqres.in/api';

  static Future<Response> login(String email, String password) async {
    String url = '$_baseUrl/login';
    Map<String, String> headers = {'Content-Type': 'application/json'};
    Map<String, String> body = {'email': email, 'password': password};

    Response response = await post(Uri.parse(url),
        headers: headers, body: jsonEncode(body));

    return response;
  }

  static Future<Response> register(String email, String password) async {
    String url = '$_baseUrl/register';
    Map<String, String> headers = {'Content-Type': 'application/json'};
    Map<String, String> body = {'email': email, 'password': password};

    Response response = await post(Uri.parse(url),
        headers: headers, body: jsonEncode(body));

    return response;
  }

  static Future<Response> forgotPassword(String email) async {
    String url = '$_baseUrl/forgot-password';
    Map<String, String> headers = {'Content-Type': 'application/json'};
    Map<String, String> body = {'email': email};

    Response response = await post(Uri.parse(url),
        headers: headers, body: jsonEncode(body));

    return response;
  }
}