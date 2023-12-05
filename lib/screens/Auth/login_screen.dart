import 'package:flutter/material.dart';
import 'package:flutter_project/utils/sized_box.dart';
import 'package:flutter_project/widgets/text_field.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../l10n.dart';
import '../../providers/auth_provider.dart';
import '../../providers/language_provider.dart';
import '../../services/authentication_service.dart';
import '../../utils/routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isAuthenticating = true;
  bool _isAuthenticated = false;

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

  Future<void> _loginWithEmailAndPassword(AuthProvider authProvider) async {
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
        errorMessage = AppLocalizations(currentLocale).translate('errorLogin')!;
      }
    }

    validateField(_emailController.text, 'email');
    validateField(_passwordController.text, 'password');

    if (isValid) {
      try {
        await AuthenticationService.loginWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
          onSuccess: (user, token) async {
            authProvider.logIn(user, token);
            final prefs = await SharedPreferences.getInstance();
            await prefs.setString(
              'refresh_token',
              authProvider.token!.refresh!.token!,
            );

            setState(() {
              _isAuthenticating = false;
              _isAuthenticated = true;
            });

            Future.delayed(
              const Duration(seconds: 1),
              () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  Routes.main,
                  (route) => false,
                );
              },
            );
          },
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

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
              Text(
                "Say hello to your English tutors",
                style: Theme.of(context).textTheme.displayMedium,
              ),
              sizedBox,
              Text(
                "Become fluent faster through one-on-one video chat lessons tailored to your goals.",
                style: TextStyle(fontSize: 24, color: Colors.grey),
              ),
              sizedBox,
              TextFieldInput(
                  textEditingController: _emailController,
                  hintText: "Enter your email",
                  textInputType: TextInputType.emailAddress),
              sizedBox,
              TextFieldInput(
                textEditingController: _passwordController,
                hintText: "Enter your password",
                textInputType: TextInputType.text,
                isPass: true,
              ),
              sizedBox,
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, Routes.forgotPassword);
                },
                child: Text(
                  "Forgot Password",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
              subSizedBox,
              InkWell(
                onTap: () {
                  _loginWithEmailAndPassword(authProvider);
                },
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Theme.of(context).primaryColor,
                  ),
                  child: const Text("Login"),
                ),
              ),
              sizedBox,
              const Text("Or continue with"),
              subSizedBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Image.asset('public/icons/facebook.png'),
                    iconSize: 32.0,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Image.asset('public/icons/google.png'),
                    iconSize: 32.0,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Image.asset('public/icons/phone.png'),
                    iconSize: 32.0,
                  ),
                ],
              ),
              sizedBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: const Text(
                      'Dont have an account?',
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, Routes.register);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(' Register.',
                          style: Theme.of(context).textTheme.titleSmall),
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
