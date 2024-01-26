import 'package:flutter/material.dart';
import 'package:flutter_project/screens/Tutor/BookTutor/booking_dialogue.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../l10n/l10n.dart';
import '../../../models/schedule/schedule.dart';
import '../../../providers/language_provider.dart';

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

  late Locale currentLocale;

  @override
  void initState() {
    super.initState();
    schedules = widget.schedules;
    timestamp = widget.timestamp;

    currentLocale = context.read<LanguageProvider>().currentLocale;
    context.read<LanguageProvider>().addListener(() {
      setState(() {
        currentLocale = context.read<LanguageProvider>().currentLocale;
      });
    });
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
          AppLocalizations(currentLocale).translate('chooseTime')!,
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ),
      body: Column(
        children: [
          Text(
            DateFormat.yMMMMEEEEd().format(pickedDate),
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
                validSchedules.length,
                (index) {
                  final start = DateFormat.Hm().format(DateTime.fromMillisecondsSinceEpoch(
                      validSchedules[index].startTimestamp ?? 0));
                  final end = DateFormat.Hm().format(DateTime.fromMillisecondsSinceEpoch(
                      validSchedules[index].endTimestamp ?? 0));

                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                    ),
                    onPressed: validSchedules[index].isBooked as bool
                        ? null
                        : () async {
                      await showDialog(
                        context: context,
                        builder: (context) => BookingDialogueWidget(
                          schedule: validSchedules[index],
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



