import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sashimi/utils/color_utils.dart';

void main() {
  test('Convert hex color string to Color object', () {
    // Test case 1: Valid hex color string
    String hexColor1 = "#FF0000";
    Color? color1 = hexStringToColor(hexColor1);
    expect(color1, equals(const Color(0xFFFF0000)));

    // Test case 2: Valid hex color string without #
    String hexColor2 = "00FF00";
    Color? color2 = hexStringToColor(hexColor2);
    expect(color2, equals(const Color(0xff00ff00)));

    // Test case 3: Short hex color string
    String hexColor4 = "#FFF";
    Color? color4 = hexStringToColor(hexColor4);
    expect(color4, equals(const Color(0xffffffff)));

    // Test case 5: Invalid hex color string
    String hexColor5 = "";
    Color? color5 = hexStringToColor(hexColor5);
    expect(color5, equals(null));
  });
}
