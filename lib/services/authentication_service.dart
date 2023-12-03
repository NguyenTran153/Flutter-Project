import 'dart:async';
import 'dart:convert';

import 'package:flutter_project/constants/base_url.dart';
import 'package:http/http.dart';

class AuthenticationService {
  static const _baseUrl = baseUrl;

  static Future<Response> login(String email, String password) async {
    String url = '$_baseUrl//auth/login';
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

  static Future<Response> loginByPhoneNumber(String phoneNumber) async {
    String url = '$_baseUrl/login-by-phone-number';
    Map<String, String> headers = {'Content-Type': 'application/json'};
    Map<String, String> body = {'phone_number': phoneNumber};

    Response response = await post(Uri.parse(url),
        headers: headers, body: jsonEncode(body));

    return response;
  }

  static Future<Response> loginByGoogle(String googleToken) async {
    String url = '$_baseUrl/login-by-google';
    Map<String, String> headers = {'Content-Type': 'application/json'};
    Map<String, String> body = {'google_token': googleToken};

    Response response = await post(Uri.parse(url),
        headers: headers, body: jsonEncode(body));

    return response;
  }

  static Future<Response> loginByFacebook(String facebookToken) async {
    String url = '$_baseUrl/login-by-facebook';
    Map<String, String> headers = {'Content-Type': 'application/json'};
    Map<String, String> body = {'facebook_token': facebookToken};

    Response response = await post(Uri.parse(url),
        headers: headers, body: jsonEncode(body));

    return response;
  }

  static Future<Response> refreshToken(String refreshToken) async {
    String url = '$_baseUrl/refresh-token';
    Map<String, String> headers = {'Content-Type': 'application/json'};
    Map<String, String> body = {'refresh_token': refreshToken};

    Response response = await post(Uri.parse(url),
        headers: headers, body: jsonEncode(body));

    return response;
  }

  static Future<Response> registerByPhoneNumber(
      String phoneNumber, String password) async {
    String url = '$_baseUrl/register-by-phone-number';
    Map<String, String> headers = {'Content-Type': 'application/json'};
    Map<String, String> body = {
      'phone_number': phoneNumber,
      'password': password
    };

    Response response = await post(Uri.parse(url),
        headers: headers, body: jsonEncode(body));

    return response;
  }

  static Future<Response> resendOTPforRegisterByPhoneNumber(
      String phoneNumber) async {
    String url = '$_baseUrl/resend-otp-for-register-by-phone-number';
    Map<String, String> headers = {'Content-Type': 'application/json'};
    Map<String, String> body = {'phone_number': phoneNumber};

    Response response = await post(Uri.parse(url),
        headers: headers, body: jsonEncode(body));

    return response;
  }

  static Future<Response> ActiveAccountByPhoneNumber(
      String phoneNumber, String otp) async {
    String url = '$_baseUrl/active-account-by-phone-number';
    Map<String, String> headers = {'Content-Type': 'application/json'};
    Map<String, String> body = {'phone_number': phoneNumber, 'otp': otp};

    Response response = await post(Uri.parse(url),
        headers: headers, body: jsonEncode(body));

    return response;
  }
}