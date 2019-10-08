import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather/actions/adapt.dart';

class HourlyCell extends StatefulWidget {
  final double width;
  final double height;
  final Color topColor;
  final Color bottomColor;
  final HourlyCellType hourlyCellType;
  final Widget child;

  HourlyCell(
      {Key key,
      this.width,
      this.height,
      this.topColor,
      this.bottomColor,
      this.hourlyCellType = HourlyCellType.left,
      this.child})
      : super(key: key);

  @override
  HourlyCellState createState() => HourlyCellState();
}

class HourlyCellState extends State<HourlyCell> {
  CustomClipper clipper;
  @override
  void initState() {
    switch (widget.hourlyCellType) {
      case HourlyCellType.left:
        clipper = _LeftClipPath(height: widget.height, width: widget.width);
        break;
      case HourlyCellType.middle:
        clipper = _MiddleClipPath(height: widget.height, width: widget.width);
        break;
      case HourlyCellType.right:
        clipper = _RightClipPath(height: widget.height, width: widget.width);
        break;
      default:
        clipper = _LeftClipPath(height: widget.height, width: widget.width);
        break;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(Adapt.px(30)),
      child: Stack(
        children: <Widget>[
          Container(
            height: widget.height ?? 0,
            width: widget.width ?? 0,
            color: widget.topColor,
          ),
          ClipPath(
            clipper: clipper,
            child: Container(
              width: widget.width,
              height: widget.height,
              color: widget.bottomColor,
            ),
          ),
          widget.child ?? Container()
        ],
      ),
    );
  }
}

enum HourlyCellType { left, middle, right }

class _LeftClipPath extends CustomClipper<Path> {
  final double height;
  final double width;
  _LeftClipPath({this.height, this.width});

  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, height * 0.75);
    path.quadraticBezierTo(0, height * 0.5, 60, height * 0.5);
    path.lineTo(width, height * 0.5);
    path.lineTo(width, height);
    path.lineTo(0, height);
    return path;
  }

  @override
  bool shouldReclip(_LeftClipPath oldClipper) {
    return oldClipper.height != this.height || oldClipper.width != this.width;
  }
}

class _MiddleClipPath extends CustomClipper<Path> {
  final double height;
  final double width;
  _MiddleClipPath({this.height, this.width});

  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, height * 0.5);
    path.lineTo(width, height * 0.5);
    path.lineTo(width, height);
    path.lineTo(0, height);
    return path;
  }

  @override
  bool shouldReclip(_MiddleClipPath oldClipper) {
    return oldClipper.height != this.height || oldClipper.width != this.width;
  }
}

class _RightClipPath extends CustomClipper<Path> {
  final double height;
  final double width;
  _RightClipPath({this.height, this.width});

  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, height * 0.5);
    path.lineTo(width - 55, height * 0.5);
    path.quadraticBezierTo(width - 15, height * 0.5, width, height * 0.25);
    path.lineTo(width, height);
    path.lineTo(0, height);
    return path;
  }

  @override
  bool shouldReclip(_RightClipPath oldClipper) {
    return oldClipper.height != this.height || oldClipper.width != this.width;
  }
}
