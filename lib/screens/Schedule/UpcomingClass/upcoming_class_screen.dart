import "package:flutter/material.dart";
import "package:flutter_project/screens/Schedule/UpcomingClass/UpcomingClassWidget/upcoming_class_widget.dart";

import "../../../models/schedule/booking_info.dart";
import "../../../utils/constants.dart";
import "../../../utils/sized_box.dart";

class UpcomingClassScreen extends StatefulWidget {
  const UpcomingClassScreen({Key? key}) : super(key: key);

  @override
  State<UpcomingClassScreen> createState() => _UpcomingClassScreenState();
}

class _UpcomingClassScreenState extends State<UpcomingClassScreen> {
  List<BookingInfo> upcoming = [];

  int _page = 1;
  int _perPage = itemsPerPage.first;
  int _count = 0;
  bool _isLoading = true;

  void _getUpcomingClasses() {
    final result = getBookingInfoList();

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
            'You have $_count upcoming classes with $_count hours to study',
            style: Theme.of(context).textTheme.headlineSmall,
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
                  isDense: true,
                  isExpanded: true,
                  value: _perPage,
                  items: itemsPerPage
                      .map(
                        (itemPerPage) => DropdownMenuItem<int>(
                          value: itemPerPage,
                          child: Text(
                            '$itemPerPage',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.tertiary,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
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
                        const EdgeInsets.symmetric(vertical: 3, horizontal: 8),
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
                    floatingLabelAlignment: FloatingLabelAlignment.center,
                  ),
                  alignment: Alignment.center,
                ),
              ),
            ],
          ),
          subSizedBox,
          ...List<Widget>.generate(
            upcoming.length,
            (index) => UpcomingClassWidget(
              bookingInfo: upcoming[index],
              onCancel: (value) {
                if (value) {
                  setState(() {
                    _isLoading = true;
                  });
                }
              },
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
                  backgroundColor: _page == 1
                      ? Colors.grey
                      : Theme.of(context).colorScheme.secondary,
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
                  backgroundColor: _page == _count
                      ? Colors.grey
                      : Theme.of(context).colorScheme.secondary,
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
