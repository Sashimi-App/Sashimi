import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Sashimi/screens/Login/signin_screen.dart';

class AddFriendPage extends StatelessWidget {
  const AddFriendPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          titleSpacing: 5,
          automaticallyImplyLeading: false,
          leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new_outlined,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        body: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Column(
              children: [
                Center(
                  child: Container(
                      height: MediaQuery.of(context).size.height * 0.05,
                      width: MediaQuery.of(context).size.width * 0.8,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          border: Border.all(color: Colors.black, width: 1.3)),
                      child: Container(
                          alignment: Alignment.centerLeft,
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("Add or search friends"),
                          ))),
                ),
                const SizedBox(height: 20),
                Container(
                    alignment: Alignment.centerLeft,
                    child: const Text("ADD YOUR CONTACTS")),
                Container(
                    height: MediaQuery.of(context).size.height * 0.7,
                    width: MediaQuery.of(context).size.width * 0.9,
                    alignment: Alignment.center,
                    child: ListView.builder(
                        itemCount: 5,
                        prototypeItem: const AddFriendComp(),
                        itemBuilder: (context, index) {
                          return const AddFriendComp();
                        })),
              ],
            ),
          ),
        ));
  }
}

class AddFriendComp extends StatelessWidget {
  const AddFriendComp({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              foregroundDecoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: AssetImage('assets/images/sashimigym.png'),
                    fit: BoxFit.cover),
              ),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.blueGrey, width: 0.1)),
              width: MediaQuery.of(context).size.width * 0.1,
              height: MediaQuery.of(context).size.width * 0.1,
            ),
            const SizedBox(width: 7),
            const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Text("Steven"), Text("steve123")],
            ),
          ],
        ),
        Row(
          children: [
            IconButton(
              iconSize: 25,
              icon: const Icon(Icons.person_add_alt),
              onPressed: () {
                print("add button pressed");
              },
              splashRadius: 20,
            ),
            IconButton(
              iconSize: 25,
              icon: const Icon(Icons.close),
              onPressed: () {
                print("close button pressed");
              },
              splashRadius: 20,
            )
          ],
        )
      ],
    );
  }
}

class FeedPage extends StatefulWidget {
  // final TextEditingController emailController;
  const FeedPage({Key? key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        titleSpacing: 5,
        automaticallyImplyLeading: false,
        title:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          IconButton(
            icon: const Icon(Icons.search_outlined, color: Colors.black, size: 35),
            onPressed: () {
              print("search button pressed!");
            },
            splashRadius: 25,
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.person_add_alt_1_sharp,
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
      // bottomNavigationBar: NavigationBar(
      //   onDestinationSelected: (int index) {
      //     setState(() {
      //       currentPageIndex = index;
      //     });
      //   },
      //   indicatorColor: Colors.amber[800],
      //   selectedIndex: currentPageIndex,
      //   destinations: const <Widget>[
      //     NavigationDestination(
      //       selectedIcon: Icon(Icons.home),
      //       icon: Icon(Icons.home),
      //       label: 'Feed',
      //     ),
      //     NavigationDestination(
      //       icon: Icon(Icons.list),
      //       label: 'Todos',
      //     ),
      //     NavigationDestination(
      //       selectedIcon: Icon(Icons.school),
      //       icon: Icon(Icons.account_circle),
      //       label: 'Account',
      //     ),
      //   ],
      // ),
      body: <Widget>[
        buildFeed(context),
        Container(
          color: Colors.white,
          alignment: Alignment.center,
          child: const Text('Todo Page'),
        ),
        Container(
          color: Colors.white,
          alignment: Alignment.center,
          child: const Text('Account Page'),
        ),
      ][currentPageIndex],
    );
  }
}

Widget buildFeed(BuildContext context) {
  return StreamBuilder<QuerySnapshot>(
    stream: FirebaseFirestore.instance.collection('users').snapshots(),
    builder: (context, snapshot) {
      if (!snapshot.hasData) {
        return const LinearProgressIndicator();
      }
      // Unwrap the nullable type
      final documents = snapshot.data!.docs;

      print(documents.map((doc) => doc.data()));
      return _buildList(context, documents);
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
    padding: const EdgeInsets.only(top: 10.0),
    children: snapshot.map((data) => _buildListItem(context, data)).toList(),
  );
}

Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
  final user = User.fromSnapshot(data);
  return Padding(
    key: ValueKey(user.name),
    padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
    child: FeedContent(
      acc_Name: user.name,
      uploadImage: user.imgAddress,
    ),
  );
}

class User {
  final String name;
  final String imgAddress;
  final DocumentReference reference;
  final List<String> friends;

  User.fromMap(Map<String, dynamic> map, {required this.reference})
      : assert(map['first_name'] != null),
        assert(map['imgAddress'] != null),
        assert(map['friends'] != null),
        name = '${map['first_name']} ${map['last_name']}',
        imgAddress = map['imgAddress'],
        friends = List<String>.from(map['friends']);

  User.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data() as Map<String, dynamic>,
            reference: snapshot.reference);

  @override
  String toString() => "User<$name:$imgAddress>";

  bool isFriend(DocumentReference email) {
    return friends.contains(email);
  }
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
                              icon: const Icon(Icons.account_box_rounded),
                              onPressed: () {
                                print("account button pressed!");
                              }),
                          const SizedBox(width: 20),
                          Text(
                            acc_Name,
                            style: const TextStyle(
                              fontSize: 18, // Change the font size as needed
                            ),
                          ),
                        ]),
                        IconButton(
                            icon: const Icon(Icons.more_horiz, size: 30),
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
                                    image: NetworkImage(uploadImage),
                                    fit: BoxFit.fill),
                                borderRadius: BorderRadius.circular(20.0)),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                    icon: const Icon(Icons.favorite_border),
                                    onPressed: () {
                                      print("like button pressed!");
                                    }),
                                IconButton(
                                    icon: const Icon(Icons.emoji_emotions_outlined),
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