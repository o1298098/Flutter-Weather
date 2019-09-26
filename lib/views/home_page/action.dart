import 'package:fish_redux/fish_redux.dart';
import 'package:weather/models/darksky_weather_model.dart';

//TODO replace with your own action
enum HomePageAction {
  action,
  setLocation,
  setWeather,
  futureWeatherCilcked,
  isTodaychanged
}

class HomePageActionCreator {
  static Action onAction() {
    return const Action(HomePageAction.action);
  }

  static Action isTodaychanged(bool b) {
    return Action(HomePageAction.isTodaychanged, payload: b);
  }

  static Action setLocation(String country, String city) {
    return Action(HomePageAction.setLocation, payload: [country, city]);
  }

  static Action setWeather(WeatherModel d) {
    return Action(HomePageAction.setWeather, payload: d);
  }

  static Action futureWeatherCilcked() {
    return Action(HomePageAction.futureWeatherCilcked);
  }
}
