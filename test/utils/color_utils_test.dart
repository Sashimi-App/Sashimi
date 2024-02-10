import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:Sashimi/utils/color_utils.dart';

void main() {
  test('Convert hex color string to Color object', () {
    // Test case 1: Valid hex color string
    String hexColor1 = "#FF0000";
    Color color1 = hexStringToColor(hexColor1);
    expect(color1, equals(Colors.red));

    // Test case 2: Valid hex color string without #
    String hexColor2 = "00FF00";
    Color color2 = hexStringToColor(hexColor2);
    expect(color2, equals(Colors.green));

    // Test case 3: Valid hex color string with lowercase letters
    String hexColor3 = "#0000FF";
    Color color3 = hexStringToColor(hexColor3);
    expect(color3, equals(Colors.blue));

    // Test case 4: Short hex color string
    String hexColor4 = "#FFF";
    Color color4 = hexStringToColor(hexColor4);
    expect(color4, equals(Colors.white));

    // Test case 5: Invalid hex color string
    String hexColor5 = "123456";
    Color color5 = hexStringToColor(hexColor5);
    expect(color5, equals(null));
  });
}
