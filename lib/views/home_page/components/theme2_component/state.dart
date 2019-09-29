import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/widgets.dart';
import 'package:weather/models/darksky_weather_model.dart';

import '../../state.dart';

class Theme2State implements Cloneable<Theme2State> {
  AnimationController animationController;
  WeatherModel weather;
  bool isToday;
  String city;
  String country;

  @override
  Theme2State clone() {
    return Theme2State();
  }
}

class Theme2Connector extends ConnOp<HomePageState, Theme2State> {
  @override
  Theme2State get(HomePageState state) {
    Theme2State mstate = Theme2State();
    mstate.animationController = state.animationController;
    mstate.animationController = state.animationController;
    mstate.city = state.city;
    mstate.weather = state.weather;
    mstate.country = state.country;
    mstate.isToday = state.isToday;
    return mstate;
  }
}
