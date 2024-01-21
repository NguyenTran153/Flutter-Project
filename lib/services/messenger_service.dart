import 'dart:async';
import 'dart:convert';

import 'package:flutter_project/models/messenger/message.dart';
import 'package:http/http.dart';

import '../envs/environment.dart';

class MessengerService {
  static final _baseUrl = EnvironmentConfig.apiUrl;

  static Future<MessageData> loadMessages({
    required String token,
    required String userId,
    required int page,
    required int perPage,
    required int startTime,
  }) async {
    String url =
        '$_baseUrl/message/get/$userId?page=$page&perPage=$perPage&startTime=$startTime';

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    Response response = await get(Uri.parse(url), headers: headers);
    final jsonDecode = json.decode(response.body);
    if (response.statusCode != 200) {
      throw Exception(jsonDecode['message']);
    }

    final List<dynamic> messages = jsonDecode['rows'];
    return MessageData.fromJson({
      'count': jsonDecode['count'],
      'rows': messages,
    });
  }
}
