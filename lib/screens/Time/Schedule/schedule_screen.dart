import "package:flutter/material.dart";
import "package:flutter_project/screens/Time/Schedule/scheduleItem/schedule_item.dart";
import "package:flutter_project/utils/colors.dart";

import "../../../models/schedule/schedule.dart";
import "../../../utils/constants.dart";
import "../../../utils/sized_box.dart";

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  List<Schedule> upcoming = [];

  int _page = 1;
  int _perPage = itemsPerPage.first;
  int _count = 0;
  bool _isLoading = true;

  void _getUpcomingClasses() {
    final result = getSchedules();

    setState(() {
      upcoming = result;
      _count = result.length;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    _getUpcomingClasses();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Text(
            'You have $_count upcoming classes',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          sizedBox,
          Row(
            children: [
              const Expanded(
                flex: 16,
                child: Text(
                  'Items per page',
                  textAlign: TextAlign.right,
                ),
              ),
              const SizedBox.shrink(),
              const SizedBox(width: 16),
              Expanded(
                flex: 6,
                child: DropdownButtonFormField<int>(
                  value: _perPage,
                  items: itemsPerPage
                      .map((itemPerPage) => DropdownMenuItem<int>(
                      value: itemPerPage, child: Text('$itemPerPage')))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _perPage = value!;
                      _page = 1;
                      _isLoading = true;
                    });
                  },
                  icon: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  decoration: InputDecoration(
                    contentPadding:
                    const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.secondary,
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.all(Radius.circular(24)),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.all(Radius.circular(24)),
                    ),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 8),
          ...List<Widget>.generate(
            upcoming.length,
                (index) => ScheduleItem(

            ),
          ),
          subSizedBox,
          Row(
            children: [
              IconButton(
                style: IconButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: _page == 1 ? Colors.grey : Theme.of(context).colorScheme.secondary,
                ),
                onPressed: _page == 1
                    ? null
                    : () {
                  setState(() {
                    _isLoading = true;
                    _page--;
                  });
                },
                icon: Icon(
                  Icons.navigate_before_rounded,
                  size: 28,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              Expanded(
                child: Text(
                  'Page $_page/${(_count / _perPage).ceil()}',
                  textAlign: TextAlign.center,
                ),
              ),
              IconButton(
                style: IconButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: _page == _count ? Colors.grey : Theme.of(context).colorScheme.secondary,
                ),
                onPressed: _page == (_count / _perPage).ceil()
                    ? null
                    : () {
                  setState(() {
                    _isLoading = true;
                    _page++;
                  });
                },
                icon: Icon(
                  Icons.navigate_next_rounded,
                  size: 28,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
