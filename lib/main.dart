import 'package:sashimi/Screens/Login/signin_screen.dart';
import 'package:sashimi/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

FirebaseDatabase db = FirebaseDatabase.instance;

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
    // return const MaterialApp(home: SignInScreen());
    return MaterialApp(
        title: 'Catalist',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const SignInScreen());
  }
}
