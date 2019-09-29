import 'package:fish_redux/fish_redux.dart';
import 'package:weather/models/darksky_weather_model.dart';

import '../../state.dart';

class Theme1State implements Cloneable<Theme1State> {
  Daily daily;
  @override
  Theme1State clone() {
    return Theme1State();
  }
}

class Theme1Connector extends ConnOp<FutureWeatherPageState, Theme1State> {
  @override
  Theme1State get(FutureWeatherPageState state) {
    Theme1State mstate = Theme1State();
    mstate.daily = state.daily;
    return mstate;
  }
}
