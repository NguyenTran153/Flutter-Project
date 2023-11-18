import 'package:flutter/material.dart';
import 'package:flutter_project/utils/colors.dart';
import 'package:flutter_project/utils/sized_box.dart';

import '../../../../models/tutor.dart';

class TutorSearchItemScreen extends StatefulWidget {
  const TutorSearchItemScreen({
    Key? key,
    required this.tutor,
  }) : super(key: key);

  final Tutor tutor;

  @override
  State<TutorSearchItemScreen> createState() => _TutorSearchItemScreenState();
}

class _TutorSearchItemScreenState extends State<TutorSearchItemScreen> {
  late List<String> _specialties;

  @override
  void initState() {
    super.initState();
    // Extract specialties from the tutor's specialties property
    String specialtiesString = widget.tutor.specialties ?? '';
    _specialties = specialtiesString.split(',').map((s) => s.trim()).toList();
  }

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
                  child: Image.network(
                    widget.tutor.avatar ?? 'https://khoanh24.com/uploads/w750/2020/03/23/avatar-facebook-mac-dinh-nen-thay-doi-tien-do_75d21ddca.jpg',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const Icon(
                      Icons.error_outline_rounded,
                      color: Colors.red,
                      size: 32,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.tutor.name ?? 'null name',
                            style: Theme.of(context).textTheme.displaySmall),
                        Text(widget.tutor.country ?? 'unknown country',
                            style: const TextStyle(fontSize: 16)),
                        widget.tutor.rating == null
                            ? Text(
                          'No reviews yet',
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                        )
                        : Row(
                          children: List<Widget>.generate(
                            widget.tutor.rating!.round(),
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
                _specialties.length,
                (index) => Chip(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  label: Text(
                    _specialties[index],
                    style: TextStyle(fontSize: 14, color: Theme.of(context).colorScheme.tertiary),
                  ),
                ),
              ),
            ),
            subSizedBox,
            Text(
              widget.tutor.language ?? 'null',
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
