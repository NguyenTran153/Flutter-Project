import 'package:flutter/material.dart';
import 'package:flutter_project/screens/UserProfile/become_tutor_screen.dart';
import 'package:flutter_project/screens/UserProfile/user_profile_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_project/screens/Auth/forget_password.dart';
import 'package:flutter_project/screens/Auth/login.dart';
import 'package:flutter_project/screens/Auth/register.dart';
import 'package:flutter_project/screens/Course/CourseDetail/course_detail_screen.dart';
import 'package:flutter_project/screens/Course/course_screen.dart';
import 'package:flutter_project/screens/Time/History/history_screen.dart';
import 'package:flutter_project/screens/Tutor/TutorSearch/tutor_result_screen.dart';
import 'package:flutter_project/screens/Tutor/tutorDetail/tutor_detail_screen.dart';
import 'package:flutter_project/screens/VideoCall/video_call_screen.dart';
import 'package:flutter_project/screens/Navigation/navigation_screen.dart';
import 'package:flutter_project/utils/routes.dart';
import 'package:flutter_project/providers/theme_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
        child: Consumer<ThemeProvider>(
          builder: (ctx, themeProvider, _) => MaterialApp(
            title: 'LetTutor',
            theme:
                themeProvider.mode == ThemeMode.light ? lightTheme : darkTheme,
            home: const BecomeTutorScreen(),
            routes: {
              Routes.login: (context) => const LoginScreen(),
              Routes.register: (context) => const RegisterScreen(),
              Routes.forgotPassword: (context) => const ForgotPasswordScreen(),
              Routes.main: (context) => const NavigationScreen(),
              Routes.teacherDetail: (context) => const TutorDetailScreen(),
              Routes.courseDetail: (context) => const CourseDetailScreen(),
              Routes.tutorSearchResult: (context) => const TutorResultScreen(),
              Routes.userProfile: (context) => const UserProfileScreen(),
            },
          ),
        ));
  }
}
