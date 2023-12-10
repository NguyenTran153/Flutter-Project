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
      'notValidEmail': 'Email is not valid',
      'passwordTooShort': 'Password is too short',
      'passwordNotMatch': 'Password does not match',
      'registerCompleted': 'Register completed',
      'registerError': 'Register error',
      'enterEmail': 'Enter your email',
      'enterPassword': 'Enter your password',
      'register': 'Register',
      'recommendTutor': 'Recommended Tutors',
      'null': 'null',
      'unknownCountry': 'Unknown country',
      'book': 'Book',
      'findTutor': 'Find tutors',
      'searchByName': 'Search by name',
      'nationality': 'Nationality',
      'all': 'All',
      'vietnamese': 'Vietnamese',
      'foreign': 'Foreign',
      'specialties': 'Specialties',
      'search': 'Search',
      'resetFilter': 'Reset filter',
      'result': 'Result',
      'noMatchesFound': 'No matches found',
      'perPage': 'Per page',
      'bookedClasses': 'Booked classes',
      'history': 'History',
      'noBookedClasses': 'You have no booked classes',
      'cancel': 'Cancel',
      'requestForLesson': 'Request for lesson',
      'cancelSuccess': 'Cancel success',
      'cancel': 'Cancel',
      'areYouSure': 'Are you sure?',
      'goToMeeting': 'Go to meeting',
    },
    'vi': {
      'hello_world': 'Xin chào thế giới',
      'errorLogin': 'Email hoặc mật khẩu không đúng',
      'emptyField': 'Thông tin bị trống',
      'notValidEmail': 'Email không hợp lệ',
      'passwordTooShort': 'Mật khẩu quá ngắn',
      'passwordNotMatch': 'Mật khẩu không khớp',
      'registerCompleted': 'Đăng ký thành công',
      'registerError': 'Đăng ký thất bại',
      'enterEmail': 'Nhập email của bạn',
      'enterPassword': 'Nhập mật khẩu của bạn',
      'register': 'Đăng ký',
      'recommendTutor': 'Giảng viên được đề xuất',
      'null': 'trống',
      'unknownCountry': 'Quốc gia không xác định',
      'book': 'Đặt lịch',
      'findTutor': 'Tìm kiếm giảng viên',
      'searchByName': 'Tìm kiếm theo tên',
      'nationality': 'Quốc tịch',
      'all': 'Tất cả',
      'vietnamese': 'Việt Nam',
      'foreign': 'Nước ngoài',
      'specialties': 'Chuyên môn',
      'search': 'Tìm kiếm',
      'resetFilter': 'Đặt lại bộ lọc',
      'result': 'Kết quả',
      'noMatchesFound': 'Không tìm thấy kết quả',
      'perPage': 'Số lượng mỗi trang',
      'bookedClasses': 'Lịch học',
      'history': 'Lịch sử',
      'noBookedClasses': 'Bạn chưa có lịch học',
      'cancel': 'Hủy lớp',
      'requestForLesson': 'Yêu cầu lớp học',
      'cancelSuccess': 'Hủy lớp thành công',
      'cancel': 'Hủy lớp',
      'areYouSure': 'Bạn có chắc chắn?',
      'goToMeeting': 'Đi đến lớp học',
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
