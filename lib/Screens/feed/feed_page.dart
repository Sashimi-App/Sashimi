import 'package:Sashimi/Screens/feed/add_friend.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  int currentPageIndex = 0;
  final List<String> accounts = ["andrew", "daniel", "bob", "joe", "pam"];
  final List<String> accUpload = [
    'assets/images/sashimigym.png',
    'assets/images/sashimigym.png',
    'assets/images/sashimigym.png',
    'assets/images/sashimigym.png',
    'assets/images/logo.png'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        titleSpacing: 5,
        automaticallyImplyLeading: false,
        title:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          IconButton(
            icon: Icon(Icons.search_outlined, color: Colors.black, size: 35),
            onPressed: () {
              print("search button pressed!");
            },
            splashRadius: 25,
          ),
          Spacer(),
          IconButton(
            icon: Icon(Icons.person_add_alt_1_sharp,
                color: Colors.black, size: 35),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddFriendPage()),
              );
              print("search button pressed!");
            },
            splashRadius: 25,
          ),
        ]),
      ),
      body: buildFeed(context),
    );
  }
}

Widget buildFeed(BuildContext context) {
  return StreamBuilder<QuerySnapshot>(
    stream: FirebaseFirestore.instance.collection('user').snapshots(),
    builder: (context, snapshot) {
      if (snapshot.hasError) {
        print("Error: ${snapshot.error}");
        return Text("Something went wrong");
      }

      if (!snapshot.hasData) {
        print("Awaiting data...");
        return LinearProgressIndicator();
      }

      print("Data received: ${snapshot.data?.docs.length} documents");
      return _buildList(context, snapshot.data?.docs ?? []);
    },
  );
}

// Widget buildFeed(BuildContext context) {
//   return StreamBuilder<QuerySnapshot>(
//     stream: FirebaseFirestore.instance.collection('user').snapshots(),
//     builder: (context, snapshot) {
//       if (!snapshot.hasData) return LinearProgressIndicator();

//       return _buildList(context, snapshot.data?.docs ?? []);
//     },
//   );
// }

Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
  return ListView(
    padding: const EdgeInsets.only(top: 20.0),
    children: snapshot.map((data) => _buildListItem(context, data)).toList(),
  );
}

Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
  final user = User.fromSnapshot(data);

  return Padding(
    key: ValueKey(user.name),
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: FeedContent(
          acc_Name: user.name,
          uploadImage: user.imgAddress,
        )),
  );
}

class User {
  final String name;
  final String imgAddress;
  final DocumentReference? reference;

  User.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['name'] != null),
        assert(map['imgAddress'] != null),
        name = map['name'],
        imgAddress = map['imgAddress'];

  User.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data as Map<String, dynamic>? ?? {},
            reference: snapshot.reference);

  @override
  String toString() => "User<$name:$imgAddress>";
}

class FeedContent extends StatelessWidget {
  const FeedContent(
      {super.key, required this.acc_Name, required this.uploadImage});
  final String acc_Name;
  final String uploadImage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
          height: MediaQuery.of(context).size.height *
              0.7, // Set the desired height here
          width: MediaQuery.of(context).size.width * 0.8,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              border: Border.all(color: Colors.black, width: 2.0)),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(children: [
                          IconButton(
                              icon: Icon(Icons.account_box_rounded),
                              onPressed: () {
                                print("account button pressed!");
                              }),
                          SizedBox(width: 20),
                          Text(
                            acc_Name,
                            style: TextStyle(
                              fontSize: 18, // Change the font size as needed
                            ),
                          ),
                        ]),
                        SizedBox(width: 115),
                        IconButton(
                            icon: Icon(Icons.more_horiz, size: 30),
                            onPressed: () {
                              print("more info button pressed!");
                            }),
                      ]),
                  Container(
                      height: MediaQuery.of(context).size.height *
                          0.5, // Set the desired height here
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(color: Colors.black, width: 2.0)),
                      child: Stack(
                        children: [
                          Container(
                            foregroundDecoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(uploadImage),
                                    fit: BoxFit.fill),
                                borderRadius: BorderRadius.circular(20.0)),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                    icon: Icon(Icons.favorite_border),
                                    onPressed: () {
                                      print("like button pressed!");
                                    }),
                                IconButton(
                                    icon: Icon(Icons.emoji_emotions_outlined),
                                    onPressed: () {
                                      print("react button pressed!");
                                    }),
                              ],
                            ),
                          ),
                        ],
                      )),
                  const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Task Title',
                        style: TextStyle(
                          fontSize: 18, // Change the font size as needed
                        ),
                      )),
                  Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Add comment...',
                        style: TextStyle(
                          fontSize: 18, // Change the font size as needed
                          color: Colors.black.withOpacity(0.5),
                        ),
                      )),
                ]),
          )),
    );
  }
}
