import 'package:flutter/material.dart';
import "package:flutter_project/utils/colors.dart";
import "package:flutter_project/utils/sized_box.dart";

import "../../../../utils/routes.dart";

class UpcomingClassWidget extends StatefulWidget {
  const UpcomingClassWidget({super.key});

  @override
  State<UpcomingClassWidget> createState() => _UpcomingClassWidgetState();
}

class _UpcomingClassWidgetState extends State<UpcomingClassWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 12),
      surfaceTintColor: primaryColor,
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
        child: Column(
          children: [
            Row(
              children: [
                const CircleAvatar(
                  backgroundImage: AssetImage("public/images/avatar.png"),
                  radius: 32,
                ),
                Container(
                  width: 72,
                  height: 72,
                  clipBehavior: Clip.hardEdge,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                ),
                sizedBox,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Name",
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      sizedBox,
                      const Text(
                        "07-05-2002",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      const Text(
                        "12h49",
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.edit_note_outlined,
                    size: 32,
                    color: secondaryColor,
                  ),
                )
              ],
            ),
            sizedBox,
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(foregroundColor: dangerColor),
                    onPressed: () async {
                      final dialogResult = await showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Cancel class'),
                          content:
                          const Text('Are you sure to cancel this class?'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context, false),
                              child: const Text('NO'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(context, true),
                              child: const Text('YES'),
                            ),
                          ],
                        ),
                      );
                      if (dialogResult) {
                        final result = "Class Cancelled Successfully";
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            content: Text(result),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  if (result ==
                                      "Class Cancelled Successfully") {}
                                  Navigator.pop(context, false);
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                    child: const Text(
                      'Cancel',
                      style: TextStyle(fontSize: 16, color: Colors.red),
                    ),
                  ),
                ),
                sizedBox,
                Expanded(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, Routes.videoCall);
                      },
                      child: const Text(
                        'Go to meeting',
                        style: TextStyle(fontSize: 16),
                      ),
                    ))
              ],
            ),
          ],
        ),
      ),
    );

  }
}
