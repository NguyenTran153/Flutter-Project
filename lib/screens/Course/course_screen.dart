import 'package:flutter/material.dart';
import 'package:flutter_project/utils/sized_box.dart';
import 'package:provider/provider.dart';

import '../../constants/constant.dart';
import '../../l10n.dart';
import '../../models/course/course.dart';
import '../../providers/auth_provider.dart';
import '../../providers/language_provider.dart';
import '../../services/course_and_ebook_service.dart';
import 'CourseCard/course_card_widget.dart';

class CourseScreen extends StatefulWidget {
  const CourseScreen({super.key});

  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  final _searchController = TextEditingController();
  List<Course> courses = [];

  int _page = 1;
  int _perPage = itemsPerPage.first;
  int _count = 0;
  bool _isLoading = false;

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

  Future<void> _getCourses(String token, String search) async {
    final result = await CourseService.getListCourseWithPagination(
      page: _page,
      size: _perPage,
      token: token,
      search: search,
    );

    setState(() {
      courses = result['courses'];
      _count = result['count'];
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

    if (_isLoading && authProvider.token != null) {
      final String accessToken = authProvider.token?.access?.token as String;
      _getCourses(accessToken, _searchController.text);
    }

    return Scaffold(
      body: Column(
        children: [
          TextField(
            controller: _searchController,
            onSubmitted: (value) {
              setState(() {
                _isLoading = true;
              });
            },
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(right: 24),
              hintStyle: TextStyle(color: Colors.grey[400]),
              hintText: AppLocalizations(currentLocale).translate('search')!,
              prefixIcon: const Icon(Icons.search),
              border: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 1.5),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
            ),
          ),
          sizedBox,
          Expanded(
            child: _isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : courses.isEmpty
                    ? _searchController.text.isEmpty
                        ? Center(
                            child: Text(
                              AppLocalizations(currentLocale)
                                  .translate('youHaveNoCourse')!,
                              style: const TextStyle(fontSize: 16),
                            ),
                          )
                        : Center(
                            child: Text(
                              AppLocalizations(currentLocale)
                                  .translate('noMatchesFound')!,
                              style: const TextStyle(fontSize: 16),
                            ),
                          )
                    : SingleChildScrollView(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  flex: 20,
                                  child: Text(
                                    AppLocalizations(currentLocale)
                                        .translate('perPage')!,
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
                                          (itemPerPage) =>
                                              DropdownMenuItem<int>(
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
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                    ),
                                    decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 3, horizontal: 8),
                                      filled: true,
                                      fillColor: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      enabledBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(24)),
                                      ),
                                      focusedBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(24)),
                                      ),
                                      floatingLabelAlignment:
                                          FloatingLabelAlignment.center,
                                    ),
                                    alignment: Alignment.center,
                                  ),
                                ),
                              ],
                            ),
                            ...List<Widget>.generate(
                                courses.length,
                                (index) =>
                                    CourseCardWidget(course: courses[index])),
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
                                        : Theme.of(context)
                                            .colorScheme
                                            .secondary,
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
                                        : Theme.of(context)
                                            .colorScheme
                                            .secondary,
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
