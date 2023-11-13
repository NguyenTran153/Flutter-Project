import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../utils/routes.dart';

class CourseItemScreen extends StatefulWidget {
  const CourseItemScreen({Key? key}) : super(key: key);

  @override
  State<CourseItemScreen> createState() => _CourseItemScreenState();
}

class _CourseItemScreenState extends State<CourseItemScreen> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          Routes.courseDetail,
          arguments: 'null courseId',
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8),
        clipBehavior: Clip.hardEdge,
        elevation: 2,
        surfaceTintColor: Theme.of(context).primaryColor,
        child: Column(
          children: [
            CachedNetworkImage(
              imageUrl:
                  'https://media.istockphoto.com/id/1154103408/vi/anh/anh-ch%C3%A0ng-giao-xe-%C4%91%E1%BA%A1p.jpg?s=1024x1024&w=is&k=20&c=-g4glbkJ3fxyEXcZm0OmaoTRLX2GEeSeZbq1dtdHDnk=',
              fit: BoxFit.cover,
              placeholder: (context, url) => const Icon(
                Icons.image_rounded,
                size: 48,
                color: Colors.grey,
              ),
              errorWidget: (context, url, error) => const Icon(
                Icons.error_outline_rounded,
                size: 32,
                color: Colors.redAccent,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'null course name',
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    'null course description',
                    style: TextStyle(
                        fontWeight: FontWeight.w400, color: Theme.of(context).colorScheme.tertiary),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'null course level',
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                      Text(
                        '5 lessons',
                        style: const TextStyle(fontSize: 18),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
