import "package:cached_network_image/cached_network_image.dart";
import 'package:flutter/material.dart';
import "package:flutter_project/screens/VideoCall/video_call_screen.dart";
import "package:flutter_project/services/schedule_service.dart";
import "package:flutter_project/utils/sized_box.dart";
import "package:intl/intl.dart";
import "package:provider/provider.dart";
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:jitsi_meet_wrapper/jitsi_meet_wrapper.dart';


import '../../../../l10n/l10n.dart';
import "../../../../models/schedule/booking_info.dart";
import "../../../../providers/auth_provider.dart";
import "../../../../providers/language_provider.dart";

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

  bool _canCancelClass() {
    final startTimestamp =
        bookingInfo.scheduleDetailInfo?.startPeriodTimestamp ?? 0;
    final startTime = DateTime.fromMillisecondsSinceEpoch(startTimestamp);

    final timeDifference = startTime.difference(DateTime.now());

    return timeDifference.inHours >= 2;
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
    try {
      var options = JitsiMeetingOptions(
        roomNameOrUrl: "learningRoom",
        serverUrl: "https://meet.lettutor.com",
        token: meetingToken,
        isAudioMuted: false,
        isAudioOnly: true,
        isVideoMuted: false,
      );

      await JitsiMeetWrapper.joinMeeting(options: options);
    } catch (error) {
      debugPrint("error: $error");
    }

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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
        side: BorderSide(color: Theme.of(context).colorScheme.tertiary, width: 1),
      ),
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
                    await showEditRequestDialog(context, currentLocale);
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
                      try {
                        if (_canCancelClass()) {
                          final dialogResult = await showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text(AppLocalizations(currentLocale)
                                  .translate('cancel')!),
                              content: Text(AppLocalizations(currentLocale)
                                  .translate('areYouSure')!),
                              actions: [
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, false),
                                  child: const Text('NO'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context, true);
                                  },
                                  child: const Text('YES'),
                                ),
                              ],
                            ),
                          );

                          if (dialogResult) {
                            final result = await _cancelClass(authProvider);

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(result),
                              ),
                            );

                            if (result ==
                                AppLocalizations(currentLocale)
                                    .translate('cancelSuccess')!) {
                              onCancel(true);
                            }
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  'Cancellation is only allowed within 2 hours before the class.'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Error during cancelClass: $e'),
                            backgroundColor: Colors.red,
                          ),
                        );
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
                        final localContext = context;

                        if (_isTimeToJoin()) {
                          _joinMeeting(room, meetingToken);
                        } else {
                          final result = await showWaitingRoomDialog(localContext, currentLocale);
                          if (result) {
                            _joinMeeting(room, meetingToken);
                          } else {
                            Navigator.push(localContext, MaterialPageRoute(
                              builder: (context) {
                                final start = bookingInfo.scheduleDetailInfo!.startPeriodTimestamp!;
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

Future<bool> showEditRequestDialog(BuildContext context,  Locale currentLocale) {
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

Future<bool> showWaitingRoomDialog(BuildContext context, Locale currentLocale) async {
  return await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(AppLocalizations(currentLocale).translate('itIsNotTheTimeYet')!),
      content: Text(AppLocalizations(currentLocale).translate('doYouWantToEnterTheClass')!),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: Text(AppLocalizations(currentLocale).translate('waitingRoom')!),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, true),
          child: Text(AppLocalizations(currentLocale).translate('meetingRoom')!),
        ),
      ],
    ),
  ).then((value) => value ?? false);
}
