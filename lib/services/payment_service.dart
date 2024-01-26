import 'dart:async';

import 'package:http/http.dart';
import '../envs/environment.dart';

class PaymentService {
  static final _baseUrl = EnvironmentConfig.apiUrl;

  static Future<Response> getPaymentHistory({
    required String token,
  }) async {
    String url = '$_baseUrl/payment/history';
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    Response response = await get(Uri.parse(url), headers: headers);

    return response;
  }

  static Future<Response> getPaymentHistoryByTutorId({
    required String token,
    required String tutorId,
    required int page,
    required int perPage,
  }) async {
    String url = '$_baseUrl/payment/list/tutor/$tutorId?page=$page&perPage=$perPage';
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    Response response = await get(Uri.parse(url), headers: headers);

    return response;
  }

  static Future<Response> getPaymentStatistic({
    required String token,
  }) async {
    String url = '$_baseUrl/payment/statistic';
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    Response response = await get(Uri.parse(url), headers: headers);

    return response;
  }

  static Future<Response> getUserReferralCode({
    required String token,
  }) async {
    String url = '$_baseUrl/payment/referral-code';
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    Response response = await get(Uri.parse(url), headers: headers);

    return response;
  }
}
