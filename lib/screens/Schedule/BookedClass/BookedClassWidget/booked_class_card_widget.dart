import "package:cached_network_image/cached_network_image.dart";
import "package:flutter/foundation.dart";
import 'package:flutter/material.dart';
import "package:flutter_project/screens/VideoCall/video_call_screen.dart";
import "package:flutter_project/services/schedule_service.dart";
import "package:flutter_project/utils/sized_box.dart";
import "package:intl/intl.dart";
import 'package:jitsi_meet/jitsi_meet.dart';
import "package:provider/provider.dart";
import 'package:jwt_decoder/jwt_decoder.dart';

import "../../../../l10n.dart";
import "../../../../models/schedule/booking_info.dart";
import "../../../../providers/auth_provider.dart";
import "../../../../providers/language_provider.dart";

late Locale currentLocale;

class BookedClassCardWidget extends StatefulWidget {
  const BookedClassCardWidget(
      {Key? key, required this.bookingInfo, required this.onCancel})
      : super(key: key);

  final BookingInfo bookingInfo;
  final Function(bool cancelResult) onCancel;

  @override
  State<BookedClassCardWidget> createState() => _BookedClassCardWidgetState();
}

class _BookedClassCardWidgetState extends State<BookedClassCardWidget> {
  // bool _isCardVisible = true;
  late final BookingInfo bookingInfo;
  late final Function(bool cancelResult) onCancel;

  late Locale currentLocale;

  @override
  void initState() {
    super.initState();
    bookingInfo = widget.bookingInfo;
    onCancel = widget.onCancel;
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

  Future<String> _cancelClass(AuthProvider authProvider) async {
    final String token = authProvider.token?.access?.token as String;
    final result = await ScheduleService.cancelBookedClass(
      scheduleDetailIds: [bookingInfo.id ?? ''],
      token: token,
    );
    return result;
  }

  bool _isTimeToJoin() {
    final startTimestamp =
        bookingInfo.scheduleDetailInfo?.startPeriodTimestamp ?? 0;
    final startTime = DateTime.fromMillisecondsSinceEpoch(startTimestamp);
    final now = DateTime.now();
    return now.isAfter(startTime) || now.isAtSameMomentAs(startTime);
  }

  void _joinMeeting(String room, String meetingToken) async {
    Map<FeatureFlagEnum, bool> featureFlags = {
      FeatureFlagEnum.WELCOME_PAGE_ENABLED: false,
    };
    if (!kIsWeb) {
      if (defaultTargetPlatform == TargetPlatform.android) {
        featureFlags[FeatureFlagEnum.CALL_INTEGRATION_ENABLED] = false;
      } else if (defaultTargetPlatform == TargetPlatform.iOS) {
        featureFlags[FeatureFlagEnum.PIP_ENABLED] = false;
      }
    }

    final options = JitsiMeetingOptions(room: room)
      // ..serverURL = 'https://meet.jit.si/'
      ..serverURL = "https://meet.lettutor.com"
      ..token = meetingToken
      ..audioOnly = true
      ..audioMuted = true
      ..videoMuted = true
      ..featureFlags.addAll(featureFlags);
    await JitsiMeet.joinMeeting(options);
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    final String meetingToken =
        bookingInfo.studentMeetingLink?.split('token=')[1] ?? '';
    Map<String, dynamic> jwtDecoded = JwtDecoder.decode(meetingToken);
    final String room = jwtDecoded['room'];

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 12),
      surfaceTintColor: Theme.of(context).primaryColor,
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
        child: Column(
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
                                .name ??
                            AppLocalizations(currentLocale).translate('null')!,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      sizedBox,
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
                IconButton(
                  onPressed: () async {
                    await showEditRequestDialog(context);
                  },
                  icon: Icon(
                    Icons.edit_note_outlined,
                    size: 32,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                )
              ],
            ),
            sizedBox,
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.red,
                    ),
                    onPressed: () async {
                      final dialogResult = await showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text(AppLocalizations(currentLocale)
                              .translate('cancel')!),
                          content: Text(AppLocalizations(currentLocale)
                              .translate('areYouSure')!),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context, false),
                              child: const Text('NO'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context, true);
                                // setState(() {
                                //   _isCardVisible = false;
                                // });
                              },
                              child: const Text('YES'),
                            ),
                          ],
                        ),
                      );
                      if (dialogResult) {
                        final currentContext = context;

                        _cancelClass(authProvider).then((result) {
                          showDialog(
                            context: currentContext,
                            builder: (context) => AlertDialog(
                              content: Text(result),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    if (result ==
                                        AppLocalizations(currentLocale)
                                            .translate('cancelSuccess')!) {
                                      onCancel(true);
                                    }
                                    Navigator.pop(currentContext);
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          );
                        });
                      }
                    },
                    child: Text(
                      AppLocalizations(currentLocale).translate('cancel')!,
                      style: const TextStyle(fontSize: 16, color: Colors.red),
                    ),
                  ),
                ),
                sizedBox,
                Expanded(
                    child: TextButton(
                  onPressed: () async {
                    if (_isTimeToJoin()) {
                      _joinMeeting(room, meetingToken);
                    } else {
                      final result = await showWaitingRoomDialog(context);
                      if (result) {
                        _joinMeeting(room, meetingToken);
                      } else {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            final start = bookingInfo
                                .scheduleDetailInfo!.startPeriodTimestamp!;
                            return VideoCallScreen(startTimestamp: start);
                          },
                        ));
                      }
                    }
                  },
                  child: Text(
                    AppLocalizations(currentLocale).translate('goToMeeting')!,
                    style: const TextStyle(fontSize: 16),
                  ),
                ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Future<bool> showEditRequestDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(
            AppLocalizations(currentLocale).translate('requestForLesson')!),
        content: TextField(
          minLines: 2,
          maxLines: 4,
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(12),
              border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10))),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context, false);
            },
            child: Text(
              AppLocalizations(currentLocale).translate('cancel')!,
              style: const TextStyle(fontSize: 18),
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

Future<bool> showWaitingRoomDialog(BuildContext context) async {
  return await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('It is not the time yet'),
      content: const Text(
          'Do you want to enter meeting room right now, or enter waiting room?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text('Waiting Room'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, true),
          child: const Text('Meeting Room'),
        ),
      ],
    ),
  ).then((value) => value ?? false);
}
