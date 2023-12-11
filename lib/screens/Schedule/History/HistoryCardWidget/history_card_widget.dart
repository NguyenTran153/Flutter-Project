import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/models/schedule/booking_info.dart';
import 'package:flutter_project/utils/sized_box.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../l10n.dart';
import '../../../../providers/language_provider.dart';
import '../../../../utils/routes.dart';

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

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 12),
      surfaceTintColor: Theme.of(context).primaryColor,
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
                    onPressed: () async {},
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
                      Navigator.pushNamed(context, Routes.review);
                    },
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


