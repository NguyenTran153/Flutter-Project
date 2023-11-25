import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../models/schedule/schedule.dart';
import '../../../utils/sized_box.dart';

class BookingTutorWidget extends StatefulWidget {
  const BookingTutorWidget({Key? key, required this.schedule}) : super(key: key);

  final Schedule schedule;

  @override
  State<BookingTutorWidget> createState() => _BookingTutorWidgetState();
}

class _BookingTutorWidgetState extends State<BookingTutorWidget> {
  final _controller = TextEditingController();

  late final String start;
  late final String end;
  late final String date;

  @override
  void initState() {
    super.initState();
    start = widget.schedule.startTime ?? '??:??';
    end = widget.schedule.endTime ?? '??:??';
    date = DateFormat.yMMMMEEEEd()
        .format(DateTime.fromMillisecondsSinceEpoch(widget.schedule.startTimestamp!));
  }
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Book This Tutor'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Booking time',
            style: Theme.of(context).textTheme.displaySmall,
          ),
          subSizedBox,
          Text(
            '  $start - $end',
            style: const TextStyle(fontSize: 16),
          ),
          Text(
            '  $date',
            style: const TextStyle(fontSize: 16),
          ),
          sizedBox,
          Text(
            'Note',
            style: Theme.of(context).textTheme.displaySmall,
          ),
          subSizedBox,
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: TextField(
              controller: _controller,
              minLines: 3,
              maxLines: 4,
              decoration: const InputDecoration(
                hintText: 'Your requests for the tutor',
                hintStyle: TextStyle(fontWeight: FontWeight.w300, color: Colors.grey),
                contentPadding: EdgeInsets.all(12),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.all(Radius.circular(16))),
              ),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              'CANCEL',
              style: TextStyle(color: Colors.red),
            )),
        TextButton(
            onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
            },
            child: const Text('BOOK')),
      ],
    );
  }
}
