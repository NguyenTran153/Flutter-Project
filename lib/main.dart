import 'package:flutter/material.dart';
import 'package:flutter_project/screens/Auth/forget_password.dart';
import 'package:flutter_project/screens/Auth/login.dart';
import 'package:flutter_project/screens/Auth/register.dart';
import 'package:flutter_project/screens/Course/course_screen.dart';
import 'package:flutter_project/screens/Time/History/history_screen.dart';
import 'package:flutter_project/screens/Tutor/tutorDetail/tutor_detail_screen.dart';
import 'package:flutter_project/screens/VideoCall/video_call_screen.dart';
import 'package:flutter_project/screens/Navigation/navigation_screen.dart';
import 'package:flutter_project/utils/colors.dart';
import 'package:flutter_project/utils/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LetTutor',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
        useMaterial3: true,
      ),
      home: const CourseListScreen(),
      routes: {
        Routes.login: (context) => const LoginScreen(),
        Routes.register: (context) => const RegisterScreen(),
        Routes.forgotPassword: (context) => const ForgotPasswordScreen(),
        Routes.main: (context) => const NavigationScreen(),
        Routes.teacherDetail: (context) => const TutorDetailScreen(),
      },
    );
  }
}
