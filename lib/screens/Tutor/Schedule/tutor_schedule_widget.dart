import 'package:flutter/material.dart';
import 'package:flutter_project/screens/Tutor/BookTutor/booking_hour_screen.dart';
import 'package:intl/intl.dart';

import '../../../models/schedule/schedule.dart';

class TutorScheduleWidget extends StatefulWidget {
  const TutorScheduleWidget({Key? key}) : super(key: key);

  @override
  State<TutorScheduleWidget> createState() => _TutorScheduleWidgetState();
}

class _TutorScheduleWidgetState extends State<TutorScheduleWidget> {
  List<Schedule> schedules = [];
  List<int> scheduleStartTimestamps = [];

  void _getTutorSchedule() {
    List<Schedule> result = getSchedules();

    // Remove all learning dates before today
    result = result.where((schedule) {
      if (schedule.startTimestamp == null) return false;

      final now = DateTime.now();
      final start =
          DateTime.fromMillisecondsSinceEpoch(schedule.startTimestamp!);

      // bool isTheSameDate = now.day == start.day && now.month == start.month && now.year == start.year;
      return start.isAfter(DateTime.now());
    }).toList();

    // Sort learning DateTime increasingly
    result.sort((s1, s2) {
      if (s1.startTimestamp == null || s2.startTimestamp == null) {
        return 0;
      }
      return s1.startTimestamp!.compareTo(s2.startTimestamp!);
    });

    final timestamps =
        schedules.map((schedule) => schedule.startTimestamp ?? 0).toList();
    for (var timestamp in timestamps) {
      bool isExisted = false;
      if (!scheduleStartTimestamps.any((element) {
        final date1 = DateTime.fromMillisecondsSinceEpoch(timestamp);
        final date2 = DateTime.fromMillisecondsSinceEpoch(element);

        bool isTheSameDate = date1.day == date2.day &&
            date1.month == date2.month &&
            date1.year == date2.year;
        if (isTheSameDate) {
          return true;
        }
        return false;
      })) {
        scheduleStartTimestamps.add(timestamp);
      }
    }
    scheduleStartTimestamps.sort();

    setState(() {
      schedules = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    _getTutorSchedule();
    return SafeArea(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.75,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16, bottom: 0),
              child: Text(
                'Choose Learning Date',
                style: Theme.of(context).textTheme.displaySmall,
              ),
            ),
            Expanded(
              child: GridView.count(
                padding: const EdgeInsets.all(24),
                crossAxisCount: 2,
                mainAxisSpacing: 24,
                crossAxisSpacing: 32,
                childAspectRatio: 3,
                children: List<Widget>.generate(
                  5,
                  (index) => ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                    ),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return BookingHourScreen(
                            schedules: schedules,
                            timestamp: 5,
                          );
                        },
                      ));
                    },
                    child: Text(
                      DateFormat.MMMEd().format(
                          DateTime.fromMillisecondsSinceEpoch(
                              5)),
                      style: TextStyle(
                          fontSize: 16, color: Theme.of(context).primaryColor),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
