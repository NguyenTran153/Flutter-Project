import "package:flutter/material.dart";
import "package:flutter_project/screens/Homepage/homepage_screen.dart";
import "package:flutter_project/screens/Setting/setting_screen.dart";
import "package:flutter_project/screens/Tutor/TutorSearch/tutor_search_screen.dart";
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import "package:flutter_project/utils/routes.dart";

import "../Course/course_screen.dart";
import "../Schedule/schedule_screen.dart";

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  List<Widget> pages = [
    const HomepageScreen(),
    const TutorSearchScreen(),
    const ScheduleScreen(),
    const CourseScreen(),
    const SettingScreen(),
  ];
  List<String> pagesTitles = [
    'Home',
    'Tutor',
    'Schedule',
    'Course',
    'Setting'
  ];
  int _chosenPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          pagesTitles[_chosenPageIndex],
          style: Theme.of(context).textTheme.displayMedium,
        ),
        actions: _chosenPageIndex == 0
            ? [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, Routes.userProfile);
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      clipBehavior: Clip.hardEdge,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Image.asset(
                        "public/images/avatar.png",
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.person_rounded),
                      ),
                    ),
                  ),
                )
              ]
            : [],
      ),
      body: pages[_chosenPageIndex],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        color: Theme.of(context).colorScheme.secondary,
        buttonBackgroundColor: Theme.of(context).colorScheme.secondary,
        height: 50,
        onTap: (index) {
          setState(() {
            _chosenPageIndex = index;
          });
        },
        index: _chosenPageIndex,
        items: <Widget>[
          Icon(Icons.home_filled, size: 30, color: Theme.of(context).primaryColor,),
          Icon(Icons.people, size: 30, color: Theme.of(context).primaryColor),
          Icon(Icons.schedule_outlined, size: 30, color: Theme.of(context).primaryColor),
          Icon(Icons.school, size: 30, color: Theme.of(context).primaryColor),
          Icon(Icons.settings, size: 30, color: Theme.of(context).primaryColor),
        ],
      )
    );
  }
}
