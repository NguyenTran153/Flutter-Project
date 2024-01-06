import 'package:flutter/material.dart';
import 'package:flutter_project/services/authentication_service.dart';
import 'package:provider/provider.dart';

import '../../l10n/l10n.dart';
import '../../providers/language_provider.dart';
import '../../utils/routes.dart';
import '../../utils/sized_box.dart';
import '../../widgets/text_field.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();

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

  Future<void> _getNewPassword() async {
    final email = _emailController.text;
    final emailRegExp = RegExp(
        r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$');

    if (email.isEmpty || !emailRegExp.hasMatch(_emailController.text)) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
                AppLocalizations(currentLocale).translate('notValidEmail')!),
            content:
                Text(AppLocalizations(currentLocale).translate('enterEmail')!),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child:
                    Text(AppLocalizations(currentLocale).translate('close')!),
              ),
            ],
          );
        },
      );
      return;
    }
    try {
      await AuthenticationService.forgotPassword(email);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(AppLocalizations(currentLocale)
                  .translate('sendRecoveryEmailSuccess')!)),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error Reset Password: ${e.toString()}')),
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(10.0),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              sizedBox,
              Image.asset(
                'public/images/LetTutor.png',
                width: 320,
                height: 320,
              ),
              sizedBox,
              TextFieldInput(
                  textEditingController: _emailController,
                  hintText: AppLocalizations(currentLocale)
                      .translate('enterEmail')!,
                  textInputType: TextInputType.emailAddress),
              sizedBox,
              InkWell(
                onTap: () {
                  _getNewPassword();
                },
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  child: Text(AppLocalizations(currentLocale)
                      .translate('send')!),
                ),
              ),
              sizedBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      AppLocalizations(currentLocale)
                          .translate('haveAccount')!,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, Routes.login);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        AppLocalizations(currentLocale)
                            .translate('login')!,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
