import 'package:flutter/material.dart';
import 'package:flutter_project/utils/sized_box.dart';

import '../../../../models/tutor/tutor_feedback.dart';

class ReviewCardWidget extends StatefulWidget {
  const ReviewCardWidget({   Key? key,
    required this.feedback,
  }) : super(key: key);

  final TutorFeedback feedback;

  @override
  State<ReviewCardWidget> createState() => _ReviewCardWidgetState();
}

class _ReviewCardWidgetState extends State<ReviewCardWidget> {
  @override
  Widget build(BuildContext context) {
    late final TutorFeedback feedback = widget.feedback;

    // late Locale currentLocale;
    //
    // @override
    // void initState() {
    //   super.initState();
    //
    //   currentLocale = context.read<LanguageProvider>().currentLocale;
    //   context.read<LanguageProvider>().addListener(() {
    //     setState(() {
    //       currentLocale = context.read<LanguageProvider>().currentLocale;
    //     });
    //   });
    // }

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      surfaceTintColor: Theme.of(context).primaryColor,
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 48,
              height: 48,
              margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              clipBehavior: Clip.hardEdge,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Image.network(
                feedback.firstInfo?.avatar ?? '',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.error_outline_rounded,
                  size: 32,
                  color: Colors.red,
                ),
              ),
            ),
            subSizedBox,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        feedback.firstInfo?.name ?? '',
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subSizedBox,
                      Text(
                        '${DateTime.now().difference(DateTime.parse(feedback.createdAt!)).inDays} days ago',                        style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w400, color: Colors.grey),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      ...List<Widget>.generate(
                        feedback.rating ?? 0,
                            (index) => const Icon(Icons.star, size: 20, color: Colors.amber),
                      ),
                      ...List<Widget>.generate(
                        5 - feedback.rating!.toInt(),
                            (index) => Icon(Icons.star, size: 20, color: Theme.of(context).colorScheme.tertiary),
                      ),
                    ],
                  ),
                  subSizedBox,
                  Text(feedback.content ?? '')
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

