import "package:cached_network_image/cached_network_image.dart";
import 'package:flutter/material.dart';
import "package:flutter_project/utils/sized_box.dart";

import "../../../../models/schedule/booking_info.dart";
import "../../../../utils/routes.dart";

class UpcomingClassWidget extends StatefulWidget {
  const UpcomingClassWidget(
      {Key? key, required this.bookingInfo, required this.onCancel})
      : super(key: key);

  final BookingInfo bookingInfo;
  final Function(bool cancelResult) onCancel;

  @override
  State<UpcomingClassWidget> createState() => _UpcomingClassWidgetState();
}

class _UpcomingClassWidgetState extends State<UpcomingClassWidget> {
  bool _isCardVisible = true;


  @override
  Widget build(BuildContext context) {
    return _isCardVisible
        ? Card(
      margin: const EdgeInsets.symmetric(vertical: 12),
      surfaceTintColor: Theme.of(context).primaryColor,
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 72,
                  height: 72,
                  clipBehavior: Clip.hardEdge,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: CachedNetworkImage(
                    imageUrl: 'https://picsum.photos/250?image=9',
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) => const Icon(
                      Icons.error_outline_rounded,
                      size: 32,
                      color: Colors.redAccent,
                    ),
                  ),
                ),
                sizedBox,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.bookingInfo.userId ?? "Tran Nam",
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      sizedBox,
                      Text(
                        widget.bookingInfo.createdAt ?? "07-05-2002",
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      const Text(
                        "12h00",
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.edit_note_outlined,
                    size: 32,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                )
              ],
            ),
            sizedBox,
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(foregroundColor: Colors.red,),
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
                              onPressed: () {
                                Navigator.pop(context, true);
                                // Ẩn Card khi cancel
                                setState(() {
                                  _isCardVisible = false;
                                });
                              },
                              child: const Text('YES'),
                            ),
                          ],
                        ),
                      );
                      if (dialogResult) {
                        const result = "Class Cancelled Successfully";
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            content: const Text(result),
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
    )
        : const SizedBox.shrink();
  }
}
