import 'package:flutter/material.dart';
import 'package:flutter_project/utils/sized_box.dart';

class FeedbackItemWidget extends StatelessWidget {
  const FeedbackItemWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                "https://plus.unsplash.com/premium_photo-1658527049634-15142565537a?q=80&w=1888&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.error_outline_rounded,
                  size: 32,
                  color: Colors.redAccent,
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
                        'null name',
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subSizedBox,
                      Text(
                        '${DateTime.now().difference(DateTime.parse('15/03/2023')).inDays} days ago',
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w400, color: Colors.grey),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      ...List<Widget>.generate(
                        4,
                            (index) => const Icon(Icons.star, size: 20, color: Colors.amber),
                      ),
                      ...List<Widget>.generate(
                        5 ,
                            (index) => Icon(Icons.star, size: 20, color: Theme.of(context).colorScheme.tertiary),
                      ),
                    ],
                  ),
                  subSizedBox,
                  Text('null content')
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
