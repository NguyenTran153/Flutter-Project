import 'dart:async';
import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static final Map<String, Map<String, String>> _localizedValues = {
    'en': {
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
      'tutor': 'Tutor',
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
      'noRequestForLesson': 'You have no request for lesson',
      'cancelSuccess': 'Cancel success',
      'cancel': 'Cancel',
      'areYouSure': 'Are you sure?',
      'goToMeeting': 'Go to meeting',
      'youHaveBookedClasses': 'You have booked {count} classes',
      'noReview': 'No review',
      'report': 'Report',
      'reportSuccess': 'Report success',
      'review': 'Review',
      'course': 'Courses',
      'overview': 'Overview',
      'whyTakeThisCourse': 'Why take this course?',
      'takeThisCourseForWhat': 'Take this course for what?',
      'whatWillYouAbleToDo': 'What will you able to do?',
      'lean': 'Learn',
      'level': 'Level',
      'experienceLevel': 'Experience level',
      'courseLevel': 'Course level',
      'courseLength': 'Course length',
      'topics': 'Topics',
      'topicList': 'Topic list',
      'youHaveNoCourse': 'You have no course',
      'favorite': 'Favorite',
      'noVideo': 'No video',
      'language': 'Language',
      'unknown': 'Unknown',
      'interests': 'Interests',
      'chooseDate': 'Choose learning date',
      'chooseTime': 'Choose learning time',
      'monday': 'Monday',
      'tuesday': 'Tuesday',
      'wednesday': 'Wednesday',
      'thursday': 'Thursday',
      'friday': 'Friday',
      'saturday': 'Saturday',
      'sunday': 'Sunday',
      'bookingDetail': 'Booking detail',
      'bookingTime': 'Booking time',
      'description': 'Description',
      'rating': 'Rating',
      'success': 'Success',
      'reviewSent': 'Review was sent',
      'send': 'Send',
      'becomeTutor': 'Become a tutor',
      'information': 'Information',
      'name': 'Name',
      'profile': 'Profile',
      'phone': 'Phone Number'

    },
    'vi': {
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
      'tutor': 'Giảng viên',
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
      'noRequestForLesson': 'Bạn chưa có yêu cầu lớp học',
      'cancelSuccess': 'Hủy lớp thành công',
      'cancel': 'Hủy lớp',
      'areYouSure': 'Bạn có chắc chắn?',
      'goToMeeting': 'Đi đến lớp học',
      'youHaveBookedClasses': 'Bạn đã đặt {count} lớp học',
      'noReview': 'Chưa có đánh giá',
      'report': 'Báo cáo',
      'reportSuccess': 'Báo cáo thành công',
      'review': 'Đánh giá',
      'course': 'Khóa học',
      'overview': 'Tổng quan',
      'whyTakeThisCourse': 'Tại sao nên học khóa học này?',
      'takeThisCourseForWhat': 'Học khóa học này để làm gì?',
      'whatWillYouAbleToDo': 'Bạn sẽ có thể làm được gì?',
      'learn': 'Học',
      'level': 'Cấp bậc',
      'experienceLevel': 'Cấp bậc kinh nghiệm',
      'courseLevel': 'Cấp độ khóa học',
      'courseLength': 'Thời lượng khóa học',
      'topics': 'Chủ đề',
      'topicList': 'Danh sách chủ đề',
      'youHaveNoCourse': 'Bạn chưa có khóa học',
      'favorite': 'Yêu thích',
      'noVideo': 'Không có video',
      'language': 'Ngôn ngữ',
      'unknown': 'Không xác định',
      'interests': 'Sở thích',
      'chooseDate': 'Chọn ngày học',
      'chooseTime': 'Chọn thời gian học',
      'monday': 'Thứ Hai',
      'tuesday': 'Thứ Ba',
      'wednesday': 'Thứ Tư',
      'thursday': 'Thứ Năm',
      'friday': 'Thứ Sáu',
      'saturday': 'Thứ Bảy',
      'sunday': 'Chủ Nhật',
      'bookingDetail': 'Chi tiết lịch học',
      'bookingTime': 'Thời gian học',
      'description': 'Mô tả',
      'rating': 'Đánh giá',
      'success': 'Thành công',
      'reviewSent': 'Đánh giá đã được gửi',
      'send': 'Gửi',
      'becomeTutor': 'Trở thành giảng viên',
      'information': 'Thông tin',
      'name': 'Tên',
      'profile': 'Profile',
      'phone': 'Số điện thoại'
    },
  };

  String? translate(String key, [List<String?>? params]) {
    String? translation = _localizedValues[locale.languageCode]?[key];

    if (params != null) {
      for (int i = 0; i < params.length; i++) {
        translation = translation?.replaceFirst('{count}', params[i] ?? '');
      }
    }

    return translation;
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
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
