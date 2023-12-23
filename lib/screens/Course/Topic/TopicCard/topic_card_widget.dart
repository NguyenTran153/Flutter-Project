import 'package:flutter/material.dart';
import 'package:flutter_project/screens/Course/Topic/topic_screen.dart';

import '../../../../models/course/course_topic.dart';

class TopicCardWidget extends StatefulWidget {
  const TopicCardWidget({
    Key? key,
    required this.index,
    required this.topic,
  }) : super(key: key);

  final int index;
  final CourseTopic topic;

  @override
  State<TopicCardWidget> createState() => _TopicCardWidgetState();
}

class _TopicCardWidgetState extends State<TopicCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
      child: Card(
        elevation: 1.5,
        surfaceTintColor: Theme.of(context).primaryColor,
        child: ListTile(
          title: Text('${widget.index + 1}. ${widget.topic.name}'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TopicScreen(
                  title: widget.topic.name ?? '',
                  url: widget.topic.nameFile ?? '',
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
