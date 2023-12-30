import 'package:flutter/material.dart';
import 'package:flutter_project/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_project/utils/sized_box.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../l10n.dart';
import '../../providers/language_provider.dart';
import '../../providers/theme_provider.dart';
import '../../utils/routes.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
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

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 48),
          buildSettingCard(
            icon: Icons.manage_accounts,
            label: 'Account',
            onTap: () {
              // Handle onTap for Account
            },
          ),
          subSizedBox,
          buildSettingCard(
            icon: Icons.language,
            label: 'Language',
            onTap: () {
              // Handle onTap for Language
            },
          ),
          subSizedBox,
          buildSettingCard(
            icon: Icons.dark_mode,
            label: 'Change theme',
            onTap: () {
              Provider.of<ThemeProvider>(context, listen: false).toggleMode();
            },
          ),
          subSizedBox,
          buildSettingCard(
            icon: Icons.password_outlined,
            label: 'Change Password',
            onTap: () {
              Navigator.pushNamed(context, Routes.changePassword);
            },
          ),
          subSizedBox,
          buildSettingCard(
            icon: Icons.assignment,
            label: 'Become A Tutor',
            onTap: () {
              Navigator.pushNamed(context, Routes.becomeTutor);
            },
          ),
          subSizedBox,
          const SizedBox(height: 48),
          buildLogoutButton(authProvider),
          const SizedBox(height: 48),
        ],
      ),
    );
  }

  Widget buildSettingCard({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Card(
        surfaceTintColor: Theme.of(context).primaryColor,
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Icon(icon, size: 30),
              sizedBox,
              Text(
                label,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildLogoutButton(AuthProvider authProvider) {
    return TextButton(
      onPressed: () async {
        final prefs = await SharedPreferences.getInstance();
        prefs.remove('refresh_token');
        authProvider.token = null;

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
        children: [
          const Icon(Icons.logout, color: Colors.red),
          subSizedBox,
          Text(
            AppLocalizations(currentLocale).translate('logout')!,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
