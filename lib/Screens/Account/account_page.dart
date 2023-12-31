import 'package:flutter/material.dart';
import 'profile.dart';
// import 'photo.dart';
// import 'top.dart';
// import 'edit.dart';
import 'midNav.dart';
// import 'bio.dart';
// import 'nameTag.dart';
// import 'name.dart';
// import 'pronouns.dart';
import 'posts.dart';
import 'dart:convert';
import 'dart:async';
import 'package:flutter/services.dart';

// await Firebase.initializeApp(
//   options: DefaultFirebaseOptions.currentPlatform,
// );

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  List _items = [];

  // Fetch content from the json file
  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('assets/data/sampleData.json');
    final data = await json.decode(response);
    setState(() {
      _items = data["posts"];
      // print("The number of posts are ${_items.length}");
    });
  }

  @override
  Widget build(BuildContext context) {
    const username = '@gtang';
    const image = 'assets/images/GracePfp.png'; // Local asset path
    const name = 'Grace';
    const pronouns = 'she/her';
    const biography = 'CS @ CMU 2024; TJ Graduate :))))';

    readJson();

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
