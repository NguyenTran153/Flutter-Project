import 'package:flutter/material.dart';
import 'package:flutter_project/screens/Schedule/UpcomingClass/upcoming_class_screen.dart';
import 'package:flutter_project/utils/sized_box.dart';

import 'History/history_screen.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            TabBar(
              tabs: [
                Tab(
                  icon: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.timer_outlined,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      subSizedBox,
                      Text(
                        'Upcoming',
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
                        Icons.history_outlined,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'History',
                        style: TextStyle(color: Theme.of(context).colorScheme.secondary),
                      )
                    ],
                  ),
                ),
              ],
            ),
            const Expanded(
              child: TabBarView(
                children: [
                  UpcomingClassScreen(),
                  HistoryScreen(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
