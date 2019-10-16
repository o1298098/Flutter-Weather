import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    FutureWeatherPageState state, Dispatch dispatch, ViewService viewService) {
  return viewService.buildComponent('theme${state.themeIndex}');
}
