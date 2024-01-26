import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/utils/sized_box.dart';
import 'package:provider/provider.dart';

import '../../../l10n/l10n.dart';
import '../../../models/course/course.dart';
import '../../../providers/language_provider.dart';
import '../../../utils/routes.dart';

class CourseCardWidget extends StatefulWidget {
  const CourseCardWidget({
    Key? key,
    required this.course,
  }) : super(key: key);

  final Course course;

  @override
  State<CourseCardWidget> createState() => _CourseCardWidgetState();
}

class _CourseCardWidgetState extends State<CourseCardWidget> {
  late final Course course;
  late Locale currentLocale;

  @override
  void initState() {
    super.initState();
    course = widget.course;
    currentLocale = context.read<LanguageProvider>().currentLocale;
    context.read<LanguageProvider>().addListener(() {
      setState(() {
        currentLocale = context.read<LanguageProvider>().currentLocale;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          Routes.courseDetail,
          arguments: course.id ?? '',
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
              imageUrl: course.imageUrl ?? '',
              fit: BoxFit.cover,
              placeholder: (context, url) => const Icon(
                Icons.image_rounded,
                size: 48,
                color: Colors.grey,
              ),
              errorWidget: (context, url, error) => const Icon(
                Icons.error_outline_rounded,
                size: 32,
                color: Colors.red,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    course.name ??
                        AppLocalizations(currentLocale).translate('null')!,
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    course.description ??
                        AppLocalizations(currentLocale).translate('null')!,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).colorScheme.tertiary),
                  ),
                  // Test
                  sizedBox,
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          course.level ??
                              AppLocalizations(currentLocale)
                                  .translate('null')!,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),

                      Text(
                        '${course.topics!.length} lessons',
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
