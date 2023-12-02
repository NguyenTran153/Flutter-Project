import 'package:flutter/material.dart';
import 'package:flutter_project/utils/sized_box.dart';
import 'package:flutter_project/widgets/text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();


  Future<void> _login() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedUsername = prefs.getString('email');
    String? savedPassword = prefs.getString('password');

    String enteredUsername = _emailController.text;
    String enteredPassword = _passwordController.text;

    if (enteredUsername == savedUsername && enteredPassword == savedPassword) {
      setState(() {
        Navigator.pushNamed(context, Routes.main);
      });
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Your information is wrong!'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Close'),
              ),
            ],
          );
        },
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
                  _login();
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
                      child: Text(
                        ' Register.',
                        style: Theme.of(context).textTheme.titleSmall
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
