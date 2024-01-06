import 'package:flutter/material.dart';
import 'package:flutter_project/utils/sized_box.dart';
import 'package:provider/provider.dart';

import '../../../constants/nationality.dart';
import '../../../l10n/l10n.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/language_provider.dart';
import '../../../utils/routes.dart';

class TutorSearchScreen extends StatefulWidget {
  const TutorSearchScreen({Key? key}) : super(key: key);

  @override
  State<TutorSearchScreen> createState() => _TutorSearchScreenState();
}

class _TutorSearchScreenState extends State<TutorSearchScreen> {
  final _nameController = TextEditingController();
  List<String> _specialties = [];

  Nationality? _nationality = Nationality.foreign;
  int _chosenSpecialtiesIndex = 0;

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

  Map<String, dynamic> _encapsulateSearchParams(AuthProvider authProvider) {
    final name = _nameController.text;
    final accessToken = authProvider.token?.access?.token as String;

    return {
      'token': accessToken,
      'search': name,
      'nationality': _nationality?.index == Nationality.vietnamese.index,
      'specialties': _chosenSpecialtiesIndex == 0
          ? [].map((e) => e as String).toList()
          : [
              _specialties[_chosenSpecialtiesIndex]
                  .toLowerCase()
                  .replaceAll(' ', '-')
            ],
    };
  }

  // void _loadSpecialties() {
  //   _specialties = [
  //     'All',
  //     'Math',
  //     'History',
  //     'English',
  //     'Physics',
  //     'Chemistry'
  //   ];
  // }
  void _loadSpecialties(AuthProvider authProvider) {
    final learnTopics = authProvider.learnTopics.map((e) => e.name ?? 'null');
    final testPreparations =
        authProvider.testPreparations.map((e) => e.name ?? 'null');
    _specialties = ['All', ...learnTopics, ...testPreparations];
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    _loadSpecialties(authProvider);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppLocalizations(currentLocale).translate('findTutor')!,
              style: Theme.of(context).textTheme.headlineMedium),
          subSizedBox,
          TextField(
            controller: _nameController,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              hintStyle: TextStyle(color: Colors.grey[500]),
              hintText:
                  AppLocalizations(currentLocale).translate('searchByName')!,
              border: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.tertiary, width: 2),
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
            ),
          ),
          sizedBox,
          Text(AppLocalizations(currentLocale).translate('nationality')!,
              style: Theme.of(context).textTheme.headlineMedium),
          subSizedBox,
          Row(
            children: [
              Radio<Nationality>(
                value: Nationality.all,
                groupValue: _nationality,
                onChanged: (value) {
                  setState(() {
                    _nationality = value;
                  });
                },
              ),
              Text(AppLocalizations(currentLocale).translate('all')!),
            ],
          ),
          Row(
            children: [
              Radio<Nationality>(
                value: Nationality.vietnamese,
                groupValue: _nationality,
                onChanged: (value) {
                  setState(() {
                    _nationality = value;
                  });
                },
              ),
              Text(AppLocalizations(currentLocale).translate('vietnamese')!),
            ],
          ),
          Row(
            children: [
              Radio<Nationality>(
                value: Nationality.foreign,
                groupValue: _nationality,
                onChanged: (value) {
                  setState(() {
                    _nationality = value;
                  });
                },
              ),
              Text(AppLocalizations(currentLocale).translate('foreign')!),
            ],
          ),
          sizedBox,
          Text(AppLocalizations(currentLocale).translate('specialties')!,
              style: Theme.of(context).textTheme.headlineMedium),
          subSizedBox,
          Wrap(
            spacing: 8,
            runSpacing: -4,
            children: List<Widget>.generate(
              _specialties.length,
              (index) => ChoiceChip(
                backgroundColor: Theme.of(context).colorScheme.secondary,
                selectedColor: Colors.grey,
                selected: _chosenSpecialtiesIndex == index,
                label: Text(
                  _specialties[index],
                  style: TextStyle(
                    fontSize: 14,
                    color: _chosenSpecialtiesIndex == index
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).colorScheme.tertiary,
                  ),
                ),
                onSelected: (bool selected) {
                  setState(() {
                    _chosenSpecialtiesIndex = index;
                  });
                },
              ),
            ),
          ),
          sizedBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.max,
            children: [
              TextButton(
                onPressed: () {
                  setState(() {
                    _chosenSpecialtiesIndex = 0;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: Text(
                      AppLocalizations(currentLocale).translate('resetFilter')!,
                      style: const TextStyle(fontSize: 16)),
                ),
              ),
              sizedBox,
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    Routes.tutorSearchResult,
                    arguments: _encapsulateSearchParams(authProvider),
                  );
                },
                style: TextButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    AppLocalizations(currentLocale).translate('search')!,
                    style: TextStyle(
                        fontSize: 16, color: Theme.of(context).primaryColor),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
