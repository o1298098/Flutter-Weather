import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:weather/models/darksky_weather_model.dart';

class FutureWeatherPageState implements Cloneable<FutureWeatherPageState> {
  Daily daily;

  String city;
  String country;

  AnimationController animationController;
  AnimationController tabController;

  int themeIndex;

  @override
  FutureWeatherPageState clone() {
    return FutureWeatherPageState()
      ..daily = daily
      ..themeIndex = themeIndex
      ..animationController = animationController
      ..tabController = tabController;
  }
}

FutureWeatherPageState initState(Map<String, dynamic> args) {
  FutureWeatherPageState state = FutureWeatherPageState();
  state.daily = args['data'];
  state.themeIndex = args['themeIndex'];
  state.city = args['city'];
  state.country = args['country'];
  return state;
}
