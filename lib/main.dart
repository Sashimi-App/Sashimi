import 'package:Sashimi/Screens/Login/signin_screen.dart';
import 'package:Sashimi/Screens/todo/todo_screen.dart';
import 'package:Sashimi/Screens/todo/phototaking_screen.dart';
import 'package:Sashimi/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:io';
import 'package:camera/camera.dart';

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
    return MaterialApp(
        title: 'Catalist',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: TodoListScreen());
  }
}
