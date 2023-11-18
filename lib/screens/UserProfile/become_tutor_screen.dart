import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/utils/sized_box.dart';

class BecomeTutorScreen extends StatefulWidget {
  const BecomeTutorScreen({super.key});

  @override
  State<BecomeTutorScreen> createState() => _BecomeTutorScreenState();
}

class _BecomeTutorScreenState extends State<BecomeTutorScreen> {
  String imageUrl = 'https://as1.ftcdn.net/v2/jpg/01/04/93/90/1000_F_104939054_E7P5jaVoNYcXQI7YBrzsVWH2qZc03sn8.jpg';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: BackButton(
          color: Colors.blue[600],
        ),
        title: Text(
          'Become Tutor',
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Basic Info',
              style: Theme.of(context).textTheme.displaySmall,
            ),
            Row(
              children: [
                Column(
                  children: [
                    Container(
                      width: 108,
                      height: 108,
                      clipBehavior: Clip.hardEdge,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: CachedNetworkImage(
                        imageUrl:
                        imageUrl,
                        placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                        const Icon(Icons.person_rounded),
                        fit: BoxFit.cover,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text('Upload'),
                    ),
                  ],
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tutoring Name',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 2),
                      const TextField(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 4,
                            horizontal: 8,
                          ),
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 2),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'I am from',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      subSizedBox,
                      const TextField(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 4,
                            horizontal: 8,
                          ),
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 2),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                      ),
                      subSizedBox,
                      Text(
                        'Date of Birth',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      subSizedBox,
                    ],
                  ),
                )
              ],
            ),
            sizedBox,
            Text(
              'CV',
              style: Theme.of(context).textTheme.displaySmall,
            ),
            subSizedBox,
            Text(
              'Interests',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            subSizedBox,
            const TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  vertical: 4,
                  horizontal: 8,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
            subSizedBox,
            Text(
              'Education',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            subSizedBox,
            const TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  vertical: 4,
                  horizontal: 8,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
            subSizedBox,
            Text(
              'Experience',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            subSizedBox,
            const TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  vertical: 4,
                  horizontal: 8,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
            subSizedBox,
            Text(
              'Current or Previous Profession',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            subSizedBox,
            TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  vertical: 4,
                  horizontal: 8,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).colorScheme.tertiary, width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
            subSizedBox,
            Text(
              'Certificate',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            TextButton(
              onPressed: () {},
              child: const Text('Add New Certificate'),
            ),
            sizedBox,
            Text(
              'Languages I speak',
              style: Theme.of(context).textTheme.displaySmall,
            ),
            subSizedBox,
            Text(
              'Languages',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            subSizedBox,
            TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  vertical: 4,
                  horizontal: 8,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).colorScheme.tertiary, width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Who I teach',
              style: Theme.of(context).textTheme.displaySmall,
            ),
            const SizedBox(height: 8),
            Text(
              'Introduction',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            subSizedBox,
            TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  vertical: 4,
                  horizontal: 8,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).colorScheme.tertiary, width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
            sizedBox,
            Text(
              'I am best at teaching students who are',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            subSizedBox,
            TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  vertical: 4,
                  horizontal: 8,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).colorScheme.tertiary, width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
            sizedBox,
            Text(
              'My specialties are',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            subSizedBox,
            TextField(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 4,
                  horizontal: 8,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.tertiary, width: 2),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
            sizedBox,
            Text(
              'Introduction Video',
              style: Theme.of(context).textTheme.displaySmall,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: TextButton(
                onPressed: () {},
                child: const Text('Choose Video'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24, bottom: 12),
              child: TextButton(
                style: TextButton.styleFrom(
                    minimumSize: const Size.fromHeight(48),
                    backgroundColor: Theme.of(context).colorScheme.secondary),
                onPressed: () {},
                child: Text(
                  'Done',
                  style: TextStyle(
                    fontSize: 20,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
