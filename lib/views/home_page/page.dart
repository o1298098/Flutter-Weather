import 'package:fish_redux/fish_redux.dart';

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
              adapter: null, slots: <String, Dependent<HomePageState>>{}),
          middleware: <Middleware<HomePageState>>[],
        );
}
