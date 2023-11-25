import 'package:flutter/material.dart';
import 'package:flutter_project/utils/sized_box.dart';

import '../../../models/schedule/schedule.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({Key? key, required this.schedule}) : super(key: key);

  final Schedule schedule;

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {

  String weekdayConverter(int weekday) {
    List<String> weekdayNames = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];

    if (weekday >= 1 && weekday <= 7) {
      return weekdayNames[weekday - 1];
    } else {
      return 'Invalid weekday';
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)!.settings.arguments as Map;
    final String time = data['selectedHour'];
    final String date = data['selectedDate'].toString().substring(0, 11);
    final String weekday = weekdayConverter(data['weekday']);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        leading: BackButton(
          color: Theme.of(context).colorScheme.secondary,
        ),
        title: Text(
          'Booking Details',
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Booking Time', style: Theme.of(context).textTheme.displaySmall),
            subSizedBox,
            Center(
              child: Text(
                '$time\n$weekday $date',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22, color: Theme.of(context).colorScheme.secondary),
              ),
            ),
            sizedBox,
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Balance',
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                ),
                Text(
                  'You have 1 lesson left',
                  style: TextStyle(fontSize: 17, color: Theme.of(context).colorScheme.secondary),
                ),
              ],
            ),
            sizedBox,
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Price',
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                ),
                Text(
                  '1 lesson',
                  style: TextStyle(fontSize: 17, color: Theme.of(context).colorScheme.secondary),
                ),
              ],
            ),
            sizedBox,
            Text('Notes', style: Theme.of(context).textTheme.displaySmall),
            sizedBox,
            TextField(
              minLines: 3,
              maxLines: 5,
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(12),
                  border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10))),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 48),
              child: TextButton(
                style: TextButton.styleFrom(
                  minimumSize: const Size.fromHeight(40),
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                ),
                onPressed: () async {
                    Navigator.pop(context);
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.keyboard_double_arrow_right_rounded,
                      color: Theme.of(context).primaryColor,
                      size: 32,
                    ),
                    Text(
                      'BOOK',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20, color: Theme.of(context).primaryColor),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
