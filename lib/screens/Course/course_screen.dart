import 'package:flutter/material.dart';
import 'package:flutter_project/screens/Course/course_search_screen.dart';
import 'package:flutter_project/utils/sized_box.dart';

class CourseScreen extends StatefulWidget {
  const CourseScreen({super.key});

  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: CourseSearchScreen(),
    );
  }
}
