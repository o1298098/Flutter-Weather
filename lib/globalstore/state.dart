import 'dart:ui';

import 'package:fish_redux/fish_redux.dart';

abstract class GlobalBaseState {
  Color get themeColor;
  set themeColor(Color color);

  int get themeIndex;
  set themeIndex(int index);
}

class GlobalState implements GlobalBaseState, Cloneable<GlobalState> {
  @override
  Color themeColor;

  @override
  int themeIndex;

  @override
  GlobalState clone() {
    return GlobalState()
      ..themeColor = themeColor
      ..themeIndex = themeIndex;
  }
}
