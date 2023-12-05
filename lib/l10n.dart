import 'dart:async';
import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static final Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'hello_world': 'Hello World',
      'errorLogin': 'Email or password is incorrect',
      'emptyField': 'These fields are required',
    },
    'vi': {
      'hello_world': 'Xin chào thế giới',
      'errorLogin': 'Email hoặc mật khẩu không đúng',
      'emptyField': 'Thông tin bị trống',
    },
  };

  String? get helloWorld {
    return _localizedValues[locale.languageCode]?['hello_world'];
  }

  String? translate(String key) {
    return _localizedValues[locale.languageCode]?[key];
  }

// Thêm các phương thức dịch cho các chuỗi khác nếu cần
}

class AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'vi'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
