import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/widgets.dart';
import 'package:weather/models/darksky_weather_model.dart';

import '../../state.dart';

class Theme1State implements Cloneable<Theme1State> {
  AnimationController animationController;
  WeatherModel weather;
  bool isToday;
  String city;
  String country;

  @override
  Theme1State clone() {
    return Theme1State();
  }
}

class Theme1Connector extends ConnOp<HomePageState, Theme1State> {
  @override
  Theme1State get(HomePageState state) {
    Theme1State mstate = Theme1State();
    mstate.animationController = state.animationController;
    mstate.animationController = state.animationController;
    mstate.city = state.city;
    mstate.weather = state.weather;
    mstate.country = state.country;
    mstate.isToday = state.isToday;
    return mstate;
  }
}
