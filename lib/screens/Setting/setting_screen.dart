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
  final List<Map<String, String>> supportedLanguages = [
    {'code': 'en', 'name': 'English'},
    {'code': 'vi', 'name': 'Tiếng Việt'},
    // Add more languages as needed
  ];

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

  Future<void> _showLanguageDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text(
            'Select Language',
            style: TextStyle(color: Theme.of(context).colorScheme.secondary),
          ),
          content: Container(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: supportedLanguages.length,
              itemBuilder: (BuildContext context, int index) {
                final language = supportedLanguages[index];
                return ListTile(
                  title: Text(
                    language['name'] ?? '',
                    style: TextStyle(color: Theme.of(context).colorScheme.tertiary),
                  ),
                  onTap: () {
                    _changeLanguage(language['code'] ?? '');
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }

  Future<void> _changeLanguage(String languageCode) async {
    try {
      final languageProvider = context.read<LanguageProvider>();
      languageProvider.setLocale(Locale(languageCode));

      // Save selected language to SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('selected_language', languageCode);
    } catch (error) {
      // Xử lý lỗi ở đây
      print('Error changing language: $error');
    }
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
          // buildSettingCard(
          //   icon: Icons.manage_accounts,
          //   label: 'Account',
          //   onTap: () {
          //     // Handle onTap for Account
          //   },
          // ),
          // subSizedBox,
          buildSettingCard(
            icon: Icons.language,
            label: AppLocalizations(currentLocale).translate('language')!,
            onTap: () {
              _showLanguageDialog(context);
            },
          ),
          subSizedBox,
          buildSettingCard(
            icon: Icons.dark_mode,
            label: AppLocalizations(currentLocale).translate('changeTheme')!,
            onTap: () {
              Provider.of<ThemeProvider>(context, listen: false).toggleMode();
            },
          ),
          subSizedBox,
          buildSettingCard(
            icon: Icons.password_outlined,
            label: AppLocalizations(currentLocale).translate('changePassword')!,
            onTap: () {
              Navigator.pushNamed(context, Routes.changePassword);
            },
          ),
          subSizedBox,
          buildSettingCard(
            icon: Icons.assignment,
            label: AppLocalizations(currentLocale).translate('becomeTutor')!,
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
