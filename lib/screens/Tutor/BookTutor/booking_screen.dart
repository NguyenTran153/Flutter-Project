import 'package:flutter/material.dart';
import 'package:flutter_project/utils/sized_box.dart';
import 'package:provider/provider.dart';

import '../../../l10n.dart';
import '../../../models/schedule/schedule.dart';
import '../../../providers/language_provider.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({Key? key, required this.schedule}) : super(key: key);

  final Schedule schedule;

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  late Locale currentLocale;

  @override
  void initState() {
    super.initState();
    currentLocale = context.read<LanguageProvider>().currentLocale;
    context.read<LanguageProvider>().addListener(() {
      setState(() {
        currentLocale = context.read<LanguageProvider>().currentLocale;
      });
    });
  }

  String weekdayConverter(int weekday) {
    List<String> weekdayNames = [
      'monday',
      'tuesday',
      'wednesday',
      'thursday',
      'friday',
      'saturday',
      'sunday'
    ];

    if (weekday >= 1 && weekday <= 7) {
      return AppLocalizations(currentLocale)
          .translate(weekdayNames[weekday - 1])!;
    } else {
      return '';
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
          AppLocalizations(currentLocale).translate('bookingDetail')!,
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppLocalizations(currentLocale).translate('bookingTime')!,
                style: Theme.of(context).textTheme.displaySmall),
            subSizedBox,
            Center(
              child: Text(
                '$time\n$weekday $date',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 22,
                    color: Theme.of(context).colorScheme.secondary),
              ),
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
                  final dialogResult = await showBookingResultDialog(context, currentLocale);
                  if (dialogResult) {
                    Navigator.pop(context);
                  }
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
                      AppLocalizations(currentLocale).translate('book')!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20, color: Theme.of(context).primaryColor),
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

Future<bool> showBookingResultDialog(BuildContext context,Locale currentLocale) async {
  return await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(AppLocalizations(currentLocale).translate('success')!),
        content:
            const Text('You can now study with this tutor at booked time.'),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text('OK')),
        ],
      );
    },
  ).then((value) => value ?? false);
}
