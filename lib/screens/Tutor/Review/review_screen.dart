import 'package:flutter/material.dart';
import 'package:flutter_project/screens/Tutor/Review/ReviewCard/review_card_widget.dart';

import '../../../models/tutor/tutor_feedback.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({Key? key}) : super(key: key);

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  @override
  Widget build(BuildContext context) {
    final feedbacks = ModalRoute.of(context)?.settings.arguments as List<TutorFeedback>;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        leading: BackButton(
          color: Theme.of(context).colorScheme.secondary,
        ),
        title: Text(
          'Reviews',
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: feedbacks.length,
          shrinkWrap: true,
          itemBuilder: (context, index) => ReviewCardWidget(feedback: feedbacks[feedbacks.length-index-1],),
        ),
      ),
    );
  }
}
