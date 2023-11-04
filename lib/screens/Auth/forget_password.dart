import 'package:flutter/material.dart';
import 'package:flutter_project/utils/colors.dart';

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

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();

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
                  child: const Text("Send Email"),
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
