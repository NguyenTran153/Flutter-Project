import 'package:flutter/material.dart';
import 'package:flutter_project/utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  Future<void> _register() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String username = _emailController.text;
    String password = _passwordController.text;

    await prefs.setString('username', username);
    await prefs.setString('password', password);

    Navigator.pushNamed(context, Routes.login);
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: primaryColor,
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(10.0),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              sizedBox,
              const Text(
                "Say hello to your English tutors",
                style: TextStyle(
                  color: secondaryColor,
                  fontSize: 36.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              sizedBox,
              const Text(
                "Become fluent faster through one-on-one video chat lessons tailored to your goals.",
                style: TextStyle(
                  color: tertiaryColor,
                  fontSize: 24,
                  fontWeight: FontWeight.normal,
                ),
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
              TextFieldInput(
                textEditingController: _confirmPasswordController,
                hintText: "Enter your password again",
                textInputType: TextInputType.text,
                isPass: true,
              ),
              sizedBox,
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, Routes.login);
                },
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: secondaryColor,
                  ),
                  child: const Text("Register"),
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
                      child: const Text(
                        ' Login',
                        style: TextStyle(
                          color: secondaryColor,
                          decoration: TextDecoration.underline,
                        ),
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
