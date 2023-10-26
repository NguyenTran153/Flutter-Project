import "package:flutter/material.dart";
import "package:flutter_project/screens/Time/Schedule/scheduleItem/schedule_item.dart";
import "package:flutter_project/utils/colors.dart";

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: primaryColor,
      alignment: Alignment.center,
      child: ListView(
        children: [
          ScheduleItem(),
          ScheduleItem(),
          ScheduleItem(),
          ScheduleItem(),
          ScheduleItem(),
          ScheduleItem(),
          ScheduleItem(),
          ScheduleItem(),
          ScheduleItem(),
        ],
      ),
    );
  }
}
