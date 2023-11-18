import 'package:flutter/material.dart';
import 'package:flutter_project/models/tutor.dart';
import 'package:flutter_project/utils/sized_box.dart';

import '../../../constants/nationality.dart';
import '../../../utils/routes.dart';

class TutorSearchScreen extends StatefulWidget {
  const TutorSearchScreen({Key? key}) : super(key: key);

  @override
  State<TutorSearchScreen> createState() => _TutorSearchScreenState();
}

class _TutorSearchScreenState extends State<TutorSearchScreen> {
  final _nameController = TextEditingController();
  List<String> _specialties = [];
  List<String> _filterSpecialies = [];
  Nationality? _nationality = Nationality.foreign;

  int _chosenSpecialtiesIndex = 0;
  List<Tutor> tutors = getTutors();

  Map<String, dynamic> _encapsulateSearchParams() {
    final name = _nameController.text;

    return {
      'search': name,
      'nationality': _nationality?.index == Nationality.vietnamese.index,
      'specialties': _chosenSpecialtiesIndex == 0
          ? [].map((e) => e as String).toList()
          : [
              _specialties[_chosenSpecialtiesIndex]
                  .toLowerCase()
                  .replaceAll(' ', '-')
            ].map((e) => e as String).toList(),
    };
  }

  void _loadSpecialties() {
    _specialties = [
      'All',
      'Math',
      'History',
      'English',
      'Physics',
      'Chemistry'
    ];
  }

  @override
  Widget build(BuildContext context) {
    _loadSpecialties();
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Find a tutor',
              style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 8),
          TextField(
            controller: _nameController,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              hintStyle:
                  TextStyle(color: Theme.of(context).colorScheme.tertiary),
              hintText: "search by name",
              border: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.tertiary, width: 2),
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
            ),
          ),
          sizedBox,
          Text('Nationality',
              style: Theme.of(context).textTheme.headlineMedium),
          subSizedBox,
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
              const Text('Vietnamese Tutors'),
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
              const Text('Foreign Tutors'),
            ],
          ),
          sizedBox,
          Text('Specialties',
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
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6),
                  child: Text('Reset Filters', style: TextStyle(fontSize: 16)),
                ),
              ),
              sizedBox,
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    Routes.tutorSearchResult,
                    arguments: _encapsulateSearchParams(),
                  );
                },
                style: TextButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    'Search',
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
