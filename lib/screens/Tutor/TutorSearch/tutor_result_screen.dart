import 'package:flutter/material.dart';
import 'package:flutter_project/screens/Tutor/TutorSearch/TutorSearchCard/tutor_search_card_widget.dart';
import 'package:flutter_project/utils/sized_box.dart';
import 'package:provider/provider.dart';

import '../../../constants/constant.dart';
import '../../../l10n.dart';
import '../../../models/tutor/tutor.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/language_provider.dart';
import '../../../services/tutor_service.dart';

class TutorResultScreen extends StatefulWidget {
  const TutorResultScreen({Key? key}) : super(key: key);

  @override
  State<TutorResultScreen> createState() => _TutorResultScreenState();
}

class _TutorResultScreenState extends State<TutorResultScreen> {
  int _page = 1;
  int _perPage = itemsPerPage.first;
  bool _isLoading = true;
  int _count = 0;
  List<Tutor> _tutors = [];
  int? _selectedSortOption;
  bool _defaultSorting = true;
  List<Tutor> _filteredTutors = [];
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

  // Future<void> _searchTutors(
  //   String name,
  //   bool isVietnamese,
  //   List<String> specialties,
  // ) async {
  //   List<Tutor> tutors = getTutors();
  //
  //   // Sử dụng biến result kiểu Map để lưu kết quả tìm kiếm
  //   Map<String, dynamic> result = {
  //     'search': name,
  //     'nationality': isVietnamese,
  //     'specialties': specialties,
  //     'count': 0,
  //     'tutors': [],
  //   };
  //
  //   List<Tutor> results = tutors.where((tutor) {
  //     bool nameCondition =
  //         tutor.name.toLowerCase().contains(name.toLowerCase());
  //     bool nationalityCondition =
  //         isVietnamese ? tutor.country == 'Vietnam' : true;
  //
  //     // Chuyển đổi specialties của Tutor thành danh sách
  //     List<String> tutorSpecialties = tutor.specialties
  //             ?.split(',')
  //             .map((e) => e.trim().toLowerCase())
  //             .toList() ??
  //         [];
  //
  //     // Kiểm tra xem có ít nhất một giá trị trong specialties trùng với chuyên môn của gia sư không
  //     bool specialtiesCondition = specialties.isEmpty ||
  //         (tutorSpecialties.isNotEmpty &&
  //             specialties.any((specialty) => tutorSpecialties.contains(
  //                   specialty.toLowerCase(),
  //                 )));
  //
  //     return nameCondition &&
  //         nationalityCondition &&
  //         (isVietnamese ? true : tutor.country != 'Vietnam') &&
  //         specialtiesCondition;
  //   }).toList();
  //
  //   // Gán kết quả vào biến result
  //   result['count'] = results.length;
  //   result['tutors'] = results;
  //
  //   setState(() {
  //     _count = result['count'];
  //     _tutors = result['tutors'];
  //     _isLoading = false;
  //     _filteredTutors = List.from(_tutors); // Lưu trạng thái trước khi sắp xếp
  //   });
  //
  //   if (_selectedSortOption != null && !_defaultSorting) {
  //     _sortTutors();
  //   }
  // }

  Future<void> _searchTutors(
    String accessToken,
    String name,
    bool isVietnamese,
    List<String> specialties,
  ) async {
    final result = await TutorService.searchTutor(
      token: accessToken,
      search: name,
      page: _page,
      perPage: _perPage,
      nationality: {'isVietNamese': isVietnamese},
      specialties: specialties,
    );

    setState(() {
      _count = result['count'];
      _tutors = result['tutors'];
      _isLoading = false;
    });
  }

  bool _isDescending = false;
  IconData _sortIcon = Icons.sort;

  // void _sortTutors() {
  //   setState(() {
  //     if (_selectedSortOption == 0) {
  //       _tutors.sort((a, b) {
  //         return _isDescending
  //             ? b.rating.compareTo(a.rating)
  //             : a.rating.compareTo(b.rating);
  //       });
  //     } else {
  //       // Nếu không có lựa chọn sắp xếp, trở về trạng thái mặc định (theo vị trí ban đầu)
  //       _tutors = List.from(_filteredTutors);
  //     }
  //
  //     _sortIcon = _isDescending ? Icons.arrow_downward : Icons.arrow_upward;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final data = ModalRoute.of(context)?.settings.arguments as Map;

    if (_isLoading) {
      _searchTutors(
        data['token'],
        data['search'],
        data['nationality'],
        data['specialties'],
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations(currentLocale).translate('result')!),
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
                    _tutors.isEmpty
                        ? AppLocalizations(currentLocale)
                            .translate('noMatchesFound')!
                        : 'Found $_count result(s)',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  _count > 0
                      ? Container(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 6,
                                child: PopupMenuButton<int>(
                                  icon: Icon(Icons.sort),
                                  initialValue: _selectedSortOption,
                                  onSelected: (value) {
                                    setState(() {
                                      if (value == 0) {
                                        _selectedSortOption = value;
                                        _isDescending = !_isDescending;
                                        _defaultSorting = false;
                                        // _sortTutors();
                                      } else {
                                        _selectedSortOption = value;
                                        _defaultSorting = true;
                                        // _sortTutors();
                                      }
                                    });
                                  },
                                  itemBuilder: (BuildContext context) =>
                                      <PopupMenuEntry<int>>[
                                    PopupMenuItem<int>(
                                      value: 0,
                                      child: Text('Sort by Rating'),
                                    ),
                                    PopupMenuItem<int>(
                                      value: 1,
                                      child: Text('Default Sorting'),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Expanded(
                                flex: 20,
                                child: Text(
                                  AppLocalizations(currentLocale)
                                      .translate('perPage')!,
                                  textAlign: TextAlign.right,
                                ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
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
                                    floatingLabelAlignment:
                                        FloatingLabelAlignment.center,
                                  ),
                                  alignment: Alignment.center,
                                ),
                              ),
                            ],
                          ),
                        )
                      : const SizedBox.shrink(),
                  subSizedBox,
                  ...List<Widget>.generate(
                    _tutors.length,
                    (index) => TutorSearchCardWidget(tutor: _tutors[index]),
                  ),
                  _count > 0
                      ? Row(
                          children: [
                            sizedBox,
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
                                    ? Theme.of(context).colorScheme.tertiary
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
                            sizedBox,
                          ],
                        )
                      : const SizedBox.shrink(),
                ],
              ),
            ),
    );
  }
}
