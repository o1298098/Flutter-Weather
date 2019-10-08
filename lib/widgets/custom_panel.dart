import 'package:flutter/material.dart';
import 'package:weather/actions/adapt.dart';

class CustomPanelCliper extends CustomClipper<Path> {
  final double headerHeight;
  final double width;
  CustomPanelCliper({this.headerHeight, this.width});
  @override
  getClip(Size size) {
    Path path = Path();
    path.moveTo(0, headerHeight);
    path.quadraticBezierTo(30, headerHeight, 40, headerHeight * 0.75);
    path.quadraticBezierTo(50, headerHeight * 0.5, 110, headerHeight * 0.5);
    path.lineTo(Adapt.screenW() - 110, headerHeight * 0.5);
    path.quadraticBezierTo(Adapt.screenW() - 50, headerHeight * 0.5,
        Adapt.screenW() - 40, headerHeight * 0.25);
    path.quadraticBezierTo(Adapt.screenW() - 30, 0, Adapt.screenW() + 10, 0);
    path.lineTo(Adapt.screenW(), headerHeight);
    path.lineTo(0, headerHeight);
    return path;
  }

  @override
  bool shouldReclip(CustomPanelCliper oldClipper) {
    return oldClipper.headerHeight != headerHeight;
  }
}
