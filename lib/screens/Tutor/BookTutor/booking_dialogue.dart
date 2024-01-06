import 'package:flutter/material.dart';
import 'package:flutter_project/services/schedule_service.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../l10n/l10n.dart';
import '../../../models/schedule/schedule.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/language_provider.dart';
import '../../../utils/sized_box.dart';

class BookingDialogueWidget extends StatefulWidget {
  const BookingDialogueWidget({Key? key, required this.schedule}) : super(key: key);

  final Schedule schedule;

  @override
  State<BookingDialogueWidget> createState() => _BookingDialogueWidgetState();
}

class _BookingDialogueWidgetState extends State<BookingDialogueWidget> {
  final _controller = TextEditingController();

  late final String start;
  late final String end;
  late final String date;

  late Locale currentLocale;

  @override
  void initState() {
    super.initState();
    start = widget.schedule.startTime ?? '00:00';
    end = widget.schedule.endTime ?? '00:00';
    date = DateFormat.yMMMMEEEEd()
        .format(DateTime.fromMillisecondsSinceEpoch(widget.schedule.startTimestamp!));

    currentLocale = context.read<LanguageProvider>().currentLocale;
    context.read<LanguageProvider>().addListener(() {
      setState(() {
        currentLocale = context.read<LanguageProvider>().currentLocale;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final accessToken = authProvider.token?.access?.token ?? '';

    return AlertDialog(
      title: Text(AppLocalizations(currentLocale)
          .translate('book')!),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            AppLocalizations(currentLocale)
                .translate('bookingTime')!,
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
              decoration: InputDecoration(
                hintText: AppLocalizations(currentLocale)
                    .translate('requestForLesson')!,
                hintStyle: const TextStyle(fontWeight: FontWeight.w300, color: Colors.grey),
                contentPadding: const EdgeInsets.all(12),
                border: const OutlineInputBorder(
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
            child: Text(
              AppLocalizations(currentLocale)
                  .translate('cancel')!,
              style: const TextStyle(color: Colors.red),
            )),
        TextButton(
            onPressed: () async {
              await ScheduleService.bookAClass(
                scheduleDetailIds: [widget.schedule.scheduleDetails?.first.id ?? ''],
                note: _controller.text,
                token: accessToken,
              );

              if (mounted) {
                Navigator.pop(context);
                Navigator.pop(context);
              }
            },
            child: Text(AppLocalizations(currentLocale)
                .translate('book')!)),
      ],
    );
  }
}
