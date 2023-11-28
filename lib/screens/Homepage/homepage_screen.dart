import "package:flutter/material.dart";
import "package:flutter_project/screens/Homepage/tutorItem/tutor_item.dart";

import "../../models/tutor.dart";

class HomepageScreen extends StatefulWidget {
  const HomepageScreen({super.key});

  @override
  State<HomepageScreen> createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<HomepageScreen> {
  List<Tutor> _tutors = [];

  void _getTutors() {
    final result = getTutors();

    setState(() {
      _tutors = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    _getTutors();
    return Scaffold(
      backgroundColor: Theme
          .of(context)
          .primaryColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              'Recommended Tutors',
              style: Theme
                  .of(context)
                  .textTheme
                  .displaySmall,
            ),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemCount: _tutors.length,
              itemBuilder: (context, index) {
                return TutorItem(tutor: _tutors[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
