import "package:cached_network_image/cached_network_image.dart";
import "package:chewie/chewie.dart";
import "package:flutter/material.dart";
import "package:flutter_project/models/tutor/tutor_feedback.dart";
import "package:flutter_project/providers/auth_provider.dart";
import "package:flutter_project/screens/Tutor/Schedule/tutor_schedule_widget.dart";
import "package:flutter_project/utils/sized_box.dart";
import "package:provider/provider.dart";
import "package:video_player/video_player.dart";

import "../../../constants/constant.dart";
import '../../../l10n/l10n.dart';
import "../../../models/course/course.dart";
import "../../../models/tutor/tutor_info.dart";
import "../../../providers/language_provider.dart";
import "../../../services/tutor_service.dart";
import "../../../utils/routes.dart";
import "../Messenger/messenger_screen.dart";

class TutorDetailScreen extends StatefulWidget {
  const TutorDetailScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<TutorDetailScreen> createState() => _TutorDetailScreenState();
}

class _TutorDetailScreenState extends State<TutorDetailScreen> {
  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;

  late TutorInfo _tutorInfo;
  late final List<String> _specialties;
  late final List<String> languages;
  late final List<TutorFeedback?> feedbacks;
  late final List<Course> courses = [];
  late String userId;

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

  Future<void> _getTutor(AuthProvider authProvider) async {
    final String token = authProvider.token?.access?.token as String;

    final result = await TutorService.getTutorInformationById(
      token: token,
      userId: userId,
    );

    if (_isLoading) {
      final learnTopics = authProvider.learnTopics
          .where((topic) =>
              result.specialties?.split(',').contains(topic.key) ?? false)
          .map((e) => e.name ?? 'null');
      final testPreparations = authProvider.testPreparations
          .where((test) =>
              result.specialties?.split(',').contains(test.key) ?? false)
          .map((e) => e.name ?? 'null');
      _specialties = [...learnTopics, ...testPreparations];
      languages = result.languages?.split(',') ?? ['null'];
    }
    if (mounted) {
      setState(() {
        _tutorInfo = result;
        _isLoading = false;
        _videoPlayerController =
            VideoPlayerController.networkUrl(Uri.parse(_tutorInfo.video ?? ''));
        _chewieController = ChewieController(
          videoPlayerController: _videoPlayerController!,
          aspectRatio: 2 / 3,
          autoPlay: true,
        );
      });
    }
  }

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  Future<bool> showReportDialog(BuildContext context) async {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(AppLocalizations(currentLocale).translate('report')!),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
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
                      child: CachedNetworkImage(
                        imageUrl:  _tutorInfo.user?.avatar ?? '',
                        fit: BoxFit.cover,
                        errorWidget: (context, url, error) => const Icon(
                          Icons.error_outline_rounded,
                          size: 32,
                          color: Colors.red,
                        ),
                      ),
                    ),

                    sizedBox,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _tutorInfo.user?.name ?? '',
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          subSizedBox,
                        ],
                      ),
                    ),
                  ],
                ),
                sizedBox,
                Text(
                  'Please tell us what went wrong',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                subSizedBox,
                TextField(
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(12),
                      border: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10))),
                ),
                subSizedBox,
                TextField(
                  minLines: 3,
                  maxLines: 4,
                  decoration: InputDecoration(
                      hintText: 'Additional Notes',
                      contentPadding: const EdgeInsets.all(12),
                      border: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10))),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: Text(
                AppLocalizations(currentLocale)
                    .translate('cancel')!,
                style: const TextStyle(fontSize: 18),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text(
                'OK',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        );
      },
    ).then((value) => value ?? false);
  }


  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

    if (_isLoading && authProvider.token != null) {
      final data = ModalRoute.of(context)?.settings.arguments as Map;
      userId = data['userId'];
      feedbacks = data['tutor'].feedbacks ?? [];

      _getTutor(authProvider);
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
                AppLocalizations(currentLocale).translate('tutor')!,
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 70,
                        height: 70,
                        clipBehavior: Clip.hardEdge,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: CachedNetworkImage(
                          imageUrl: _tutorInfo.user?.avatar ?? '',
                          fit: BoxFit.cover,
                          errorWidget: (context, url, error) => const Icon(
                            Icons.error_outline_rounded,
                            size: 32,
                            color: Colors.red,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _tutorInfo.user?.name ?? '',
                              style: Theme.of(context).textTheme.displaySmall,
                            ),
                            Text(
                              countries[_tutorInfo.user?.country] ??
                                  AppLocalizations(currentLocale)
                                      .translate('unknownCountry')!,
                              style: const TextStyle(fontSize: 16),
                            ),
                            _tutorInfo.rating == null
                                ? Text(
                                    AppLocalizations(currentLocale)
                                        .translate('noReview')!,
                                    style: const TextStyle(
                                      fontStyle: FontStyle.italic,
                                      color: Colors.grey,
                                    ),
                                  )
                                : Row(children: [
                                    ...List<Widget>.generate(
                                      _tutorInfo.rating?.round() ?? 0,
                                      (index) => const Icon(Icons.star,
                                          color: Colors.amber),
                                    ),
                                    const SizedBox(width: 8),
                                    Text('(${_tutorInfo.totalFeedback})',
                                        style: const TextStyle(fontSize: 18))
                                  ])
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Text(
                      _tutorInfo.bio ?? '',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () async {
                            if (authProvider.token != null) {
                              final String accessToken =
                                  authProvider.token?.access?.token as String;
                              await TutorService.addTutorToFavorite(
                                token: accessToken,
                                userId: userId,
                              );
                              _getTutor(authProvider);
                            }
                            // print('IS FAVORITE (DETAIL): ${_tutorInfo.isFavorite}');
                          },
                          child: Column(
                            children: [
                              _tutorInfo.isFavorite!
                                  ? const Icon(
                                      Icons.favorite_rounded,
                                      color: Colors.red,
                                    )
                                  : Icon(
                                      Icons.favorite_border_rounded,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                    ),
                              Text(
                                AppLocalizations(currentLocale)
                                    .translate('favorite')!,
                                style: const TextStyle(
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, Routes.review,
                                arguments: feedbacks);
                          },
                          child: Column(
                            children: [
                              Icon(Icons.reviews_outlined,
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                              Text(
                                  AppLocalizations(currentLocale)
                                      .translate('review')!,
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary))
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        MessengerScreen(tutorId: userId,)));
                          },
                          child: Column(
                            children: [
                              Icon(Icons.message,
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                              Text(
                                AppLocalizations(currentLocale)
                                    .translate('messenger')!,
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary),
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextButton(
                          onPressed: () async {
                            await showReportDialog(context);
                          },
                          child: Column(
                            children: [
                              Icon(Icons.report_outlined,
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                              Text(
                                  AppLocalizations(currentLocale)
                                      .translate('report')!,
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary))
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    height: 300,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Theme.of(context).colorScheme.secondary,
                            width: 2),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    child: _chewieController != null
                        ? Text(
                            AppLocalizations(currentLocale)
                                .translate('noVideo')!,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          )
                        : Chewie(controller: _chewieController!),
                  ),
                  subSizedBox,
                  Text(AppLocalizations(currentLocale).translate('language')!,
                      style: Theme.of(context).textTheme.displaySmall),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Wrap(
                      spacing: 8,
                      runSpacing: -4,
                      children: List<Widget>.generate(
                        languages.length,
                        (index) => Chip(
                          label: Text(
                            languageList[languages[index]]?['name'] ??
                                AppLocalizations(currentLocale)
                                    .translate('unknown')!,
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary),
                          ),
                          backgroundColor: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ),
                  subSizedBox,
                  Text(
                      AppLocalizations(currentLocale).translate('specialties')!,
                      style: Theme.of(context).textTheme.displaySmall),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Wrap(
                      spacing: 8,
                      runSpacing: -4,
                      children: List<Widget>.generate(
                        _specialties.length,
                        (index) => Chip(
                          backgroundColor: Theme.of(context).primaryColor,
                          label: Text(
                            _specialties[index],
                            style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(context).colorScheme.secondary),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Text('Suggested Courses',
                  //     style: Theme.of(context).textTheme.displaySmall),
                  // ...courses.map(
                  //   (course) => Padding(
                  //     padding: const EdgeInsets.symmetric(horizontal: 12),
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //       children: [
                  //         Text(
                  //           "course.name",
                  //           style: Theme.of(context).textTheme.headlineMedium,
                  //         ),
                  //         const SizedBox(width: 16),
                  //         TextButton(
                  //             onPressed: () {
                  //               Navigator.pushNamed(
                  //                   context, Routes.courseDetail);
                  //             },
                  //             child: const Text('View'))
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  sizedBox,
                  Text(AppLocalizations(currentLocale).translate('interests')!,
                      style: Theme.of(context).textTheme.displaySmall),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 8),
                    child: Text(_tutorInfo.interests ?? ''),
                  ),
                  sizedBox,
                  Text(
                      AppLocalizations(currentLocale)
                          .translate('experienceLevel')!,
                      style: Theme.of(context).textTheme.displaySmall),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 8),
                    child: Text(_tutorInfo.experience ?? ''),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 24, bottom: 12),
                      child: OutlinedButton(
                        style: TextButton.styleFrom(
                            minimumSize: const Size.fromHeight(0),
                            padding: const EdgeInsets.all(8),
                            side: BorderSide(
                                color: Theme.of(context).colorScheme.secondary,
                                width: 1.5)),
                        onPressed: () async {
                          await showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            elevation: 5,
                            clipBehavior: Clip.hardEdge,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(16),
                              ),
                            ),
                            builder: (context) =>
                                TutorScheduleWidget(userId: userId),
                          );
                        },
                        child: Text(
                          AppLocalizations(currentLocale).translate('book')!,
                          style: TextStyle(
                              fontSize: 18,
                              color: Theme.of(context).colorScheme.secondary),
                        ),
                      ))
                ],
              ),
            ),
          );
  }
}
