import 'package:Sashimi/Screens/Login/signin_screen.dart';
import 'package:Sashimi/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const SashimiApp());
}


class SashimiApp extends StatelessWidget {
  const SashimiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: SignInScreen());
  }
}