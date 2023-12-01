import 'package:flutter/material.dart';
import 'package:flutter_project/utils/sized_box.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../widgets/select_date.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _countryController = TextEditingController();

  final _studyScheduleController = TextEditingController();
  String name = '';
  String emailAddress = '';
  String phoneNumber = '';
  String birthday = '';
  String country = '';
  String level = '';
  String? chosenLevel;
  String imageUrl = 'https://as1.ftcdn.net/v2/jpg/01/04/93/90/1000_F_104939054_E7P5jaVoNYcXQI7YBrzsVWH2qZc03sn8.jpg';

  Future<void> loadUserDataFromLocal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      emailAddress = prefs.getString('email') ?? 'nguyen@gmail.com';
      phoneNumber = prefs.getString('phone') ?? '0388455212';
      country = prefs.getString('country') ?? 'Vietnam';
      name = prefs.getString('name') ?? 'Tran Nguyen';

      // Add default values for other fields if they are empty
      birthday = prefs.getString('birthday') ?? '';
      level = prefs.getString('level') ?? '';
      chosenLevel = prefs.getString('chosenLevel') ?? '';
      _nameController.text = name;
      _emailController.text = emailAddress;
      _phoneController.text = phoneNumber;
      _countryController.text = country;
      _studyScheduleController.text = prefs.getString('studySchedule') ?? '';
    });
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        imageUrl = pickedFile.path;
      });
    }
  }
  Future<void> saveUserDataToLocal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString('name', _nameController.text);
    await prefs.setString('email', _emailController.text);
    await prefs.setString('phone', _phoneController.text);
    await prefs.setString('country', _countryController.text);
  }

  @override
  void initState() {
    super.initState();
    loadUserDataFromLocal();

    _nameController.text = name;
    _emailController.text = emailAddress;
    _phoneController.text = phoneNumber;
    _countryController.text = country;
  }

  @override
  Widget build(BuildContext context) {
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
          'Profile',
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ),
      body: SingleChildScrollView(
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
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () {
                        _pickImage();
                      },
                      child: CircleAvatar(
                        backgroundColor: Theme.of(context).colorScheme.tertiary,
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
              'Name',
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
              'Email Address',
              style: TextStyle(
                  fontSize: 16, color: Theme.of(context).colorScheme.tertiary),
            ),
            subSizedBox,
            TextField(
              controller: _emailController,
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
              'Phone Number',
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).colorScheme.tertiary,
              ),
            ),
            subSizedBox,
            TextField(
              controller: _phoneController,
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
              'Country',
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).colorScheme.tertiary,
              ),
            ),
            subSizedBox,
            TextField(
              controller: _countryController,
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
              'Birthday',
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
              'Study Schedule',
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).colorScheme.tertiary,
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
              onPressed: () {
                saveUserDataToLocal();
                Navigator.pop(context);
              },
              style: TextButton.styleFrom(
                minimumSize: const Size.fromHeight(48),
                backgroundColor: Theme.of(context).colorScheme.secondary,
              ),
              child: Text(
                'SAVE',
                style: TextStyle(
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
