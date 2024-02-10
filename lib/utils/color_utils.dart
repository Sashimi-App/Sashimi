import 'package:flutter/material.dart';

Color? hexStringToColor(String hexColor) {
  try {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 3) {
      // Expand short hex code to full length
      hexColor = "${hexColor[0]}${hexColor[0]}${hexColor[1]}${hexColor[1]}${hexColor[2]}${hexColor[2]}";
    }
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor"; // Ensure opacity is set
    }
    return Color(int.parse(hexColor, radix: 16));
  } catch (e) {
    // Handle invalid hex string (e.g., return null or a default color)
    return null;
  }
}