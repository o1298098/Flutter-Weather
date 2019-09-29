import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum Theme2Action { action, goBack }

class Theme2ActionCreator {
  static Action onAction() {
    return const Action(Theme2Action.action);
  }

  static Action goBack() {
    return const Action(Theme2Action.goBack);
  }
}
