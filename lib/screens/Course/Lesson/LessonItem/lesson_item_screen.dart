import 'package:flutter/material.dart';
import 'package:flutter_project/screens/Course/Lesson/lesson_screen.dart';

class LessonItemScreen extends StatefulWidget {
  const LessonItemScreen({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  State<LessonItemScreen> createState() => _TopicItemScreenState();
}

class _TopicItemScreenState extends State<LessonItemScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
      child: Card(
        elevation: 1.5,
        surfaceTintColor: Theme.of(context).primaryColor,
        child: ListTile(
          title: Text('Lesson about Math'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LessonScreen(
                  title: 'Math',
                  url: 'https://www.africau.edu/images/default/sample.pdf',
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
