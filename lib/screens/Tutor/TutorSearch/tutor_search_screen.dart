import 'package:flutter/material.dart';
import 'package:flutter_project/models/tutor.dart';
import 'package:flutter_project/utils/colors.dart';
import 'package:flutter_project/utils/sized_box.dart';

import '../../../utils/routes.dart';

class TutorSearchScreen extends StatefulWidget {
  const TutorSearchScreen({Key? key}) : super(key: key);

  @override
  State<TutorSearchScreen> createState() => _TutorSearchScreenState();
}

class _TutorSearchScreenState extends State<TutorSearchScreen> {
  final _nameController = TextEditingController();
  List<String> _specialties = [];
  int _chosenSpecialtiesIndex = 0;

  List<Tutor> tutors = getTutors();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Find a tutor', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 8),
          TextField(
            controller: _nameController,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              hintStyle: TextStyle(color: tertiaryColor),
              hintText: "search by name",
              border: const OutlineInputBorder(
                  borderSide: BorderSide(color: tertiaryColor, width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
            ),
          ),
          const SizedBox(height: 16),
          Text('Nationality', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 4),
          Row(
            children: [
              // Radio(value: value, groupValue: groupValue, onChanged: onChanged)
              const Text('Vietnamese Tutors'),
            ],
          ),
          Row(
            children: [
              // Radio(value: value, groupValue: groupValue, onChanged: onChanged)
              const Text('Foreign Tutors'),
            ],
          ),
          sizedBox,
          Text('Specialties', style: Theme.of(context).textTheme.headlineMedium),
          subSizedBox,
          Wrap(
            spacing: 8,
            runSpacing: -4,
            children: List<Widget>.generate(
              _specialties.length,
                  (index) => ChoiceChip(
                backgroundColor: tertiaryColor,
                selectedColor: secondaryColor,
                selected: _chosenSpecialtiesIndex == index,
                label: Text(
                  _specialties[index],
                  style: TextStyle(
                    fontSize: 14,
                    color: _chosenSpecialtiesIndex == index ? secondaryColor : tertiaryColor,
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
                  );
                },
                style: TextButton.styleFrom(
                  backgroundColor: secondaryColor,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    'Search',
                    style: TextStyle(fontSize: 16, color: Theme.of(context).primaryColor),
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
