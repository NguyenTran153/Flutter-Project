import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/models/schedule/booking_info.dart';
import 'package:flutter_project/utils/sized_box.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../l10n.dart';
import '../../../../providers/language_provider.dart';
import '../../../../utils/routes.dart';
import '../../../Tutor/Review/writing_review_screen.dart';

class HistoryCardWidget extends StatefulWidget {
  const HistoryCardWidget({Key? key, required this.bookingInfo})
      : super(key: key);

  final BookingInfo bookingInfo;

  @override
  State<HistoryCardWidget> createState() => _HistoryCardWidgetState();
}

class _HistoryCardWidgetState extends State<HistoryCardWidget> {
  late final BookingInfo bookingInfo;

  late Locale currentLocale;

  @override
  void initState() {
    super.initState();
    bookingInfo = widget.bookingInfo;
    currentLocale = context.read<LanguageProvider>().currentLocale;
    context.read<LanguageProvider>().addListener(() {
      setState(() {
        currentLocale = context.read<LanguageProvider>().currentLocale;
      });
    });
  }

  String _convertClassTime() {
    String result = '';
    result += DateFormat.Hm().format(DateTime.fromMillisecondsSinceEpoch(
        bookingInfo.scheduleDetailInfo!.startPeriodTimestamp ?? 0));
    result += ' - ';
    result += DateFormat.Hm().format(DateTime.fromMillisecondsSinceEpoch(
        bookingInfo.scheduleDetailInfo!.endPeriodTimestamp ?? 0));
    return result;
  }
  Future<bool> showReportDialog(BuildContext context) async {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(AppLocalizations(currentLocale).translate('report')!),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 72,
                      height: 72,
                      clipBehavior: Clip.hardEdge,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: CachedNetworkImage(
                        imageUrl: bookingInfo.scheduleDetailInfo!.scheduleInfo!
                            .tutorInfo!.avatar ??
                            '',
                        fit: BoxFit.cover,
                        errorWidget: (context, url, error) => const Icon(
                          Icons.error_outline_rounded,
                          size: 32,
                          color: Colors.red,
                        ),
                      ),
                    ),

                    sizedBox,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            bookingInfo.scheduleDetailInfo!.scheduleInfo!.tutorInfo!
                                .name ?? '',
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          subSizedBox,
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  'Please tell us what went wrong',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 8),
                TextField(
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(12),
                      border: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10))),
                ),
                const SizedBox(height: 8),
                TextField(
                  minLines: 3,
                  maxLines: 4,
                  decoration: InputDecoration(
                      hintText: 'Additional Notes',
                      contentPadding: const EdgeInsets.all(12),
                      border: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10))),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text(
                'Cancel',
                style: TextStyle(fontSize: 18),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text(
                'OK',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        );
      },
    ).then((value) => value ?? false);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 12),
      surfaceTintColor: Theme.of(context).primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
        side: BorderSide(color: Theme.of(context).colorScheme.tertiary, width: 1),
      ),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 72,
                  height: 72,
                  clipBehavior: Clip.hardEdge,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: CachedNetworkImage(
                    imageUrl: bookingInfo.scheduleDetailInfo!.scheduleInfo!
                            .tutorInfo!.avatar ??
                        '',
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) => const Icon(
                      Icons.error_outline_rounded,
                      size: 32,
                      color: Colors.red,
                    ),
                  ),
                ),
                sizedBox,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        bookingInfo.scheduleDetailInfo!.scheduleInfo!.tutorInfo!
                                .name ??
                            AppLocalizations(currentLocale).translate('null')!,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      subSizedBox,
                      Text(
                        DateFormat.yMMMEd().format(
                            DateTime.fromMillisecondsSinceEpoch(bookingInfo
                                    .scheduleDetailInfo!.startPeriodTimestamp ??
                                0)),
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        _convertClassTime(),
                        style: const TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            sizedBox,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(AppLocalizations(currentLocale).translate('noRequestForLesson')!),
            ),
            sizedBox,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(AppLocalizations(currentLocale).translate('noReview')!),
            ),
            sizedBox,
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(foregroundColor: Colors.red),
                    onPressed: () async {
                      await showReportDialog(context);
                    },
                    child: Text(
                      AppLocalizations(currentLocale).translate('report')!,
                      style: const TextStyle(fontSize: 16, color: Colors.red),
                    ),
                  ),
                ),
                sizedBox,
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WritingReviewScreen(bookingId: bookingInfo.id),
                        ),
                      );                    },
                    child: Text(
                      AppLocalizations(currentLocale).translate('review')!,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

