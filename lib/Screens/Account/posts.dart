import 'package:flutter/material.dart';
// import 'settings.dart';

class PostList extends StatelessWidget {
  final List postData;
  PostList(this.postData);

  @override
  Widget build(BuildContext context) {
    // print("AGAIN, NUMNBER OF POSTS ARE ${postData.length}");
    return GridView.count(
        crossAxisCount: 3,
        shrinkWrap: true,
        padding: const EdgeInsets.only(left: 15, right: 15),
        children: List.generate(postData.length, (index) {
          return GestureDetector(
            onTap: () {
              print("Post ${index} was clicked");
            },
            child: Card(
                shadowColor: Colors.black,
                elevation: 1,
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Stack(alignment: Alignment.center, children: [
                  Ink.image(
                    image: AssetImage(postData[index]["image"]),
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: MediaQuery.of(context).size.height * 0.3,
                    fit: BoxFit.cover,
                  ),
                  Text(
                    postData[index]["title"],
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ])),
          );
        }));
    // ]);
  }
}
