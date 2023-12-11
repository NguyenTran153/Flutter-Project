import "package:chewie/chewie.dart";
import "package:flutter/material.dart";
import "package:flutter_project/models/tutor/tutor_feedback.dart";
import "package:flutter_project/screens/Tutor/Schedule/tutor_schedule_widget.dart";
import "package:flutter_project/utils/sized_box.dart";
import "package:video_player/video_player.dart";

import "../../../models/course/course.dart";
import "../../../models/tutor/tutor.dart";
import "../../../utils/routes.dart";

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
  bool _isFavorite = false;
  late List<String> _specialties;
  late Tutor _tutor;
  late List<TutorFeedback> feedbacks;

  Future<void> _getTutor() async {
  }

  //Fake
  List<Course> courses = [

  ];
  bool _isLoading = false;

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _getTutor();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        leading: BackButton(
          color: Theme.of(context).colorScheme.secondary,
        ),
        title: Text(
          'Teacher',
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
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
                        // child: Image.network(
                        //   _tutor.avatar,
                        //   fit: BoxFit.cover,
                        //   errorBuilder: (context, url, error) => const Icon(
                        //     Icons.error_outline_rounded,
                        //     size: 32,
                        //     color: Colors.redAccent,
                        //   ),
                        // ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "_tutor.name",
                              style: Theme.of(context).textTheme.displaySmall,
                            ),
                            Text(
                              "_tutor.country",
                              style: const TextStyle(fontSize: 16),
                            ),
                            _tutor.rating == null
                                ? const Text(
                                    'No reviews yet',
                                    style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      color: Colors.grey,
                                    ),
                                  )
                                : Row(children: [
                                    ...List<Widget>.generate(
                                      5,
                                      (index) => const Icon(Icons.star,
                                          color: Colors.amber),
                                    ),
                                    const SizedBox(width: 8),
                                    Text('1',
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
                      _tutor.specialties ?? '',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              _isFavorite = !_isFavorite;
                            });
                          },
                          child: Column(
                            children: [
                              _isFavorite
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
                                'Favorite',
                                style: TextStyle(
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
                              Text('Reviews',
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
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('Report Success'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('OK'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Column(
                            children: [
                              Icon(Icons.report_outlined,
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                              Text('Report',
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
                        border: Border.all(color: Theme.of(context).colorScheme.secondary, width: 2),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    child: _chewieController == null
                        ? Text(
                            'No Introduction Video',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          )
                        : Chewie(controller: _chewieController!),
                  ),
                  subSizedBox,
                  Text('Languages',
                      style: Theme.of(context).textTheme.displaySmall),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Wrap(
                      spacing: 8,
                      runSpacing: -4,
                      children: List<Widget>.generate(
                        5,
                        (index) => Chip(
                          label: Text(
                            '_tutor.language',
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary),
                          ),
                          backgroundColor: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ),
                  subSizedBox,
                  Text('Specialties',
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
                  subSizedBox,
                  Text('Suggested Courses',
                      style: Theme.of(context).textTheme.displaySmall),
                  ...courses.map(
                    (course) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "course.name",
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          const SizedBox(width: 16),
                          TextButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, Routes.courseDetail);
                              },
                              child: const Text('View'))
                        ],
                      ),
                    ),
                  ),
                  sizedBox,
                  Text('Interests',
                      style: Theme.of(context).textTheme.displaySmall),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 8),
                    child: Text('I love the weather'),
                  ),
                  sizedBox,
                  Text('Teaching Experiences',
                      style: Theme.of(context).textTheme.displaySmall),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 8),
                    child: Text('I have more than 10 years'),
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
                            builder: (context) => TutorScheduleWidget(),
                          );
                        },
                        child: Text(
                          'Book This Tutor',
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
