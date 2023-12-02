import 'package:flutter/material.dart';

class ProfileSection extends StatelessWidget {
  final String userName;
  final String imageURL;
  final String name;
  final String pronouns;
  final String biography;
  ProfileSection(
      this.userName, this.imageURL, this.name, this.pronouns, this.biography);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        topIcons(context),
        username(userName),
        profilePhoto(imageURL),
        profileName(name),
        pronoun(pronouns),
        editButton(context),
        profileBio(biography),
      ],
    );
  }
}

Widget profileBio(String personalBiography) {
  return Padding(
    padding: EdgeInsets.all(10.0),
    child: Text(
      personalBiography,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 16),
    ),
  );
}

Widget editButton(BuildContext context) {
  // Add onPress to edit
  return Padding(
    padding: const EdgeInsets.all(3.0),
    child: ElevatedButton.icon(
      onPressed: null,
      label: Text(
        'Edit profile',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 12),
      ),
      style: ElevatedButton.styleFrom(
          fixedSize: Size(130, 30),
          backgroundColor: Colors.black,
          elevation: 10,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
      icon: Icon(
        Icons.create_rounded,
        color: Colors.black,
        size: 25.0,
      ),
    ),
  );
}

Widget pronoun(String pronouns) {
  return Padding(
    padding: EdgeInsets.all(1.0),
    child: Text(
      pronouns,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 15),
    ),
  );
}

Widget username(String username) {
  return Padding(
    padding: const EdgeInsets.all(5.0),
    child: Text(
      username,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 15),
    ),
  );
}

Widget profilePhoto(String imageURL) {
  return CircleAvatar(
    backgroundImage: NetworkImage(imageURL),
    radius: 60,
  );
}

Widget profileName(String name) {
  return Padding(
    padding: const EdgeInsets.all(2.0),
    child: Text(
      name,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
    ),
  );
}

Widget topIcons(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Icon(
          Icons.upload,
          color: Colors.black,
          size: 33.0,
        ),
        Spacer(),
        GestureDetector(
          onTap: () {
            print("Settings was clicked");
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const Settings()));
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => Settings()),
            // );
          },
          child: Icon(
            Icons.settings,
            color: Colors.black,
            size: 33.0,
          ),
        ),
      ],
    ),
  );
}

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        Text(
          "How to use Catalist",
          textAlign: TextAlign.start,
          style: TextStyle(fontSize: 16),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: ElevatedButton.icon(
              onPressed: null,
              icon: Icon(Icons.format_color_fill,
                  color: Colors.black, size: 25.0),
              label: Text(
                "Tutorial",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12),
              )),
        ),
        Text(
          "Customize",
          textAlign: TextAlign.start,
          style: TextStyle(fontSize: 16),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: ElevatedButton.icon(
              onPressed: null,
              icon: Icon(Icons.format_color_fill,
                  color: Colors.black, size: 25.0),
              label: Text(
                "Theme",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12),
              )),
        ),
        Text(
          "Login",
          textAlign: TextAlign.start,
          style: TextStyle(fontSize: 16),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: ElevatedButton.icon(
              onPressed: null,
              icon: Icon(Icons.logout, color: Colors.black, size: 25.0),
              label: Text(
                "Log Out",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12),
              )),
        ),
      ]),
    );
  }
}
