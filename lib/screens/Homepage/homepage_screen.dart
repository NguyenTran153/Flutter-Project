import "package:flutter/material.dart";
import "package:flutter_project/screens/Homepage/tutorItem/tutor_item.dart";

class HomepageScreen extends StatefulWidget {
  const HomepageScreen({super.key});

  @override
  State<HomepageScreen> createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<HomepageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              'Recommended Tutors',
              style: Theme.of(context).textTheme.displaySmall,
            ),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemCount: 4,
              itemBuilder: (context, index) {
                return TutorItem();
              },
            ),
          ),
        ],
      ),
    );
  }
}
