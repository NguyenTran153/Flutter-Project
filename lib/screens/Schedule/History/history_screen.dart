import 'package:flutter/material.dart';
import 'package:flutter_project/screens/Schedule/History/HistoryWidget/history_widget.dart';
import 'package:flutter_project/utils/sized_box.dart';

import '../../../models/schedule/booking_info.dart';
import '../../../constants/items_per_page.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<BookingInfo> history = [];

  int _page = 1;
  int _perPage = itemsPerPage.first;
  int _count = 0;
  bool _isLoading = true;

  void _getHistory() {
    final result = [];

    setState(() {
      _count = result.length;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    _getHistory();

    return history.isEmpty
        ? const Center(
      child: Text('You have not booked any class'),
    )
        : SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Text(
            'You have booked $_count classes',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          sizedBox,
          Row(
            children: [
              const Expanded(
                flex: 20,
                child: Text(
                  'Items per page',
                  textAlign: TextAlign.right,
                ),
              ),
              sizedBox,
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
            history.length,
                (index) => HistoryWidget(bookingInfo: history[index]),
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
                  color: Theme.of(context).primaryColor
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
                  color: Theme.of(context).primaryColor
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
