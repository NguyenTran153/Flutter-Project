
import 'package:flutter/material.dart';
import 'package:flutter_project/utils/sized_box.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../l10n.dart';
import '../../providers/language_provider.dart';

class BecomeTutorScreen extends StatefulWidget {
  const BecomeTutorScreen({Key? key}) : super(key: key);

  @override
  State<BecomeTutorScreen> createState() => _BecomeTutorScreenState();
}

class _BecomeTutorScreenState extends State<BecomeTutorScreen> {
  XFile? avatar;
  bool isUploaded = false;
  String imageUrl = 'https://as1.ftcdn.net/v2/jpg/01/04/93/90/1000_F_104939054_E7P5jaVoNYcXQI7YBrzsVWH2qZc03sn8.jpg';

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        imageUrl = pickedFile.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: BackButton(
          color: Colors.blue[600],
        ),
        title: Text(
          AppLocalizations(currentLocale).translate('becomeTutor')!,
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              AppLocalizations(currentLocale).translate('information')!,
              style: Theme.of(context).textTheme.displaySmall,
            ),
            Row(
              children: [
                Column(
                  children: [
                    InkWell(
                      onTap: _pickImage,
                      child: Image.asset(
                        'public/images/avatar.png',
                        width: 100,
                        height: 100,
                      ),
                    ),
                  ],
                ),
                sizedBox,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations(currentLocale).translate('name')!,
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
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.tertiary, width: 2),
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
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.tertiary, width: 2),
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
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.tertiary, width: 2),
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
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.tertiary, width: 2),
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
