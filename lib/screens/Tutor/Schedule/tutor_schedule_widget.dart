import 'package:flutter/material.dart';
import 'package:flutter_project/screens/Tutor/BookTutor/booking_hour_screen.dart';
import 'package:flutter_project/services/schedule_service.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../l10n/l10n.dart';
import '../../../models/schedule/schedule.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/language_provider.dart';

class TutorScheduleWidget extends StatefulWidget {
  const TutorScheduleWidget({Key? key, required this.userId}) : super(key: key);

  final String userId;

  @override
  State<TutorScheduleWidget> createState() => _TutorScheduleWidgetState();
}

class _TutorScheduleWidgetState extends State<TutorScheduleWidget> {
  AuthProvider get _authProvider => context.read<AuthProvider>();

  List<Schedule> schedules = [];
  List<int> scheduleStartTimestamps = [];
  DateTime _selectedStartDate = DateTime.now();
  DateTime _selectedEndDate = DateTime.now().add(const Duration(days: 10));

  bool _isLoading = true;

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

  void onDateRangePickerTap() {
    final year = DateTime.now().year;

    showDateRangePicker(
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      context: context,
      firstDate: DateTime(year - 5),
      lastDate: DateTime(year + 5),
      initialDateRange: DateTimeRange(
        start: _selectedStartDate,
        end: _selectedEndDate,
      ),
      builder: (_, child) {
        return DatePickerTheme(
          data: DatePickerThemeData(
            dayBackgroundColor:
            MaterialStateProperty.all(Theme.of(context).primaryColor),
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.9,
                maxHeight: MediaQuery.of(context).size.height * 0.7,
              ),
              child: child,
            ),
          ),
        );
      },
    ).then((selectedRangeDate) {
      setState(() {
        _selectedStartDate = selectedRangeDate?.start ?? _selectedStartDate;
        _selectedEndDate = selectedRangeDate?.end ?? _selectedEndDate;
        if (_authProvider.token?.access?.token?.isNotEmpty ?? false) {
          Future.delayed(Duration.zero, () async {
            await _getTutorSchedule(_authProvider.token!.access!.token!);
          });
        }
      });
    });
  }

  Future<void> _getTutorSchedule(String token) async {
    setState(() {
      _isLoading = true;
    });
    List<Schedule> result = await ScheduleService.getTutorScheduleById(
      token: token,
      userId: widget.userId,
      startDate: _selectedStartDate.millisecondsSinceEpoch,
      endDate: _selectedEndDate.millisecondsSinceEpoch,
    );

    // Remove all learning dates before today
    result = result.where((schedule) {
      if (schedule.startTimestamp == null) return false;

      //final now = DateTime.now();
      final start =
      DateTime.fromMillisecondsSinceEpoch(schedule.startTimestamp!);

      // bool isTheSameDate = now.day == start.day && now.month == start.month && now.year == start.year;
      return start.isAfter(DateTime.now());
    }).toList();

    // Sort learning DateTime increasingly
    result.sort((s1, s2) {
      if (s1.startTimestamp == null || s2.startTimestamp == null) return 0;
      return s1.startTimestamp!.compareTo(s2.startTimestamp!);
    });

    schedules = result;

    final timestamps =
    schedules.map((schedule) => schedule.startTimestamp ?? 0).toList();

    for (var timestamp in timestamps) {
      //bool isExisted = false;
      if (!scheduleStartTimestamps.any((element) {
        final date1 = DateTime.fromMillisecondsSinceEpoch(timestamp);
        final date2 = DateTime.fromMillisecondsSinceEpoch(element);

        bool isTheSameDate = date1.day == date2.day &&
            date1.month == date2.month &&
            date1.year == date2.year;
        if (isTheSameDate) {
          return true;
        }
        return false;
      })) {
        scheduleStartTimestamps.add(timestamp);
      }
    }
    scheduleStartTimestamps.sort();

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

    if (_isLoading && authProvider.token != null) {
      final String accessToken = authProvider.token?.access?.token as String;
      _getTutorSchedule(accessToken);
    }

    return SafeArea(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.75,
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 0),
                    child: Text(
                      AppLocalizations(currentLocale).translate('chooseDate')!,
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                  ),
                  Expanded(
                    child: GridView.count(
                      padding: const EdgeInsets.all(24),
                      crossAxisCount: 2,
                      mainAxisSpacing: 24,
                      crossAxisSpacing: 32,
                      childAspectRatio: 3,
                      children: List<Widget>.generate(
                        scheduleStartTimestamps.length,
                        (index) => ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.secondary,
                          ),
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return BookingHourScreen(
                                  schedules: schedules,
                                  timestamp: scheduleStartTimestamps[index],
                                );
                              },
                            ));
                          },
                          child: Text(
                            DateFormat.MMMEd().format(
                                DateTime.fromMillisecondsSinceEpoch(
                                    scheduleStartTimestamps[index])),
                            style: TextStyle(
                                fontSize: 16,
                                color: Theme.of(context).primaryColor),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
