import 'package:flutter/material.dart';
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
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.search_outlined, color: Colors.black, size: 50),
          onPressed: () {
            print("search button pressed!");
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.person_add, color: Colors.black, size: 50),
            onPressed: () {
              print("Add button pressed!");
            },
          ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.amber[800],
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home),
            label: 'Feed',
          ),
          NavigationDestination(
            icon: Icon(Icons.list),
            label: 'Todos',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.school),
            icon: Icon(Icons.account_circle),
            label: 'Account',
          ),
        ],
      ),
      body: <Widget>[
        Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            alignment: Alignment.center,
            child: ListView.builder(
                itemCount: 5,
                prototypeItem: const FeedContent(
                    acc_Name: "dksung",
                    uploadImage: 'assets/images/sashimigym.png'),
                itemBuilder: (context, index) {
                  return FeedContent(
                      acc_Name: accounts[index], uploadImage: accUpload[index]);
                })),
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
                        const SizedBox(width: 115),
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
