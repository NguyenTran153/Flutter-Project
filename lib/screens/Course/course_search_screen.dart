import 'package:flutter/material.dart';
import 'package:flutter_project/screens/Course/CourseItem/course_item_screen.dart';
import 'package:flutter_project/utils/sized_box.dart';
import 'package:flutter_project/widgets/text_field.dart';

import '../../models/course.dart';
import '../../constants/items_per_page.dart';

class CourseSearchScreen extends StatefulWidget {
  const CourseSearchScreen({super.key});

  @override
  State<CourseSearchScreen> createState() => _CourseListScreenState();
}

class _CourseListScreenState extends State<CourseSearchScreen> {
  final _searchController = TextEditingController();
  List<Course> courses = [
    Course(
      name: 'Lập trình Flutter',
      description: 'Khóa học học lập trình Flutter từ cơ bản đến nâng cao',
      price: 1000000,
    ),
    Course(
      name: 'Lập trình Android',
      description: 'Khóa học học lập trình Android từ cơ bản đến nâng cao',
      price: 2000000,
    ),
    Course(
      name: 'Lập trình iOS',
      description: 'Khóa học học lập trình iOS từ cơ bản đến nâng cao',
      price: 3000000,
    ),
  ];

  int _page = 1;
  int _perPage = itemsPerPage.first;
  int _count = 0;
  bool _isLoading = false;

  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextFieldInput(
            textEditingController: _searchController,
            hintText: "Find courses",
            textInputType: TextInputType.text,
            radius: 4,
          ),
          sizedBox,
          Expanded(
            child: _isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                // : courses.isEmpty
                //     ? _searchController.text.isEmpty
                //         ? const Center(
                //             child: Text(
                //               'There is no course available',
                //               style: TextStyle(fontSize: 16),
                //             ),
                //           )
                //         : const Center(
                //             child: Text(
                //               'No result(s) matches your search',
                //               style: TextStyle(fontSize: 16),
                //             ),
                //           )
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Expanded(
                              flex: 20,
                              child: Text(
                                'Items per page',
                                textAlign: TextAlign.right,
                              ),
                            ),
                            const SizedBox.shrink(),
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
                                        color: Theme.of(context)
                                            .colorScheme
                                            .tertiary,
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
                                  color:
                                  Theme.of(context).colorScheme.secondary,
                                ),
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 3, horizontal: 8),
                                  filled: true,
                                  fillColor:
                                  Theme.of(context).colorScheme.secondary,
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide:
                                    BorderSide(color: Colors.transparent),
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(24)),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide:
                                    BorderSide(color: Colors.transparent),
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(24)),
                                  ),
                                  floatingLabelAlignment: FloatingLabelAlignment.center,
                                ),
                                alignment: Alignment.center,
                              ),
                            ),                          ],
                        ),
                        ...List<Widget>.generate(
                            2, (index) => CourseItemScreen()),
                        subSizedBox,
                        Row(
                          children: [
                            IconButton(
                              style: IconButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                backgroundColor: _page == 1
                                    ? Theme.of(context).colorScheme.tertiary
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
                  ),
          )
        ],
      ),
    );
  }
}
