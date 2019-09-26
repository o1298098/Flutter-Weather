import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<FutureWeatherPageState> buildReducer() {
  return asReducer(
    <Object, Reducer<FutureWeatherPageState>>{
      FutureWeatherPageAction.action: _onAction,
    },
  );
}

FutureWeatherPageState _onAction(FutureWeatherPageState state, Action action) {
  final FutureWeatherPageState newState = state.clone();
  return newState;
}
