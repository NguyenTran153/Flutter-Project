import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_project/utils/sized_box.dart';

import '../../providers/theme_provider.dart';
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 48),
          Card(
            surfaceTintColor: Theme.of(context).primaryColor,
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
          subSizedBox,
          Card(
            surfaceTintColor: Theme.of(context).primaryColor,
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
          subSizedBox,
          InkWell(
            onTap: () => {
            Provider.of<ThemeProvider>(context).toggleMode()
          },
            child: Card(
              surfaceTintColor: Theme.of(context).primaryColor,
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: const [
                    Icon(Icons.dark_mode, size: 30),
                    sizedBox,
                    Text(
                      'Change theme',
                      style: TextStyle(fontSize: 16),
                    )
                  ],
                ),
              ),
            ),
          ),
          subSizedBox,
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, Routes.becomeTutor);
            },
            child: Card(
              surfaceTintColor: Theme.of(context).primaryColor,
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
          subSizedBox,
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
                Icon(Icons.logout, color: Colors.red),
                SizedBox(width: 8),
                Text(
                  'Log Out',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.red,
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
