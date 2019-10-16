import 'package:flutter/material.dart';

class HourlyCellColor {
  static HourlyColors getColor(int time) {
    var hour = DateTime.fromMillisecondsSinceEpoch(time * 1000).hour;
    if (hour >= 7 && hour < 18)
      return HourlyColors(
          topColor: Color(0xFFF57F4C), bottomColor: Color(0xFFDF646D));
    else if (hour >= 18 && hour < 19)
      return HourlyColors(
          topColor: Color(0xFFAC5887), bottomColor: Color(0xFF806C91));
    else
      return HourlyColors(
          topColor: Color(0xFF404D70), bottomColor: Color(0xFF293F50));
  }
}

class HourlyColors {
  final Color topColor;
  final Color bottomColor;
  HourlyColors({this.topColor, this.bottomColor});
}
