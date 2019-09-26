import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum FutureWeatherPageAction { action }

class FutureWeatherPageActionCreator {
  static Action onAction() {
    return const Action(FutureWeatherPageAction.action);
  }
}
