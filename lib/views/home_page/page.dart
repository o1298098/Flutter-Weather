import 'package:fish_redux/fish_redux.dart';
import 'package:weather/views/home_page/components/theme1_component/component.dart';
import 'package:weather/views/home_page/components/theme1_component/state.dart';

import 'components/theme2_component/component.dart';
import 'components/theme2_component/state.dart';
import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class HomePage extends Page<HomePageState, Map<String, dynamic>>
    with TickerProviderMixin {
  HomePage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<HomePageState>(
              adapter: null,
              slots: <String, Dependent<HomePageState>>{
                'theme1': Theme1Connector() + Theme1Component(),
                'theme2': Theme2Connector() + Theme2Component(),
              }),
          middleware: <Middleware<HomePageState>>[],
        );
}
