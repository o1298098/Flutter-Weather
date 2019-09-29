import 'package:fish_redux/fish_redux.dart';
import 'package:weather/models/darksky_weather_model.dart';

import 'action.dart';
import 'state.dart';

Reducer<HomePageState> buildReducer() {
  return asReducer(
    <Object, Reducer<HomePageState>>{
      HomePageAction.action: _onAction,
      HomePageAction.setLocation: _setLocation,
      HomePageAction.setWeather: _setWeather,
      HomePageAction.isTodaychanged: _isTodaychanged,
      HomePageAction.themeChanged: _themeChanged,
    },
  );
}

HomePageState _onAction(HomePageState state, Action action) {
  final HomePageState newState = state.clone();
  return newState;
}

HomePageState _isTodaychanged(HomePageState state, Action action) {
  final bool b = action.payload ?? true;
  final HomePageState newState = state.clone();
  newState.isToday = b;
  return newState;
}

HomePageState _setLocation(HomePageState state, Action action) {
  final String country = action.payload[0] ?? 'unkown';
  final String city = action.payload[1] ?? 'unkown';
  final HomePageState newState = state.clone();
  newState.country = country;
  newState.city = city;
  return newState;
}

HomePageState _setWeather(HomePageState state, Action action) {
  final WeatherModel model = action.payload;
  final HomePageState newState = state.clone();
  newState.weather = model;
  return newState;
}

HomePageState _themeChanged(HomePageState state, Action action) {
  int _index = state.themeIndex + 1;
  if (_index >= 3) _index = 1;
  final HomePageState newState = state.clone();
  newState.themeIndex = _index;
  return newState;
}
