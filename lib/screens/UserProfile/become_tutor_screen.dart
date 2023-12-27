import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/providers/auth_provider.dart';
import 'package:flutter_project/services/become_teacher_service.dart';
import 'package:flutter_project/utils/sized_box.dart';
import 'package:provider/provider.dart';

import '../../l10n.dart';
import '../../providers/language_provider.dart';

class BecomeTutorScreen extends StatefulWidget {
  const BecomeTutorScreen({Key? key}) : super(key: key);

  @override
  State<BecomeTutorScreen> createState() => _BecomeTutorScreenState();
}

class _BecomeTutorScreenState extends State<BecomeTutorScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController birthdayController = TextEditingController();
  TextEditingController interestsController = TextEditingController();
  TextEditingController educationController = TextEditingController();
  TextEditingController experienceController = TextEditingController();
  TextEditingController professionController = TextEditingController();
  TextEditingController languagesController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController targetStudentsController = TextEditingController();
  TextEditingController specialtiesController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  File? avatar;
  File? video;
  bool isUploaded = false;
  String imageUrl =
      'https://as1.ftcdn.net/v2/jpg/01/04/93/90/1000_F_104939054_E7P5jaVoNYcXQI7YBrzsVWH2qZc03sn8.jpg';
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

  Future<void> _submitForm(AuthProvider authProvider) async {
    try {
      int price = int.tryParse(priceController.text) ?? 0;

      await BecomeTeacherService.becomeTeacher(
        name: nameController.text,
        country: countryController.text,
        birthday: birthdayController.text,
        interests: interestsController.text,
        education: educationController.text,
        experience: experienceController.text,
        profession: professionController.text,
        languages: languagesController.text,
        bio: bioController.text,
        targetStudents: targetStudentsController.text,
        specialties: specialtiesController.text,
        avatar: avatar,
        video: video,
        price: price,
        token: authProvider.token?.access?.token as String,
      );

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(AppLocalizations(currentLocale).translate('success')!),
      ));
    } catch (error) {
      // Xử lý khi gặp lỗi
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
            '${AppLocalizations(currentLocale).translate('error')!} $error'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        leading: BackButton(
          color: Theme.of(context).colorScheme.secondary,
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
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: AppLocalizations(currentLocale).translate('name')!,
              ),
            ),
            sizedBox,
            TextFormField(
              controller: countryController,
              decoration: InputDecoration(
                labelText:
                    AppLocalizations(currentLocale).translate('country')!,
              ),
            ),
            sizedBox,
            TextFormField(
              controller: birthdayController,
              decoration: InputDecoration(
                labelText:
                    AppLocalizations(currentLocale).translate('birthday')!,
              ),
            ),
            sizedBox,
            TextFormField(
              controller: interestsController,
              decoration: InputDecoration(
                labelText:
                    AppLocalizations(currentLocale).translate('interests')!,
              ),
            ),
            sizedBox,
            TextFormField(
              controller: educationController,
              decoration: InputDecoration(
                labelText:
                    AppLocalizations(currentLocale).translate('education')!,
              ),
            ),
            sizedBox,
            TextFormField(
              controller: experienceController,
              decoration: InputDecoration(
                labelText:
                    AppLocalizations(currentLocale).translate('experience')!,
              ),
            ),
            sizedBox,
            TextFormField(
              controller: professionController,
              decoration: InputDecoration(
                labelText:
                    AppLocalizations(currentLocale).translate('profession')!,
              ),
            ),
            sizedBox,
            TextFormField(
              controller: languagesController,
              decoration: InputDecoration(
                labelText:
                    AppLocalizations(currentLocale).translate('languages')!,
              ),
            ),
            sizedBox,
            TextFormField(
              controller: bioController,
              decoration: InputDecoration(
                labelText: AppLocalizations(currentLocale).translate('bio')!,
              ),
            ),
            sizedBox,
            TextFormField(
              controller: targetStudentsController,
              decoration: InputDecoration(
                labelText: AppLocalizations(currentLocale)
                    .translate('targetStudents')!,
              ),
            ),
            sizedBox,
            TextFormField(
              controller: specialtiesController,
              decoration: InputDecoration(
                labelText:
                    AppLocalizations(currentLocale).translate('specialties')!,
              ),
            ),
            sizedBox,
            // FilePicker for Avatar
            ElevatedButton(
              onPressed: () async {
                FilePickerResult? result =
                    await FilePicker.platform.pickFiles(type: FileType.image);
                if (result != null) {
                  setState(() {
                    avatar = File(result.files.single.path!);
                  });
                }
              },
              child: Text(AppLocalizations(currentLocale).translate('pickAvatar')!),
            ),
            sizedBox,
            // FilePicker for Video
            ElevatedButton(
              onPressed: () async {
                FilePickerResult? result =
                    await FilePicker.platform.pickFiles(type: FileType.video);
                if (result != null) {
                  setState(() {
                    video = File(result.files.single.path!);
                  });
                }
              },
              child: Text(AppLocalizations(currentLocale).translate('pickVideo')!),
            ),
            sizedBox,
            TextFormField(
              controller: priceController,
              decoration: InputDecoration(
                labelText: AppLocalizations(currentLocale).translate('price')!,
              ),
            ),
            sizedBox,
            ElevatedButton(
              onPressed: () {
                _submitForm(authProvider);
              },
              child: Text(AppLocalizations(currentLocale).translate('submit')!),
            ),
          ],
        ),
      ),
    );
  }
}
