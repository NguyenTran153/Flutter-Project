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
    return DefaultTabController(
        length: 2,
        child: Column(
          children: [
            TabBar(tabs: [
              Tab(
                icon: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.school_outlined,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    subSizedBox,
                    Text(
                      'All Courses',
                      style: TextStyle(color: Theme.of(context).colorScheme.secondary),
                    )
                  ],
                ),
              ),
              Tab(
                icon: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.book_online_outlined,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'E-Books',
                      style: TextStyle(color: Theme.of(context).colorScheme.secondary),
                    )
                  ],
                ),
              ),
            ]),
            Expanded(
              child: TabBarView(children: [
                // Here goes the first tab
                CourseSearchScreen(),
                // Here goes the second tab
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(right: 24),
                          hintStyle: TextStyle(color: Theme.of(context).colorScheme.tertiary),
                          hintText: 'search e-books',
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Theme.of(context).colorScheme.tertiary, width: 2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
            )
          ],
        ));
  }
}
