import "package:cached_network_image/cached_network_image.dart";
import "package:flutter/material.dart";
import "package:flutter_project/utils/sized_box.dart";
import "package:provider/provider.dart";

import '../../../l10n/l10n.dart';
import "../../../models/course/course.dart";
import "../../../providers/auth_provider.dart";
import "../../../providers/language_provider.dart";
import "../../../services/course_and_ebook_service.dart";
import "../Topic/TopicCard/topic_card_widget.dart";

class CourseDetailScreen extends StatefulWidget {
  const CourseDetailScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<CourseDetailScreen> createState() => _CourseDetailScreenState();
}

class _CourseDetailScreenState extends State<CourseDetailScreen> {
  late final String courseId;
  late final Course courseDetail;

  bool _isLoading = true;

  late Locale currentLocale;

  @override
  void initState() {
    super.initState();
    currentLocale = context.read<LanguageProvider>().currentLocale;
    context.read<LanguageProvider>().addListener(() {
      setState(() {
        currentLocale = context.read<LanguageProvider>().currentLocale;
      });
    });
  }
  // test

  Future<void> _getCourseDetail(String token) async {
    final result = await CourseService.getCourseDetailById(
      token: token,
      courseId: courseId,
    );

    setState(() {
      courseDetail = result;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

    if (_isLoading && authProvider.token != null) {
      courseId = ModalRoute.of(context)!.settings.arguments as String;
      final String accessToken = authProvider.token?.access?.token as String;
      _getCourseDetail(accessToken);
    }

    return _isLoading
        ? const Center(child: CircularProgressIndicator())
    : Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        leading: BackButton(
          color: Theme.of(context).colorScheme.secondary,
        ),
        title: Text(
          'Course Detail',
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CachedNetworkImage(
              imageUrl: courseDetail.imageUrl ?? '',
              fit: BoxFit.cover,
              placeholder: (context, url) => Icon(
                Icons.image_rounded,
                size: 48,
                color: Theme.of(context).colorScheme.tertiary,
              ),
              errorWidget: (context, url, error) => const Icon(
                Icons.error_outline_rounded,
                size: 32,
                color: Colors.red,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Text(
                courseDetail.name ?? '',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                courseDetail.description ?? '',
                style: const TextStyle(fontSize: 16),
              ),
            ),
            sizedBox,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                AppLocalizations(currentLocale).translate('overview')!,
                style: Theme.of(context).textTheme.displaySmall,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Row(
                children: [
                  Icon(Icons.help_outline,
                      color: Theme.of(context).colorScheme.secondary),
                  const SizedBox(width: 8),
                  Text(
                    AppLocalizations(currentLocale)
                        .translate('whyTakeThisCourse')!,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 48, right: 16),
              child: Text(courseDetail.reason ?? ''),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Row(
                children: [
                  Icon(Icons.help_outline,
                      color: Theme.of(context).colorScheme.secondary),
                  const SizedBox(width: 8),
                  Text(
                    AppLocalizations(currentLocale)
                        .translate('whatWillYouAbleToDo')!,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 48, right: 16),
              child: Text(courseDetail.purpose ?? ''),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.group_add_outlined,
                          color: Theme.of(context).colorScheme.secondary),
                      const SizedBox(width: 8),
                      Text(
                        '${AppLocalizations(currentLocale).translate('experienceLevel')!}: ${courseDetail.level ?? '0'}',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.book_outlined,
                          color: Theme.of(context).colorScheme.secondary),
                      const SizedBox(width: 8),
                      Text(
                        '${AppLocalizations(currentLocale).translate('courseLength')!}: ${courseDetail.topics!.length} ${AppLocalizations(currentLocale).translate('topics')!}',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Text(
                AppLocalizations(currentLocale).translate('topicList')!,
                style: Theme.of(context).textTheme.displaySmall,
              ),
            ),
            ...List<Widget>.generate(
              courseDetail.topics?.length ?? 0,
              (index) => TopicCardWidget(
                index: index,
                topic: courseDetail.topics![index],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
