import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:Sashimi/reuseableWidgets/reusable_widget.dart';
import 'package:Sashimi/screens/Feed/feed_page.dart';
import 'package:logger/logger.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final Logger _logger = Logger();
  final TextEditingController _userNameTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _showErrorMessage(String errorMessage) {
  String customMessage;

  if (errorMessage.contains("The email address is badly formatted")) {
    customMessage = "The email address is badly formatted. Please check your email.";
  } else if (errorMessage.contains("weak-password")) {
    customMessage = "The password is too weak. Please use a stronger password.";
  } else if (errorMessage.contains("email-already-in-use")) {
    customMessage = "The email address is already in use by another account. Please use a different email.";
  } else {
    customMessage = "Sign-up failed. Please try again later.";
  }

  final snackBar = SnackBar(
    content: Text(customMessage),
    duration: const Duration(seconds: 5), // You can adjust the duration as needed
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

  void _handleSignUpButtonPressed() async {
    _logger.d("Sign Up Button Pressed");

    try {
      final authResult =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailTextController.text,
        password: _passwordTextController.text,
      );

      final user = authResult.user;

      // Update the display name
      await user?.updateDisplayName(_userNameTextController.text);

      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailTextController.text,
        password: _passwordTextController.text,
      );

      _logger.d("New Account Created and Logged In");
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const FeedPage()),
      );
    } catch (error) {
      _logger.e("Sign Up Error: ${error.toString()}");
      _showErrorMessage("Sign-in failed: ${error.toString()}");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Sign Up",
          style: TextStyle(color: Color(0xFF373737), fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(color: Color(0xFFe2dee2)),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 120, 20, 0),
            child: Column(
              children: <Widget>[
                const SizedBox(height: 20),
                reusableTextField(
                  "Enter UserName",
                  Icons.person_outline,
                  false,
                  _userNameTextController,
                ),
                const SizedBox(height: 20),
                reusableTextField(
                  "Enter Email",
                  Icons.email_outlined,
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
                signInSignUpButton(context, false, _handleSignUpButtonPressed),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
