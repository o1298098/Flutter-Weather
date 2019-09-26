import 'package:fish_redux/fish_redux.dart';
import 'package:weather/models/darksky_weather_model.dart';

class FutureWeatherPageState implements Cloneable<FutureWeatherPageState> {
  Daily daily;

  @override
  FutureWeatherPageState clone() {
    return FutureWeatherPageState()..daily = daily;
  }
}

FutureWeatherPageState initState(Map<String, dynamic> args) {
  FutureWeatherPageState state = FutureWeatherPageState();
  state.daily = args['data'];
  return state;
}
