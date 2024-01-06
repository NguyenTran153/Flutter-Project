import 'package:flutter/material.dart';
import 'package:flutter_project/utils/sized_box.dart';
import 'package:flutter_project/widgets/text_field.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../l10n/l10n.dart';
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

  final _googleSignIn = GoogleSignIn();

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

  Future<void> _loginByGoogle(AuthProvider authProvider) async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final String? accessToken = googleAuth?.accessToken;
      if (accessToken != null) {
        try {
          await AuthenticationService.loginByGoogle(
              accessToken: accessToken,
              onSuccess: (user, token) async {
                authProvider.logIn(user, token);

                final prefs = await SharedPreferences.getInstance();
                await prefs.setString(
                  'refresh_token',
                  authProvider.token!.refresh!.token!,
                );

                setState(() {
                  _isAuthenticated = true;
                  _isAuthenticating = false;
                });

                Future.delayed(const Duration(seconds: 1), () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    Routes.main,
                    (route) => false,
                  );
                });
              });
        } catch (e) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text('Error Login with Google: ${e.toString()}')),
            );
          }
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error Login with Google: ${e.toString()}')),
      );
    }
  }

  Future<void> _loginByFacebook(AuthProvider authProvider) async {
    final result = await FacebookAuth.instance.login();

    if (result.status == LoginStatus.success) {
      final accessToken = result.accessToken!.token;
      try {
        await AuthenticationService.loginByFacebook(
            accessToken: accessToken,
            onSuccess: (user, token) async {
              authProvider.logIn(user, token);

              final prefs = await SharedPreferences.getInstance();
              await prefs.setString(
                'refresh_token',
                authProvider.token!.refresh!.token!,
              );

              setState(() {
                _isAuthenticated = true;
                _isAuthenticating = false;
              });

              Future.delayed(const Duration(seconds: 1), () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  Routes.main,
                  (route) => false,
                );
              });
            });
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text('Error Login with Facebook: ${e.toString()}')),
          );
        } else {}
      }
    }
  }

  void _handlePreviousSession(AuthProvider authProvider) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final refreshToken = prefs.getString('refresh_token') ?? '';

      await AuthenticationService.continueSession(
        refreshToken: refreshToken,
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

          Future.delayed(const Duration(seconds: 1), () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              Routes.main,
              (route) => false,
            );
          });
        },
      );
    } catch (e) {
      setState(() {
        _isAuthenticating = false;
      });
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

    if (_isAuthenticating) {
      _handlePreviousSession(authProvider);
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).primaryColor,
      body: _isAuthenticating
          ? const Center(child: CircularProgressIndicator(color: Colors.blue))
          : _isAuthenticated
              ? const SizedBox.shrink()
              : SafeArea(
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, Routes.forgotPassword);
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
                          onTap: () {
                            _loginWithEmailAndPassword(authProvider);
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
                                .translate('login')!),
                          ),
                        ),
                        const Text("Or continue with"),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () {
                                _loginByFacebook(authProvider);
                              },
                              icon: Image.asset('public/icons/facebook.png'),
                              iconSize: 32.0,
                            ),
                            IconButton(
                              onPressed: () async {
                                _loginByGoogle(authProvider);
                              },
                              icon: Image.asset('public/icons/google.png'),
                              iconSize: 32.0,
                            ),
                            IconButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, Routes.loginByPhone);
                              },
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
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: Text(
                                    AppLocalizations(currentLocale)
                                        .translate('register')!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium),
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
