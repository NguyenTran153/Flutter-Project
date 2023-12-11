import 'package:flutter/material.dart';
import 'package:flutter_project/screens/Schedule/BookedClass/booked_class_screen.dart';
import 'package:flutter_project/utils/sized_box.dart';
import 'package:provider/provider.dart';

import '../../l10n.dart';
import '../../providers/language_provider.dart';
import 'History/history_screen.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            TabBar(
              tabs: [
                Tab(
                  icon: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.timer_outlined,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      subSizedBox,
                      Text(
                        AppLocalizations(currentLocale).translate('bookedClasses')!,
                        style: TextStyle(color: Theme.of(context).colorScheme.secondary),
                      )
                    ],
                  ),
                ),
                Tab(
                  icon: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.history_outlined,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        AppLocalizations(currentLocale).translate('history')!,
                        style: TextStyle(color: Theme.of(context).colorScheme.secondary),
                      )
                    ],
                  ),
                ),
              ],
            ),
            const Expanded(
              child: TabBarView(
                children: [
                  BookedClassScreen(),
                  HistoryScreen(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
