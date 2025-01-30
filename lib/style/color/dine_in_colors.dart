import 'package:flutter/material.dart';

enum DineInColors {
  colorPrimary("ColorPrimary", Colors.orange, Color(0xFF5a3003)),
  cardColor("CardColor", Color(0xFFFFF8F5), Color(0xFF361d02)),
  buttonFilledColor("ButtonTextColor", Colors.orange, Color(0xFF7e4304)),
  buttonTextColor("ButtonTextColor", Colors.black, Colors.white);

  const DineInColors(this.name, this.lightColor, this.darkColor);

  final String name;
  final Color lightColor;
  final Color darkColor;

  Color getColor(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return isDarkMode ? darkColor : lightColor;
  }
}
