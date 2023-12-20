import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_project/utils/sized_box.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../constants/constant.dart';
import '../../l10n.dart';
import '../../models/user/learn_topic.dart';
import '../../models/user/test_preparation.dart';
import '../../models/user/user.dart';
import '../../providers/auth_provider.dart';
import '../../providers/language_provider.dart';
import '../../services/user_service.dart';
import '../../widgets/select_date.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  User? user;

  final _nameController = TextEditingController();
  final _studyScheduleController = TextEditingController();
  String emailAddress = '';
  String phoneNumber = '';
  String birthday = '';
  String country = '';
  String level = '';
  String imageUrl = '';
  List<LearnTopic> chosenTopics = [];
  List<TestPreparation> chosenTestPreparations = [];

  bool _isInitiated = false;
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

  void _loadUserProfile(AuthProvider authProvider) async {
    final String token = authProvider.token?.access?.token as String;
    final result = await UserService.getUserInformation(token);

    _nameController.text = result?.name ?? '';
    emailAddress = result?.email ?? '';
    phoneNumber = result?.phone ?? '';
    birthday = result?.birthday ?? '';
    country = result?.country ?? '';
    level = result?.level ?? '';
    _studyScheduleController.text = result?.studySchedule ?? '';

    chosenTopics = result?.learnTopics ?? [];
    chosenTestPreparations = result?.testPreparations ?? [];

    setState(() {
      user = result;
      _isInitiated = true;
      _isLoading = false;
    });
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        imageUrl = pickedFile.path;
      });
    }
  }

  Future<void> _updateUserProfile(AuthProvider authProvider) async {
    final String token = authProvider.token?.access?.token as String;
    final learnTopics = chosenTopics.map((topic) => topic.id.toString()).toList();
    final testPreparations = chosenTestPreparations.map((test) => test.id.toString()).toList();

    await UserService.updateUserInformation(
      token: token,
      name: _nameController.text,
      country: country,
      birthday: birthday,
      level: level,
      learnTopics: learnTopics,
      testPreparations: testPreparations,
      studySchedule: _studyScheduleController.text,
    );
    setState(() {
      _isLoading = true;
      _isInitiated = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

    if (!_isInitiated) {
      _loadUserProfile(authProvider);
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        leading: BackButton(
          color: Theme.of(context).colorScheme.secondary,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          AppLocalizations(currentLocale).translate('profile')!,
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Stack(
                      children: [
                        Container(
                          width: 108,
                          height: 108,
                          clipBehavior: Clip.hardEdge,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: imageUrl.isNotEmpty
                              ? Image.file(
                            File(imageUrl),
                            fit: BoxFit.cover,
                          )
                              : Image.network(
                            authProvider.currentUser.avatar ?? '',
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.person_rounded),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: () {
                              _pickImage();
                            },
                            child: CircleAvatar(
                              backgroundColor:
                                  Theme.of(context).colorScheme.tertiary,
                              radius: 18,
                              child: const Icon(
                                Icons.camera_alt,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  sizedBox,
                  Text(
                    AppLocalizations(currentLocale).translate('name')!,
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                  subSizedBox,
                  TextField(
                    controller: _nameController,
                    autocorrect: false,
                    decoration: const InputDecoration(
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
                  sizedBox,
                  Text(
                    'Email',
                    style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.tertiary),
                  ),
                  subSizedBox,
                  Text(emailAddress),
                  sizedBox,
                  Text(
                    AppLocalizations(currentLocale).translate('phone')!,
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                  subSizedBox,
                  Text(phoneNumber),
                  sizedBox,
                  Text(
                    AppLocalizations(currentLocale).translate('country')!,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[900],
                    ),
                  ),
                  const SizedBox(height: 4),
                  DropdownButtonFormField(
                    isExpanded: true,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 4,
                        horizontal: 8,
                      ),
                      hintStyle: TextStyle(color: Colors.grey[400]),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    value: countries[country],
                    items: countries.values
                        .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(e, overflow: TextOverflow.ellipsis),
                            ))
                        .toList(),
                    onChanged: (value) {
                      final chosenCountry = countries.keys.firstWhere(
                        (element) => countries[element] == value,
                        orElse: () => 'US',
                      );
                      setState(() {
                        country = chosenCountry;
                      });
                    },
                  ),
                  sizedBox,
                  Text(
                    AppLocalizations(currentLocale).translate('birthday')!,
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                  subSizedBox,
                  SelectDate(
                    initialValue: birthday,
                    onChanged: (newValue) {
                      setState(() {
                        birthday = newValue;
                      });
                    },
                  ),
                  Text(
                    AppLocalizations(currentLocale).translate('level')!,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[900],
                    ),
                  ),
                  subSizedBox,
                  DropdownButtonFormField(
                    isExpanded: true,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 4,
                        horizontal: 8,
                      ),
                      hintStyle: TextStyle(color: Colors.grey[400]),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    value: userLevels[level],
                    items: userLevels.values
                        .map((e) => DropdownMenuItem(
                      value: e,
                      child: Text(e, overflow: TextOverflow.ellipsis),
                    ))
                        .toList(),
                    onChanged: (value) {
                      final chosenLevel = userLevels.keys.firstWhere(
                            (element) => userLevels[element] == value,
                        orElse: () => 'BEGINNER',
                      );
                      setState(() {
                        level = chosenLevel;
                      });
                    },
                  ),
                  subSizedBox,
                  Text(
                    AppLocalizations(currentLocale).translate('topics')!,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[900],
                    ),
                  ),
                  subSizedBox,
                  Wrap(
                    spacing: 8,
                    runSpacing: -4,
                    children: List<Widget>.generate(
                      authProvider.learnTopics.length,
                          (index) => ChoiceChip(
                        backgroundColor: Colors.grey[100],
                        selectedColor: Colors.lightBlue[100],
                        selected: chosenTopics
                            .map((e) => e.id)
                            .toList()
                            .contains(authProvider.learnTopics[index].id),
                        label: Text(
                          authProvider.learnTopics[index].name ?? '',
                          style: TextStyle(
                            fontSize: 14,
                            color: chosenTopics
                                .map((e) => e.id)
                                .toList()
                                .contains(authProvider.learnTopics[index].id)
                                ? Colors.blue[700]
                                : Colors.black54,
                          ),
                        ),
                        onSelected: (bool selected) {
                          setState(() {
                            if (selected) {
                              chosenTopics.add(authProvider.learnTopics[index]);
                            } else {
                              chosenTopics.removeWhere(
                                    (element) => element.id == authProvider.learnTopics[index].id,
                              );
                            }
                          });
                        },
                      ),
                    ),
                  ),
                  sizedBox,
                  Text(
                    AppLocalizations(currentLocale).translate('testPreparation')!,
                    style: TextStyle(fontSize: 16, color: Colors.grey[900]),
                  ),
                  subSizedBox,
                  Wrap(
                    spacing: 8,
                    runSpacing: -4,
                    children: List<Widget>.generate(
                      authProvider.testPreparations.length,
                          (index) => ChoiceChip(
                        backgroundColor: Colors.grey[100],
                        selectedColor: Colors.lightBlue[100],
                        selected: chosenTestPreparations
                            .map((e) => e.id)
                            .toList()
                            .contains(authProvider.testPreparations[index].id),
                        label: Text(
                          authProvider.testPreparations[index].name ?? 'null',
                          style: TextStyle(
                            fontSize: 14,
                            color: chosenTestPreparations
                                .map((e) => e.id)
                                .toList()
                                .contains(authProvider.testPreparations[index].id)
                                ? Colors.blue[700]
                                : Colors.black54,
                          ),
                        ),
                        onSelected: (bool selected) {
                          setState(() {
                            if (selected) {
                              chosenTestPreparations.add(authProvider.testPreparations[index]);
                            } else {
                              chosenTestPreparations.removeWhere(
                                    (element) => element.id == authProvider.testPreparations[index].id,
                              );
                            }
                          });
                        },
                      ),
                    ),
                  ),
                  subSizedBox,
                  Text(
                    AppLocalizations(currentLocale).translate('studySchedule')!,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[900],
                    ),
                  ),
                  subSizedBox,
                  TextField(
                    controller: _studyScheduleController,
                    autocorrect: false,
                    decoration: const InputDecoration(
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
                  sizedBox,
                  TextButton(
                    onPressed: () async {
                      await _updateUserProfile(authProvider);
                    },
                    style: TextButton.styleFrom(
                      minimumSize: const Size.fromHeight(48),
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                    ),
                    child: Text(
                      AppLocalizations(currentLocale).translate('save')!,                      style: TextStyle(
                        fontSize: 18,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
