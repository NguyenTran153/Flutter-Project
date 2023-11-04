import "package:flutter/material.dart";
import "package:flutter_project/screens/Homepage/homepage_screen.dart";
import "package:flutter_project/screens/Setting/setting_screen.dart";
import "package:flutter_project/screens/Time/time_screen.dart";
import "package:flutter_project/screens/Tutor/TutorSearch/tutor_search_screen.dart";
import "package:flutter_project/utils/colors.dart";

import "../Course/course_screen.dart";

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  List<Widget> pages = [
    const HomepageScreen(),
    const TutorSearchScreen(),
    const TimeScreen(),
    const CourseScreen(),
    const SettingScreen(),
  ];
  List<String> pagesTitles = [
    'Home',
    'Tutor',
    'Time',
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
        backgroundColor: primaryColor,
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
                    onTap: () {},
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
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 14,
        unselectedFontSize: 12,
        type: BottomNavigationBarType.fixed,
        onTap: (value) {
          setState(() {
            _chosenPageIndex = value;
          });
        },
        elevation: 20,
        currentIndex: _chosenPageIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Tutor'),
          BottomNavigationBarItem(
              icon: Icon(Icons.schedule_outlined), label: 'Time'),
          BottomNavigationBarItem(icon: Icon(Icons.school), label: 'Course'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Setting'),
        ],
      ),
    );
  }
}
