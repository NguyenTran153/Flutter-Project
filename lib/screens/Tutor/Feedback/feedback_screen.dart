import 'package:flutter/material.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  @override
  Widget build(BuildContext context) {
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
          itemCount: 1,
          shrinkWrap: true,
          itemBuilder: (context, index) => Card(),
        ),
      ),
    );
  }
}
