import 'package:flutter/material.dart';
import 'package:flutter_project/utils/sized_box.dart';

import '../../../models/tutor.dart';
import '../../../utils/routes.dart';

class TutorItem extends StatefulWidget {
  const TutorItem({
    Key? key,
    required this.tutor,
  }) : super(key: key);


  final Tutor tutor;

  @override
  State<TutorItem> createState() => _TutorItemState();
}

class _TutorItemState extends State<TutorItem> {
  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Card(
        surfaceTintColor: Theme.of(context).primaryColor,
        elevation: 3.0,
        margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () {},
                    child: Container(
                      width: 72,
                      height: 72,
                      clipBehavior: Clip.hardEdge,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Image.network(
                        widget.tutor.avatar ??
                            'https://khoanh24.com/uploads/w750/2020/03/23/avatar-facebook-mac-dinh-nen-thay-doi-tien-do_75d21ddca.jpg',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => const Icon(
                          Icons.error_outline_rounded,
                          color: Colors.red,
                          size: 32,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                Routes.teacherDetail,
                              );
                            },
                            child: Text(
                              widget.tutor.name,
                              style: Theme.of(context).textTheme.displaySmall,
                            ),
                          ),
                          Text( widget.tutor.country, style: const TextStyle(fontSize: 16)),
                          widget.tutor.rating == null
                              ? Text(
                            'No reviews yet',
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              color:
                              Theme.of(context).colorScheme.tertiary,
                            ),
                          )
                              : Row(
                            children: List<Widget>.generate(
                              widget.tutor.rating!.round(),
                                  (index) => const Icon(Icons.star,
                                  color: Colors.amber),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _isFavorite = !_isFavorite;
                      });
                    },
                    icon: _isFavorite
                        ? const Icon(
                      Icons.favorite_rounded,
                      color: Colors.red,
                    )
                        : Icon(
                      Icons.favorite_border_rounded,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  )
                ],
              ),
              subSizedBox,
              Wrap(
                spacing: 8,
                runSpacing: -4,
                children: (widget.tutor.specialties ?? "")
                    .split(', ')
                    .map((specialty) => Chip(
                  backgroundColor: Colors.lightBlue[50],
                  label: Text(
                    specialty.trim(), // Remove leading/trailing whitespaces
                    style: const TextStyle(fontSize: 14, color: Colors.blue),
                  ),
                ))
                    .toList(),
              ),

              subSizedBox,
              Text(
                 'Description about tutor',
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.edit_calendar),
                  label: const Text('Book'),
                ),
              )
            ],
          ),
        ));
  }
}
