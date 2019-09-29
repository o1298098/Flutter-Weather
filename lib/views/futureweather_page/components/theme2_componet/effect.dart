import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/widgets.dart' hide Action;
import 'action.dart';
import 'state.dart';

Effect<Theme2State> buildEffect() {
  return combineEffects(<Object, Effect<Theme2State>>{
    Theme2Action.action: _onAction,
    Theme2Action.goBack: _goBack
  });
}

void _onAction(Action action, Context<Theme2State> ctx) {}
void _goBack(Action action, Context<Theme2State> ctx) async {
  await ctx.state.animationController.reverse();
  Navigator.of(ctx.context).pop();
}
