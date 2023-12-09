import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../l10n.dart';
import '../../providers/language_provider.dart';
import '../../services/authentication_service.dart';
import '../../utils/routes.dart';
import '../../utils/sized_box.dart';
import '../../widgets/text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

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

  Future<void> _register() async {
    final emailRegExp = RegExp(
        r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$');

    bool isValid = true;
    String errorMessage = '';

    void validateField(String value, String errorType) {
      if (value.isEmpty) {
        isValid = false;
        errorMessage = AppLocalizations(currentLocale).translate('emptyField')!;
      } else if (errorType == 'email' && !emailRegExp.hasMatch(value)) {
        isValid = false;
        errorMessage =
            AppLocalizations(currentLocale).translate('notValidEmail')!;
      } else if (errorType == 'password' && value.length < 6) {
        isValid = false;
        errorMessage =
            AppLocalizations(currentLocale).translate('passwordTooShort')!;
      } else if (errorType == 'confirmPassword' && value.length < 6) {
        isValid = false;
        errorMessage =
            AppLocalizations(currentLocale).translate('passwordTooShort')!;
      } else if (errorType == 'confirmPassword' &&
          value != _passwordController.text) {
        isValid = false;
        errorMessage =
            AppLocalizations(currentLocale).translate('passwordNotMatch')!;
      }
    }

    validateField(_emailController.text, 'email');
    validateField(_passwordController.text, 'password');
    validateField(_confirmPasswordController.text, 'confirmPassword');

    if (isValid) {
      try {
        await AuthenticationService.registerWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(AppLocalizations(currentLocale)
                    .translate('registerCompleted')!)),
          );
          Navigator.pop(context);
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations(currentLocale)
              .translate('registerError')!),
        ));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    }
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              sizedBox,
              Text(
                "Say hello to your English tutors",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              sizedBox,
              Text(
                "Become fluent faster through one-on-one video chat lessons tailored to your goals.",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              sizedBox,
              TextFieldInput(
                  textEditingController: _emailController,
                  hintText: AppLocalizations(currentLocale)
                      .translate('enterEmail')!,
                  textInputType: TextInputType.emailAddress),
              sizedBox,
              TextFieldInput(
                textEditingController: _passwordController,
                hintText: AppLocalizations(currentLocale)
                    .translate('enterPassword')!,
                textInputType: TextInputType.text,
                isPass: true,
              ),
              sizedBox,
              TextFieldInput(
                textEditingController: _confirmPasswordController,
                hintText: AppLocalizations(currentLocale)
                    .translate('enterPassword')!,
                textInputType: TextInputType.text,
                isPass: true,
              ),
              sizedBox,
              InkWell(
                onTap: () async {
                  _register();
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
                      .translate('register')!),
                ),
              ),
              sizedBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: const Text(
                      'Already have an account?',
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, Routes.login);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        ' Login',
                        style: Theme.of(context).textTheme.titleSmall,
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
