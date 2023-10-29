import "package:chewie/chewie.dart";
import "package:flutter/material.dart";
import "package:flutter_project/utils/colors.dart";
import "package:flutter_project/utils/sized_box.dart";
import "package:video_player/video_player.dart";

import "../../../models/course.dart";
import "../../../utils/routes.dart";

class TutorDetailScreen extends StatefulWidget {
  const TutorDetailScreen({super.key});

  @override
  State<TutorDetailScreen> createState() => _TutorDetailScreenState();
}

class _TutorDetailScreenState extends State<TutorDetailScreen> {
  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;

  //Fake
  List<Course> courses = [
    Course(
      name: 'Lập trình Flutter',
      description: 'Khóa học học lập trình Flutter từ cơ bản đến nâng cao',
      price: 1000000,
    ),
    Course(
      name: 'Lập trình Android',
      description: 'Khóa học học lập trình Android từ cơ bản đến nâng cao',
      price: 2000000,
    ),
    Course(
      name: 'Lập trình iOS',
      description: 'Khóa học học lập trình iOS từ cơ bản đến nâng cao',
      price: 3000000,
    ),
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
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primaryColor,
        leading: BackButton(
          color: secondaryColor,
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
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Name of tutor",
                              style: Theme.of(context).textTheme.displaySmall,
                            ),
                            Text(
                              "Country",
                              style: const TextStyle(fontSize: 16),
                            ),
                            Row(
                              children: [
                                ...List<Widget>.generate(
                                  5,
                                  (index) => const Icon(Icons.star,
                                      color: Colors.amber),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  '13',
                                  style: const TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Text(
                      'Description about tutor',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () {},
                          child: Column(
                            children: [
                              const Icon(
                                Icons.favorite_rounded,
                                color: dangerColor,
                              ),
                              Text(
                                'Favorite',
                                style: TextStyle(
                                  color: dangerColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextButton(
                          onPressed: () {},
                          child: Column(
                            children: const [
                              Icon(Icons.reviews_outlined,
                                  color: secondaryColor),
                              Text('Reviews',
                                  style: TextStyle(color: secondaryColor))
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextButton(
                          onPressed: () {},
                          child: Column(
                            children: const [
                              Icon(Icons.report_outlined,
                                  color: secondaryColor),
                              Text('Report',
                                  style: TextStyle(color: secondaryColor))
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
                        border: Border.all(color: secondaryColor, width: 2),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    child: _chewieController == null
                        ? Text(
                            'No Introduction Video',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                              color: secondaryColor,
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
                            'Language',
                            style: const TextStyle(color: secondaryColor),
                          ),
                          backgroundColor: secondaryColor[50],
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
                        5,
                        (index) => Chip(
                          backgroundColor: secondaryColor[50],
                          label: Text(
                            "Math",
                            style: const TextStyle(
                                fontSize: 14, color: secondaryColor),
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
                            course.name,
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
                            side: const BorderSide(
                                color: Colors.blue, width: 1.5)),
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
                            builder: (BuildContext context) {
                              return Container();
                            },
                          );
                        },
                        child: const Text(
                          'Book This Tutor',
                          style: TextStyle(fontSize: 18, color: Colors.blue),
                        ),
                      ))
                ],
              ),
            ),
    );
  }
}
