import 'package:Sashimi/Login/login.dart';
import 'package:flutter/material.dart';

void main() => runApp(const SashimiApp());


class SashimiApp extends StatelessWidget {
  const SashimiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: Login());
  }
}