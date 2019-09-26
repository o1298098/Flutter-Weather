import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<FutureWeatherPageState> buildEffect() {
  return combineEffects(<Object, Effect<FutureWeatherPageState>>{
    FutureWeatherPageAction.action: _onAction,
  });
}

void _onAction(Action action, Context<FutureWeatherPageState> ctx) {
}
