import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/actions/adapt.dart';
import 'package:weather/actions/weekday.dart';
import 'package:weather/models/darksky_weather_model.dart';
import 'package:weather/widgets/weather_icon.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    Theme1State state, Dispatch dispatch, ViewService viewService) {
  Widget _buildWeatherCell(DailyData d) {
    return Padding(
      padding: EdgeInsets.only(bottom: 40),
      child: Row(
        children: <Widget>[
          Text(
            DateFormat.EEEE()
                .format(DateTime.fromMillisecondsSinceEpoch(d.time * 1000)),
            style: TextStyle(fontSize: Adapt.px(30)),
          ),
          SizedBox(
            width: Adapt.px(30),
          ),
          Expanded(
            child: Container(),
          ),
          WeatherIcon(icon: d.icon),
          SizedBox(
            width: Adapt.px(50),
          ),
          Text('${d.temperatureLow.floor()}°~${d.temperatureHigh.floor()}°'),
          SizedBox(
            width: Adapt.px(40),
          ),
        ],
      ),
    );
  }

  return Scaffold(
    //backgroundColor: Colors.white,
    appBar: AppBar(
      brightness: Brightness.light,
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      iconTheme: IconThemeData(color: Colors.black),
    ),
    body: Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Adapt.px(50),
      ),
      child: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          SizedBox(
            height: Adapt.px(50),
          ),
          Text(
            'Next 7 Days',
            style:
                TextStyle(fontWeight: FontWeight.bold, fontSize: Adapt.px(50)),
          ),
          SizedBox(
            height: Adapt.px(80),
          ),
        ]..addAll(
            state.daily.data.getRange(1, 8).map(_buildWeatherCell).toList()),
      ),
    ),
  );
}
