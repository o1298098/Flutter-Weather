import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:weather/models/darksky_weather_model.dart';

import '../../state.dart';

class Theme2State implements Cloneable<Theme2State> {
  Daily daily;
  AnimationController animationController;
  AnimationController tabController;
  @override
  Theme2State clone() {
    return Theme2State();
  }
}

class Theme2Connector extends ConnOp<FutureWeatherPageState, Theme2State> {
  @override
  Theme2State get(FutureWeatherPageState state) {
    Theme2State mstate = Theme2State();
    mstate.daily = state.daily;
    mstate.tabController = state.tabController;
    mstate.animationController = state.animationController;
    return mstate;
  }
}
