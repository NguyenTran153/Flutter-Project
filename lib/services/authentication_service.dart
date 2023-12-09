import 'dart:async';
import 'dart:convert';

import 'package:flutter_project/constants/base_url.dart';
import 'package:http/http.dart';

import '../models/user/token.dart';
import '../models/user/user.dart';

class AuthenticationService {
  static const _baseUrl = baseUrl;

  static Future<void> loginWithEmailAndPassword({
    required String email,
    required String password,
    required Function(User, Token) onSuccess,
  }) async {
    String url = '$_baseUrl/auth/login';
    Map<String, String> headers = {'Content-Type': 'application/json'};
    Map<String, String> body = {'email': email, 'password': password};

    Response response =
        await post(Uri.parse(url), headers: headers, body: jsonEncode(body));

    final jsonDecode = json.decode(response.body);

    if (response.statusCode != 200) {
      throw Exception(jsonDecode['message']);
    }

    final user = User.fromJson(jsonDecode['user']);
    final token = Token.fromJson(jsonDecode['tokens']);
    await onSuccess(user, token);
  }

  static Future<void> registerWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    String url = '$_baseUrl/auth/register';
    Map<String, String> headers = {
      'Content-Type': 'application/json'
    };
    Map<String, String> body = {
      'email': email,
      'password': password,
      'source': 'null'
    };

    Response response =
        await post(Uri.parse(url), headers: headers, body: jsonEncode(body));

    if (response.statusCode != 201) {
      final jsonDecode = json.decode(response.body);
      throw Exception(jsonDecode['message']);
    }
  }

  static Future<Response> forgotPassword(String email) async {
    String url = '$_baseUrl/forgot-password';
    Map<String, String> headers = {'Content-Type': 'application/json'};
    Map<String, String> body = {'email': email};

    Response response =
        await post(Uri.parse(url), headers: headers, body: jsonEncode(body));

    return response;
  }

  static Future<Response> loginByPhoneNumber(String phoneNumber) async {
    String url = '$_baseUrl/auth/phone-login';
    Map<String, String> headers = {'Content-Type': 'application/json'};
    Map<String, String> body = {'phone_number': phoneNumber};

    Response response =
        await post(Uri.parse(url), headers: headers, body: jsonEncode(body));

    return response;
  }

  static Future<void> loginByGoogle({
    required String accessToken,
    required Function(User, Token) onSuccess,
  }) async {
    String url = '$_baseUrl/auth/google';
    Map<String, String> headers = {'Content-Type': 'application/json'};
    Map<String, String> body = {'access_token': accessToken};

    Response response =
        await post(Uri.parse(url), headers: headers, body: jsonEncode(body));

    final jsonDecode = json.decode(response.body);
    if (response.statusCode != 200) {
      throw Exception(jsonDecode['message']);
    }
    final user = User.fromJson(jsonDecode['user']);
    final tokens = Token.fromJson(jsonDecode['tokens']);
    await onSuccess(user, tokens);
  }

  static Future<void> loginByFacebook({
    required String accessToken,
    required Function(User, Token) onSuccess,
  }) async {
    String url = '$_baseUrl/auth/facebook';
    Map<String, String> headers = {'Content-Type': 'application/json'};
    Map<String, String> body = {'access_token': accessToken};

    Response response =
        await post(Uri.parse(url), headers: headers, body: jsonEncode(body));
    final jsonDecode = json.decode(response.body);
    if (response.statusCode != 200) {
      throw Exception(jsonDecode['message']);
    }
    final user = User.fromJson(jsonDecode['user']);
    final tokens = Token.fromJson(jsonDecode['tokens']);
    await onSuccess(user, tokens);
  }

  static Future<Response> refreshToken(String refreshToken) async {
    String url = '$_baseUrl/auth/refresh-token';
    Map<String, String> headers = {'Content-Type': 'application/json'};
    Map<String, String> body = {'refresh_token': refreshToken, 'timezone': '7'};

    Response response =
        await post(Uri.parse(url), headers: headers, body: jsonEncode(body));

    return response;
  }

  static Future<Response> registerByPhoneNumber(
      String phoneNumber, String password) async {
    String url = '$_baseUrl/auth/phone-register';
    Map<String, String> headers = {'Content-Type': 'application/json'};
    Map<String, String> body = {
      'phone': phoneNumber,
      'password': password,
      'source': 'null'
    };

    Response response =
        await post(Uri.parse(url), headers: headers, body: jsonEncode(body));

    return response;
  }

  static Future<Response> resendOtpforRegisterByPhoneNumber(
      String phoneNumber) async {
    String url = '$_baseUrl/verify/phone-auth-verify/create';
    Map<String, String> headers = {'Content-Type': 'application/json'};
    Map<String, String> body = {'phone': phoneNumber};

    Response response =
        await post(Uri.parse(url), headers: headers, body: jsonEncode(body));

    return response;
  }

  static Future<Response> activePhoneNumberWithOTP(
      String phoneNumber, String otp) async {
    String url = '$_baseUrl/verify/phone-auth-verify/activate';
    Map<String, String> headers = {'Content-Type': 'application/json'};
    Map<String, String> body = {'phone': phoneNumber, 'otp': otp};

    Response response =
        await post(Uri.parse(url), headers: headers, body: jsonEncode(body));

    return response;
  }
}
