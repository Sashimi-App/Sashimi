import 'package:flutter/material.dart';

class MiddleNavBar extends StatelessWidget {
  const MiddleNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Icon(
          Icons.grid_view,
          color: Colors.black,
          size: 33.0,
        ),
        Icon(
          Icons.storage,
          color: Colors.black,
          size: 33.0,
        ),
      ],
    );
  }
}
