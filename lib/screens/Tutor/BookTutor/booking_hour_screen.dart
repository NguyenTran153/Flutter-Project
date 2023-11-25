import 'package:flutter/material.dart';
import 'package:flutter_project/screens/Tutor/BookTutor/booking_tutor_widget.dart';
import 'package:intl/intl.dart';

import '../../../models/schedule/schedule.dart';

List<Schedule> generateDummySchedules() {
  return [
    Schedule(
      id: "4",
      tutorId: "101",
      startTime: "03:00 PM",
      endTime: "05:00 PM",
      startTimestamp: DateTime.now().add(Duration(days: 1)).millisecondsSinceEpoch,
      endTimestamp: DateTime.now().add(Duration(days: 1, hours: 2)).millisecondsSinceEpoch,
      createdAt: "2023-11-26",
      isBooked: false,
    ),
    Schedule(
      id: "5",
      tutorId: "202",
      startTime: "10:00 AM",
      endTime: "12:00 PM",
      startTimestamp: DateTime.now().add(Duration(days: 2)).millisecondsSinceEpoch,
      endTimestamp: DateTime.now().add(Duration(days: 2, hours: 2)).millisecondsSinceEpoch,
      createdAt: "2023-11-27",
      isBooked: true,
    ),
    // Add more schedule objects here...
  ];
}

class BookingHourScreen extends StatefulWidget {
  const BookingHourScreen({
    Key? key,
    required this.schedules,
    required this.timestamp,
  }) : super(key: key);

  final List<Schedule> schedules;
  final int timestamp;

  @override
  State<BookingHourScreen> createState() => _BookingHourScreenState();
}

class _BookingHourScreenState extends State<BookingHourScreen> {
  late final List<Schedule> schedules;
  late final int timestamp;

  @override
  void initState() {
    super.initState();
    schedules = generateDummySchedules();
    timestamp = DateTime.now().millisecondsSinceEpoch;
  }

  @override
  Widget build(BuildContext context) {
    final pickedDate = DateTime.fromMillisecondsSinceEpoch(timestamp);

    final validSchedules = schedules.where((schedule) {
      if (schedule.startTimestamp == null) return false;
      if (schedule.isBooked ?? false) return false;

      final date =
          DateTime.fromMillisecondsSinceEpoch(schedule.startTimestamp!);
      if (date.day == pickedDate.day &&
          date.month == pickedDate.month &&
          date.year == pickedDate.year) {
        return true;
      }
      return false;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        leading: BackButton(
          color: Theme.of(context).colorScheme.secondary,
        ),
        title: Text(
          'Choose learning time',
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ),
      body: Column(
        children: [
          Text(
            'On ${DateFormat.yMMMMEEEEd().format(pickedDate)}',
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: GridView.count(
              padding: const EdgeInsets.all(24),
              crossAxisCount: 2,
              mainAxisSpacing: 24,
              crossAxisSpacing: 32,
              childAspectRatio: 3,
              children: List<Widget>.generate(
                8,
                (index) {
                  final start = '03:00';
                  final end = '05:00';

                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                    ),
                    onPressed: (){
                            showDialog(
                              context: context,
                              builder: (context) => BookingTutorWidget(
                                schedule: schedules[0],
                              ),
                            );
                          },
                    child: Text(
                      '$start - $end',
                      style: TextStyle(
                          fontSize: 16, color: Theme.of(context).primaryColor),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

