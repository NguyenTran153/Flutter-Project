import 'dart:convert';
import 'dart:async';

import 'package:http/http.dart';

class BecomeTeacherService {
  Future<Response> becomeTeacher(String name, String phoneNumber, String address, String description, String experience, String education, String certificate, String language, String subject, String price, String time) async {
    String url = 'https://reqres.in/api/become-teacher';
    Map<String, String> headers = {'Content-Type': 'application/json'};
    Map<String, String> body = {'name': name, 'phone_number': phoneNumber, 'address': address, 'description': description, 'experience': experience, 'education': education, 'certificate': certificate, 'language': language, 'subject': subject, 'price': price, 'time': time};

    Response response = await post(Uri.parse(url),
        headers: headers, body: jsonEncode(body));

    return response;
  }
}