import 'package:flutter/material.dart';
import 'package:flutter_project/utils/colors.dart';
import 'package:flutter_project/utils/sized_box.dart';

class TutorSearchItemScreen extends StatefulWidget {
  const TutorSearchItemScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<TutorSearchItemScreen> createState() => _TutorSearchItemScreenState();
}

class _TutorSearchItemScreenState extends State<TutorSearchItemScreen> {
  @override
  Widget build(BuildContext context) {
    return Card(
      surfaceTintColor: primaryColor,
      elevation: 3.0,
      margin: const EdgeInsets.symmetric(vertical: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                  child: Image.asset(
                    "public/images/avatar.png",
                    fit: BoxFit.cover,
                    errorBuilder: (context, url, error) => const Icon(
                      Icons.error_outline_rounded,
                      size: 32,
                      color: Colors.redAccent,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Trần Nguyên',
                            style: Theme.of(context).textTheme.displaySmall),
                        Text('Vietname',
                            style: const TextStyle(fontSize: 16)),
                        Row(
                          children: List<Widget>.generate(
                            5,
                            (index) =>
                                const Icon(Icons.star, color: Colors.amber),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () async {},
                  icon: true ?? false
                      ? const Icon(
                          Icons.favorite_rounded,
                          color: dangerColor,
                        )
                      : const Icon(
                          Icons.favorite_border_rounded,
                          color: secondaryColor,
                        ),
                )
              ],
            ),
            subSizedBox,
            Wrap(
              spacing: 8,
              runSpacing: -4,
              children: List<Widget>.generate(
                2,
                (index) => Chip(
                  backgroundColor: secondaryColor[50],
                  label: Text(
                    "Math",
                    style: const TextStyle(fontSize: 14, color: secondaryColor),
                  ),
                ),
              ),
            ),
            subSizedBox,
            Text(
              'Dạy toán',
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
