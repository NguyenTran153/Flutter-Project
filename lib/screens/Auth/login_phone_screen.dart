import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../l10n/l10n.dart';
import '../../providers/language_provider.dart';
import '../../utils/routes.dart';
import '../../utils/sized_box.dart';
import '../../widgets/text_field.dart';

class LoginByPhoneScreen extends StatefulWidget {
  const LoginByPhoneScreen({super.key});

  @override
  State<LoginByPhoneScreen> createState() => _LoginByPhoneScreenState();
}

class _LoginByPhoneScreenState extends State<LoginByPhoneScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
              sizedBox,
              Image.asset(
                'public/images/LetTutor.png',
                width: 320,
                height: 320,
              ),
              sizedBox,
              TextFieldInput(
                  textEditingController: _emailController,
                  hintText:
                      AppLocalizations(currentLocale).translate('enterEmail')!,
                  textInputType: TextInputType.emailAddress),
              sizedBox,
              TextFieldInput(
                textEditingController: _passwordController,
                hintText:
                    AppLocalizations(currentLocale).translate('enterPassword')!,
                textInputType: TextInputType.text,
                isPass: true,
              ),
              sizedBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, Routes.forgotPassword);
                    },
                    child: const Text("Forgot Password",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.green,
                            decoration: TextDecoration.underline)),
                  ),
                ],
              ),
              subSizedBox,
              InkWell(
                onTap: () {},
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  child:
                      Text(AppLocalizations(currentLocale).translate('login')!),
                ),
              ),
              const Text("Or continue with"),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Image.asset('public/icons/facebook.png'),
                    iconSize: 32.0,
                  ),
                  IconButton(
                    onPressed: () async {},
                    icon: Image.asset('public/icons/google.png'),
                    iconSize: 32.0,
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.login);
                    },
                    icon: Icon(
                      Icons
                          .email,
                      size: 60.0,
                    ),
                  ),
                ],
              ),
              sizedBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      AppLocalizations(currentLocale)
                          .translate('dontHaveAnAccount')!,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, Routes.register);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                          AppLocalizations(currentLocale)
                              .translate('register')!,
                          style: Theme.of(context).textTheme.titleMedium),
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
