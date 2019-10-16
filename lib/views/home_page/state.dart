import 'dart:ui';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/animation.dart';
import 'package:weather/globalstore/state.dart';
import 'package:weather/models/darksky_weather_model.dart';

class HomePageState implements GlobalBaseState, Cloneable<HomePageState> {
  AnimationController animationController;
  WeatherModel weather;
  bool isToday;
  String city;
  String country;
  @override
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

  @override
  Color themeColor;
}

HomePageState initState(Map<String, dynamic> args) {
  return HomePageState()..isToday = true;
}
