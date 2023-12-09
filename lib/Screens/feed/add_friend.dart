import 'package:flutter/material.dart';

class AddFriendPage extends StatelessWidget {
  const AddFriendPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
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