import "package:flutter/material.dart";
import "package:flutter_project/screens/Schedule/BookedClass/BookedClassWidget/booked_class_card_widget.dart";
import "package:flutter_project/services/schedule_service.dart";
import "package:provider/provider.dart";

import "../../../constants/constant.dart";
import '../../../l10n/l10n.dart';
import "../../../models/schedule/booking_info.dart";
import "../../../providers/auth_provider.dart";
import "../../../providers/language_provider.dart";
import "../../../utils/sized_box.dart";

class BookedClassScreen extends StatefulWidget {
  const BookedClassScreen({Key? key}) : super(key: key);

  @override
  State<BookedClassScreen> createState() => _BookedClassScreenState();
}

class _BookedClassScreenState extends State<BookedClassScreen> {
  List<BookingInfo> bookedClasses = [];

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

  void _getBookedClasses(String token) async {
    final result = await ScheduleService.getBookedClasses(
      token: token,
      page: _page,
      perPage: _perPage,
    );

    setState(() {
      bookedClasses = result['classes'];
      _count = result['count'];
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

    if (_isLoading && authProvider.token != null) {
      final String accessToken = authProvider.token?.access?.token as String;
      _getBookedClasses(accessToken);
    }

    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : bookedClasses.isEmpty
            ? Center(
                child: Text(
                  AppLocalizations(currentLocale).translate('noBookedClasses')!,
                  style: const TextStyle(fontSize: 16),
                ),
              )
            : SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      AppLocalizations(currentLocale)
                          .translate('youHaveBookedClasses', ['$_count'])!,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    sizedBox,
                    Row(
                      children: [
                        Expanded(
                          flex: 16,
                          child: Text(
                            AppLocalizations(currentLocale)
                                .translate('perPage')!,
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
                      bookedClasses.length,
                      (index) => BookedClassCardWidget(
                        bookingInfo: bookedClasses[index],
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
