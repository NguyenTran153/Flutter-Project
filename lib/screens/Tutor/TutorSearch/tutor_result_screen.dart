import 'package:flutter/material.dart';
import 'package:flutter_project/screens/Tutor/TutorSearch/TutorSearchCard/tutor_search_card_widget.dart';
import 'package:flutter_project/utils/sized_box.dart';
import 'package:provider/provider.dart';

import '../../../constants/constant.dart';
import '../../../l10n/l10n.dart';
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
  List<Tutor> _originalTutors = [];
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
      _originalTutors = result['tutors'];
      _filteredTutors = result['tutors'];
      _isLoading = false;
    });
  }

  bool _isDescending = false;
  IconData _sortIcon = Icons.sort;

  void _sortTutors() {
    setState(() {
      if (_selectedSortOption == 0) {
        _sortTutorsByRating();
      } else if (_selectedSortOption == 1) {
        _sortTutorsByFavorite();
      } else {
        _sortTutorsDefault();
      }

      _sortIcon = _isDescending ? Icons.arrow_upward : Icons.arrow_downward;
      _isDescending = !_isDescending; // Toggle for next sort
    });
  }

  void _sortTutorsByRating() {
    _filteredTutors.sort((a, b) {
      if (a.rating == null && b.rating == null) return 0;
      if (a.rating == null) return 1;
      if (b.rating == null) return -1;

      int result = a.rating!.compareTo(b.rating!);
      return _isDescending ? -result : result;
    });
    setState(() {
      _tutors = List.from(_filteredTutors);
    });
  }

  void _sortTutorsByFavorite() {
    setState(() {
      _tutors = List.from(_originalTutors);
      _filteredTutors =
          List.from(_originalTutors); // Ensure filtered list is updated
    });
  }

  // void _sortTutorsDefault() {
  //   setState(() {
  //     _originalTutors.sort((a, b) {
  //       return a.name?.compareTo(b.name ?? '') ?? 0;
  //     });
  //     _tutors = _originalTutors;
  //   });
  // }

  void _sortTutorsDefault() {
    setState(() {
      _originalTutors.sort((a, b) {
        return a.name?.compareTo(b.name ?? '') ?? 0;
      });
      _tutors = List.from(_originalTutors);
    });
  }

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
                              Align(
                                child: Expanded(
                                  flex: 1,
                                  child: PopupMenuButton<int>(
                                    position: PopupMenuPosition.under,
                                    icon: const Icon(Icons.sort),
                                    initialValue: _selectedSortOption,
                                    onSelected: (value) {
                                      setState(() {
                                        _selectedSortOption = value;
                                        _isDescending = !_isDescending;
                                        _sortTutors();
                                      });
                                    },
                                    itemBuilder: (BuildContext context) =>
                                        <PopupMenuEntry<int>>[
                                      const PopupMenuItem<int>(
                                        value: 0,
                                        child: Text('Sort by Rating'),
                                      ),
                                      const PopupMenuItem<int>(
                                        value: 1,
                                        child: Text('Sort by Favorite'),
                                      ),
                                      const PopupMenuItem<int>(
                                        value: 2,
                                        child: Text('Default Sorting'),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 128,
                              ),
                              Expanded(
                                flex: 1,
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
                                flex: 1,
                                child: DropdownButtonFormField<int>(
                                  isDense: true,
                                  isExpanded: true,
                                  value: _perPage,
                                  items: itemsPerPage
                                      .map((itemPerPage) =>
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
                                            ),
                                          ))
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
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.transparent),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(24)),
                                    ),
                                    focusedBorder: OutlineInputBorder(
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
