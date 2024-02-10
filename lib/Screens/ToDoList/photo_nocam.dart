// ignore_for_file: unused_import, depend_on_referenced_packages

import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:camera/camera.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class PhotoTakingScreenNoCam extends StatefulWidget {
  const PhotoTakingScreenNoCam({
    super.key,
  });

  @override
  State<PhotoTakingScreenNoCam> createState() => _MyPhotoTakingScreenState();
}

class _MyPhotoTakingScreenState extends State<PhotoTakingScreenNoCam> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.90,
          height: MediaQuery.of(context).size.height * 0.67,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.black,
              width: 2,
            ),
          ),
          child: Container(),
        ),
      ),
      Positioned(
        top: 40,
        left: 20,
        child: IconButton(
          icon: const Icon(Icons.arrow_back),
          iconSize: 30,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      Positioned(
        top: 40,
        right: 20,
        child: IconButton(
          icon: const Icon(Icons.camera_alt),
          iconSize: 30,
          onPressed: () {
            // Add camera flip functionality here
          },
        ),
      ),
      Positioned(
        bottom: 40,
        left: MediaQuery.of(context).size.width * 0.41,
        child: ElevatedButton(
          onPressed: () {
            // Add functionality for the bottom middle button here
          },
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            backgroundColor: Colors.white,
            padding: const EdgeInsets.all(20),
            side: const BorderSide(color: Colors.black, width: 2),
          ),
          child: const Icon(
            Icons.circle,
            size: 40,
            color: Colors.white,
          ),
        ),
      ),
    ]));
  }
}
