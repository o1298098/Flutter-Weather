import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:weather/models/darksky_weather_model.dart';

import '../../state.dart';

class Theme3State implements Cloneable<Theme3State> {
  AnimationController animationController;
  WeatherModel weather;
  bool isToday;
  String city;
  String country;
  @override
  Theme3State clone() {
    return Theme3State();
  }
}

class Theme3Connector extends ConnOp<HomePageState, Theme3State> {
  @override
  Theme3State get(HomePageState state) {
    Theme3State mstate = Theme3State();
    mstate.animationController = state.animationController;
    mstate.animationController = state.animationController;
    mstate.city = state.city;
    mstate.weather = state.weather;
    mstate.country = state.country;
    mstate.isToday = state.isToday;
    return mstate;
  }
}
