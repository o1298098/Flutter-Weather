import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'action.dart';
import 'state.dart';

Effect<FutureWeatherPageState> buildEffect() {
  return combineEffects(<Object, Effect<FutureWeatherPageState>>{
    FutureWeatherPageAction.action: _onAction,
    Lifecycle.initState: _initState,
    Lifecycle.build: _build,
    Lifecycle.dispose: _dispose,
  });
}

void _onAction(Action action, Context<FutureWeatherPageState> ctx) {}

void _initState(Action action, Context<FutureWeatherPageState> ctx) {
  final Object ticker = ctx.stfState;
  ctx.state.animationController = AnimationController(
      vsync: ticker,
      duration: Duration(milliseconds: 1500),
      reverseDuration: Duration(milliseconds: 800));
  ctx.state.tabController =
      AnimationController(vsync: ticker, duration: Duration(milliseconds: 300));
}

Future _build(Action action, Context<FutureWeatherPageState> ctx) async {
  await ctx.state.animationController.forward();
}

void _dispose(Action action, Context<FutureWeatherPageState> ctx) {
  ctx.state.animationController.dispose();
  ctx.state.tabController.dispose();
}
