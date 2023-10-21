import "package:flutter/material.dart";
import "package:flutter_project/screens/Homepage/tutorItem/tutor_item.dart";
import "package:flutter_project/screens/View/header.dart";

class HomepageScreen extends StatefulWidget {
  const HomepageScreen({super.key});

  @override
  State<HomepageScreen> createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<HomepageScreen> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Header(title: 'Home'),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              'Recommended Tutors',
              style: Theme.of(context).textTheme.displaySmall,
            ),
          ),
          _isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 8,
              itemBuilder: (context, index) {
                  return TutorItem();
              },
          )
        ],
      ),
    );
  }
}
