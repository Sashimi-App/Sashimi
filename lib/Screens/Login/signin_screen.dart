import 'package:Sashimi/Screens/Account/account_page.dart';
import 'package:Sashimi/Screens/Login/signup_screen.dart';
import 'package:Sashimi/Screens/mainNavPage.dart';
import 'package:Sashimi/screens/Feed/feed_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:Sashimi/utils/color_utils.dart';
import 'package:Sashimi/reuseableWidgets/reusable_widget.dart';


import 'package:logger/logger.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final Logger _logger = Logger();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _showErrorSnackBar(String errorMessage) {
    String customMessage;

    if (errorMessage.contains("INVALID_LOGIN_CREDENTIALS")) {
      customMessage = "Wrong username or password. Please try again.";
    } else if (errorMessage.contains("ERROR_USER_NOT_FOUND")) {
      customMessage = "Username not found. Please check your username.";
    } else if(errorMessage.contains("invalid-email")) {
      customMessage = "Invalid email. Please check your email.";
    } else {
      customMessage = "Sign-in failed. Please try again later.";
    }

    final snackBar = SnackBar(
      content: Text(customMessage),
      duration: const Duration(seconds: 5), // You can adjust the duration as needed
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }


  void _handleSignInButtonPressed() async {
  try {
    _logger.d("Sign In Button Pressed");

    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: _emailTextController.text,
      password: _passwordTextController.text,
    );

    // ignore: use_build_context_synchronously
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MainNavigationPage()),
    );
  } catch (error) {
    _logger.e("Sign in Error: ${error.toString()}");
    _showErrorSnackBar("Sign-in failed: ${error.toString()}");
  }
}

  void _handleSignUpLinkTapped() {
    _logger.d("Sign Up link tapped");
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return const SignUpScreen();
    }));
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: hexStringToColor("e2dee2"),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              20,
              MediaQuery.of(context).size.height * 0.1,
              20,
              0,
            ),
            child: Column(
              children: <Widget>[
                const SizedBox(height: 30),
                logoWidget("assets/images/logo.png"),
                const SizedBox(height: 30),
                reusableTextField(
                  "Enter UserName",
                  Icons.person_outline,
                  false,
                  _emailTextController,
                ),
                const SizedBox(height: 20),
                reusableTextField(
                  "Enter Password",
                  Icons.lock_outline,
                  true,
                  _passwordTextController,
                ),
                const SizedBox(height: 20),
                signInSignUpButton(context, true, _handleSignInButtonPressed),
                signUpOption(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text(
          "Don't have an account? ",
          style: TextStyle(color: Color(0xFF373737)),
        ),
        GestureDetector(
          onTap: _handleSignUpLinkTapped,
          child: const Text(
            "Sign Up",
            style: TextStyle(color: Color(0xFF373737), fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
