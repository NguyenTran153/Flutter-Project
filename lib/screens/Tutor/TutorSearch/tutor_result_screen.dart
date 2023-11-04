import 'package:flutter/material.dart';
import 'package:flutter_project/screens/Tutor/TutorSearch/TutorSearchItem/tutor_search_item.dart';
import 'package:flutter_project/utils/colors.dart';

import '../../../utils/constants.dart';
import '../../Homepage/TutorItem/tutor_item.dart';

class TutorResultScreen extends StatefulWidget {
  const TutorResultScreen({Key? key}) : super(key: key);

  @override
  State<TutorResultScreen> createState() => _TutorResultScreenState();
}

class _TutorResultScreenState extends State<TutorResultScreen> {
  int _page = 1;
  int _perPage = itemsPerPage.first;
  bool _isLoading = false;
  int _count = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Results'),
      ),
      body: _isLoading
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
               'Found $_count result(s)',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            _count > 0
                ? Row(
              children: [
                const Expanded(
                  flex: 20,
                  child: Text(
                    'Tutors per page',
                    textAlign: TextAlign.right,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  flex: 7,
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
                    icon: const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: secondaryColor,
                    ),
                    decoration: InputDecoration(
                      contentPadding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                      filled: true,
                      fillColor: secondaryColor,
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
            )
                : const SizedBox.shrink(),
            const SizedBox(height: 8),
            ...List<Widget>.generate(
              10,
                  (index) => TutorItem(),
            ),
            _count > 0
                ? Row(
              children: [
                const SizedBox(width: 16),
                IconButton(
                  style: IconButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: _page == 1 ? tertiaryColor : secondaryColor,
                  ),
                  onPressed: _page == 1
                      ? null
                      : () {
                    setState(() {
                      _isLoading = true;
                      _page--;
                    });
                  },
                  icon: const Icon(
                    Icons.navigate_before_rounded,
                    size: 28,
                    color: Colors.white,
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
                    backgroundColor: _page == _count ? Colors.grey : Colors.blue[300],
                  ),
                  onPressed: _page == (_count / _perPage).ceil()
                      ? null
                      : () {
                    setState(() {
                      _isLoading = true;
                      _page++;
                    });
                  },
                  icon: const Icon(
                    Icons.navigate_next_rounded,
                    size: 28,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 16),
              ],
            )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );  }
}
