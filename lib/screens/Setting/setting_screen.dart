import 'package:flutter/material.dart';
import 'package:flutter_project/utils/colors.dart';
import 'package:flutter_project/utils/sized_box.dart';

import '../../utils/routes.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 120,
              height: 120,
              clipBehavior: Clip.hardEdge,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Image.network(
                'https://as1.ftcdn.net/v2/jpg/01/04/93/90/1000_F_104939054_E7P5jaVoNYcXQI7YBrzsVWH2qZc03sn8.jpg',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.person_rounded),
              ),
            ),
          ),
          sizedBox,
          Align(
              alignment: Alignment.center,
              child: Text(
                'name',
                style: Theme.of(context).textTheme.displaySmall,
              )),
          //const SizedBox(height: 12),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, Routes.userProfile);
            },
            child: const Text('Edit Profile'),
          ),
          // Functions Starts Here
          const SizedBox(height: 4),
          Card(
            surfaceTintColor: primaryColor,
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: const [
                  Icon(Icons.manage_accounts, size: 30),
                  SizedBox(width: 12),
                  Text(
                    'Account',
                    style: TextStyle(fontSize: 16),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 4),
          Card(
            surfaceTintColor: primaryColor,
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: const [
                  Icon(Icons.language, size: 30),
                  SizedBox(width: 12),
                  Text(
                    'Language',
                    style: TextStyle(fontSize: 16),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 4),
          InkWell(
            child: Card(
              surfaceTintColor: primaryColor,
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: const [
                    Icon(Icons.assignment, size: 30),
                    sizedBox,
                    Text(
                      'Become A Tutor',
                      style: TextStyle(fontSize: 16),
                    )
                  ],
                ),
              ),
            ),
          ),
          sizedBox,
          Card(
            surfaceTintColor: primaryColor,
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: const [
                  Icon(Icons.privacy_tip_outlined, size: 30),
                  SizedBox(width: 12),
                  Text(
                    'Privacy Policy',
                    style: TextStyle(fontSize: 16),
                  )
                ],
              ),
            ),
          ),
          subSizedBox,
          Card(
            surfaceTintColor: primaryColor,
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: const [
                  Icon(Icons.newspaper_outlined, size: 30),
                  SizedBox(width: 12),
                  Text(
                    'Terms & Conditions',
                    style: TextStyle(fontSize: 16),
                  )
                ],
              ),
            ),
          ),
          subSizedBox,
          Card(
            surfaceTintColor: primaryColor,
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: const [
                  Icon(Icons.contact_mail_outlined, size: 30),
                  SizedBox(width: 12),
                  Text(
                    'Contact',
                    style: TextStyle(fontSize: 16),
                  )
                ],
              ),
            ),
          ),
          subSizedBox,
          Card(
            surfaceTintColor: primaryColor,
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: const [
                  Icon(Icons.contact_support_outlined, size: 30),
                  sizedBox,
                  Text(
                    'Guide',
                    style: TextStyle(fontSize: 16),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 48),
          TextButton(
            onPressed: () async {
              Navigator.pushNamedAndRemoveUntil(
                context,
                Routes.login,
                (route) => false,
              );
            },
            style: TextButton.styleFrom(
              minimumSize: const Size.fromHeight(44),
              backgroundColor: const Color.fromRGBO(255, 0, 0, 0.2),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.logout, color: dangerColor),
                SizedBox(width: 8),
                Text(
                  'Log Out',
                  style: TextStyle(
                    fontSize: 18,
                    color: dangerColor,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 48),
        ],
      ),
    );
  }
}
