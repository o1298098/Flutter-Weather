import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/animation.dart';
import 'package:weather/models/darksky_weather_model.dart';

class HomePageState implements Cloneable<HomePageState> {
  AnimationController animationController;
  WeatherModel weather;
  bool isToday;
  String city;
  String country;
  int themeIndex;

  @override
  HomePageState clone() {
    return HomePageState()
      ..animationController = animationController
      ..weather = weather
      ..isToday = isToday
      ..city = city
      ..country = country
      ..themeIndex = themeIndex;
  }
}

HomePageState initState(Map<String, dynamic> args) {
  return HomePageState()
    ..isToday = true
    ..themeIndex = 2;
}
