import 'package:flutter/material.dart';
import 'package:flutter_project/screens/History/history_screen.dart';
import 'package:flutter_project/screens/Homepage/homepage.dart';
import 'package:flutter_project/utils/colors.dart';

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
      home: HomepageScreen(),
    );
  }
}



