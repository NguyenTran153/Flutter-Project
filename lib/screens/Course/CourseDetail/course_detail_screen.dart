import "package:cached_network_image/cached_network_image.dart";
import "package:flutter/material.dart";
import "package:flutter_project/utils/colors.dart";
import "package:flutter_project/utils/sized_box.dart";

class CourseDetailScreen extends StatefulWidget {
  const CourseDetailScreen({super.key});

  @override
  State<CourseDetailScreen> createState() => _CourseDetailScreenState();
}

class _CourseDetailScreenState extends State<CourseDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CachedNetworkImage(
              imageUrl:
                  'https://media.istockphoto.com/id/1154103408/vi/anh/anh-ch%C3%A0ng-giao-xe-%C4%91%E1%BA%A1p.jpg?s=1024x1024&w=is&k=20&c=-g4glbkJ3fxyEXcZm0OmaoTRLX2GEeSeZbq1dtdHDnk=',
              fit: BoxFit.cover,
              placeholder: (context, url) => const Icon(
                Icons.image_rounded,
                size: 48,
                color: tertiaryColor,
              ),
              errorWidget: (context, url, error) => const Icon(
                Icons.error_outline_rounded,
                size: 32,
                color: dangerColor,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Text(
                'Name',
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: blackColor,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Description',
                style: const TextStyle(fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  minimumSize: const Size.fromHeight(44),
                  backgroundColor: secondaryColor,
                ),
                child: const Text(
                  'Discover',
                  style: TextStyle(fontSize: 18, color: primaryColor),
                ),
              ),
            ),
            sizedBox,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Overview',
                style: Theme.of(context).textTheme.displaySmall,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Row(
                children: [
                  const Icon(Icons.help_outline, color: secondaryColor),
                  const SizedBox(width: 8),
                  Text(
                    'Why Take This Course?',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 48, right: 16),
              child: Text("Take this course for what?"),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Row(
                children: [
                  const Icon(Icons.help_outline, color: secondaryColor),
                  const SizedBox(width: 8),
                  Text(
                    'What will you be able to do?',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 48, right: 16),
              child: Text("Course purpose"),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Text(
                'Experience Level',
                style: Theme.of(context).textTheme.displaySmall,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Row(
                children: [
                  const Icon(Icons.group_add_outlined, color: secondaryColor),
                  const SizedBox(width: 8),
                  Text(
                    'Course level',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Text(
                'Course Length',
                style: Theme.of(context).textTheme.displaySmall,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Row(
                children: [
                  const Icon(Icons.book_outlined, color: secondaryColor),
                  const SizedBox(width: 8),
                  Text(
                    'Topics',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Text(
                'List Of Topics',
                style: Theme.of(context).textTheme.displaySmall,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
