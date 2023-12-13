import 'package:flutter/material.dart';
import 'package:flutter_project/screens/Schedule/History/HistoryCardWidget/history_card_widget.dart';
import 'package:flutter_project/services/schedule_service.dart';
import 'package:flutter_project/utils/sized_box.dart';
import 'package:provider/provider.dart';

import '../../../constants/constant.dart';
import '../../../l10n.dart';
import '../../../models/schedule/booking_info.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/language_provider.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<BookingInfo> history = [];

  int _page = 1;
  int _perPage = itemsPerPage.first;
  int _count = 0;
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

  void _getHistory(String token) async {
    final result = await ScheduleService.getHistory(
      token: token,
      page: _page,
      perPage: _perPage,
    );

    setState(() {
      history = result['classes'];
      _count = result['count'];
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

    if (_isLoading && authProvider.token != null) {
      final String accessToken = authProvider.token?.access?.token as String;
      _getHistory(accessToken);
    }

    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : history.isEmpty
            ? Center(
                child: Text(AppLocalizations(currentLocale)
                    .translate('noBookedClasses')!),
              )
            : SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      AppLocalizations(currentLocale)
                          .translate('youHaveBookedClasses', ['$_count'])!,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    sizedBox,
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
                              color: Theme.of(context).colorScheme.secondary,
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
                    subSizedBox,
                    ...List<Widget>.generate(
                      history.length,
                      (index) => HistoryCardWidget(bookingInfo: history[index]),
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
                          icon: Icon(Icons.navigate_before_rounded,
                              size: 28, color: Theme.of(context).primaryColor),
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
                          icon: Icon(Icons.navigate_next_rounded,
                              size: 28, color: Theme.of(context).primaryColor),
                        ),
                      ],
                    )
                  ],
                ),
              );
  }
}
