import 'package:fish_redux/fish_redux.dart';

import 'components/theme1_componet/component.dart';
import 'components/theme1_componet/state.dart';
import 'components/theme2_componet/component.dart';

import 'components/theme2_componet/state.dart';
import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class FutureWeatherPage
    extends Page<FutureWeatherPageState, Map<String, dynamic>>
    with TickerProviderMixin {
  FutureWeatherPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<FutureWeatherPageState>(
              adapter: null,
              slots: <String, Dependent<FutureWeatherPageState>>{
                'theme1': Theme1Connector() + Theme1Component(),
                'theme2': Theme2Connector() + Theme2Component(),
              }),
          middleware: <Middleware<FutureWeatherPageState>>[],
        );
}
