import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:weather/actions/adapt.dart';
import 'package:weather/actions/weekday.dart';
import 'package:weather/models/darksky_weather_model.dart';
import 'package:weather/widgets/weather_icon.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    FutureWeatherPageState state, Dispatch dispatch, ViewService viewService) {
  return viewService.buildComponent('theme${state.themeIndex}');
}
