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
                      child: Image.asset(
                        widget.tutor.avatar ?? "public/images/avatar.png",
                        fit: BoxFit.cover,
                        errorBuilder: (BuildContext context, Object error,
                            StackTrace? stackTrace) {
                          return const Icon(
                            Icons.error_outline_rounded,
                            color: Colors.red,
                            size: 32,
                          );
                        },
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
                              widget.tutor.name ?? "Noname",
                              style: Theme.of(context).textTheme.displaySmall,
                            ),
                          ),
                          Text( widget.tutor.country ?? 'Country', style: const TextStyle(fontSize: 16)),
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
                    onPressed: () {},
                    icon: const Icon(
                      Icons.favorite_rounded,
                    ),
                  ),
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
