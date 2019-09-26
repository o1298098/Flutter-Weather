import 'package:flutter/material.dart';
import 'package:weather/actions/adapt.dart';

class WeatherIcon extends StatelessWidget {
  final String icon;
  final double size;
  final Color color;

  WeatherIcon({Key key, @required this.icon, this.size = 30, this.color})
      : super(key: key);

  final Map<String, Color> colormap = {
    'clear-day': Color(0xFFFFD700),
    'clear-night': Color(0xFFB0C4DE),
    'partly-cloudy-day': Color(0xFFF0E68C),
    'rain': Color(0xFF5070CA),
  };

  Color _getColor() {
    Color r = colormap[icon];
    return r ?? Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'images/$icon.png',
      color: color ?? _getColor(),
      width: size,
      height: size,
    );
  }
}
