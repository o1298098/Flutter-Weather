import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:geolocator/geolocator.dart';
import 'package:weather/actions/darksky_apihelper.dart';
import 'package:weather/actions/mapbox_apihelper.dart';
import 'package:weather/globalstore/action.dart';
import 'package:weather/globalstore/store.dart';
import 'package:weather/views/futureweather_page/page.dart';
import 'action.dart';
import 'state.dart';

Effect<HomePageState> buildEffect() {
  return combineEffects(<Object, Effect<HomePageState>>{
    HomePageAction.action: _onAction,
    HomePageAction.futureWeatherCilcked: _futureWeatherCilcked,
    HomePageAction.themeChanged: _themeChanged,
    Lifecycle.initState: _onInit,
    Lifecycle.dispose: _onDispose,
    Lifecycle.build: _onBuild
  });
}

void _onAction(Action action, Context<HomePageState> ctx) {}

void _onBuild(Action action, Context<HomePageState> ctx) {}
void _themeChanged(Action action, Context<HomePageState> ctx) {
  GlobalStore.store.dispatch(GlobalActionCreator.onchangeTheme());
}

void _futureWeatherCilcked(Action action, Context<HomePageState> ctx) async {
  await Navigator.of(ctx.context)
      .push(PageRouteBuilder(pageBuilder: (context, animation, secAnimation) {
    return FadeTransition(
        opacity: animation,
        child: FutureWeatherPage().buildPage({
          'data': ctx.state.weather.daily,
          'themeIndex': ctx.state.themeIndex,
          'city': ctx.state.city,
          'country': ctx.state.country
        }));
  }));
  /*await Navigator.of(ctx.context).pushNamed('futureWeatherPage', arguments: {
    'data': ctx.state.weather.daily,
    'themeIndex': ctx.state.themeIndex
  });*/
}

void _onInit(Action action, Context<HomePageState> ctx) async {
  final Object ticker = ctx.stfState;
  ctx.state.animationController =
      AnimationController(vsync: ticker, duration: Duration(milliseconds: 300));
  Position position = await Geolocator()
      .getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
  var location =
      await MapBoxApi.reverseGeocoding(position.latitude, position.longitude);
  if (location != null)
    ctx.dispatch(HomePageActionCreator.setLocation(
        location.features[1].text, location.features[0].text));
  var q = await ApiHelper.getWeather(position.latitude, position.longitude);
  if (q != null) ctx.dispatch(HomePageActionCreator.setWeather(q));
}

void _onDispose(Action action, Context<HomePageState> ctx) {
  ctx.state.animationController.dispose();
}
