import 'package:flutter/material.dart';
import 'package:flutter_project/models/schedule/booking_info.dart';
import 'package:flutter_project/utils/sized_box.dart';


class HistoryWidget extends StatefulWidget {
  const HistoryWidget({Key? key, required this.bookingInfo}) : super(key: key);

  final BookingInfo bookingInfo;

  @override
  State<HistoryWidget> createState() => _HistoryWidgetState();
}

class _HistoryWidgetState extends State<HistoryWidget> {

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 12),
      surfaceTintColor: Theme.of(context).primaryColor,
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
                  child: Image.network(

                        'https://khoanh24.com/uploads/w750/2020/03/23/avatar-facebook-mac-dinh-nen-thay-doi-tien-do_75d21ddca.jpg',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const Icon(
                      Icons.error_outline_rounded,
                      color: Colors.red,
                      size: 32,
                    ),
                  ),
                ),
                sizedBox,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "tutor.name",
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      subSizedBox,
                      Text(
                        widget.bookingInfo.createdAt ?? "07-05-2002",
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      Text(
                         "12h00",
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
                    style: TextButton.styleFrom(foregroundColor: Colors.red),
                    onPressed: () {},
                    child: const Text(
                      'Report',
                      style: TextStyle(fontSize: 16, color: Colors.red),
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
