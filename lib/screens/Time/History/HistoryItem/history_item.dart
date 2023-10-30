import 'package:flutter/material.dart';
import 'package:flutter_project/utils/sized_box.dart';

import '../../../../utils/colors.dart';

class HistoryItem extends StatefulWidget {
  const HistoryItem({super.key});

  @override
  State<HistoryItem> createState() => _HistoryItemState();
}

class _HistoryItemState extends State<HistoryItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 12),
      surfaceTintColor: primaryColor,
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 72,
                  height: 72,
                  clipBehavior: Clip.hardEdge,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    "public/images/avatar.png",
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Icon(
                      Icons.error_outline_rounded,
                      size: 32,
                      color: dangerColor,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Tutor name",
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      subSizedBox,
                      Text(
                        "30/10/2023",
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "30/10/2023",
                        style: const TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            sizedBox,
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Text('No Requests For Lessons'),
            ),
            sizedBox,
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Text("Tutor haven't reviewed yet"),
            ),
            sizedBox,
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(foregroundColor: dangerColor),
                    onPressed: () {},
                    child: const Text(
                      'Report',
                      style: TextStyle(fontSize: 16, color: dangerColor),
                    ),
                  ),
                ),
                sizedBox,
                Expanded(
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Add A Review',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
