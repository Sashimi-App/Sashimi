// Import necessary packages and files
import 'profile.dart';
import 'midNav.dart';
import 'posts.dart';
import 'dart:convert';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

// Main widget for the Account Page
class AccountPage extends StatefulWidget {
  // Constructor for AccountPage, takes a key as an argument
  const AccountPage({super.key});

  // Create the mutable state for this widget
  @override
  State<AccountPage> createState() => _AccountPageState();
}

// The mutable state for the AccountPage widget
class _AccountPageState extends State<AccountPage> {
  // A list to hold the data read from the JSON file
  List _items = [];

  // Asynchronous function to read data from a JSON file
  // The JSON file is located in the app's assets
  // The function decodes the JSON file and updates _items with the "posts" data
  Future<void> readJson() async {
    // Load the JSON file as a string
    final String response =
        await rootBundle.loadString('assets/data/sampleData.json');
    // Decode the JSON string
    final data = await json.decode(response);
    // Update _items with the "posts" data and notify the framework
    setState(() {
      _items = data["posts"];
    });
  }

  @override
  void initState() {
    super.initState();
    // Call readJson in initState instead of build
    readJson();
  }

  // Define the user interface of the AccountPage
  @override
  Widget build(BuildContext context) {
    // Hardcoded data for the user's profile
    const username = '@gtang';
    const image = 'assets/images/GracePfp.png'; // Local asset path
    const name = 'Grace';
    const pronouns = 'she/her';
    const biography = 'CS @ CMU 2024; TJ Graduate :))))';

    // Load the data from the JSON file
    // readJson();

    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            ProfileSection(username, image, name, pronouns, biography),
            const MiddleNavBar(),
            PostList(_items),
          ],
        ),
      ),
    );
  }
}
