import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:weather/actions/adapt.dart';
import 'package:weather/models/darksky_weather_model.dart';
import 'package:weather/widgets/weather_icon.dart';

import '../../action.dart';
import 'action.dart';
import 'state.dart';

Widget buildView(
    Theme1State state, Dispatch dispatch, ViewService viewService) {
  var _today =
      state.isToday ? DateTime.now() : DateTime.now().add(Duration(days: 1));
  var _todaySinceEpoch = DateTime(_today.year, _today.month, _today.day)
          .add(Duration(days: 1))
          .millisecondsSinceEpoch /
      1000;
  Widget _buildMenuButton() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Adapt.px(30)),
      alignment: Alignment.topRight,
      child: PopupMenuButton<String>(
          padding: EdgeInsets.zero,
          offset: Offset(0, Adapt.px(100)),
          icon: Icon(
            Icons.menu,
            color: Colors.white,
            size: Adapt.px(60),
          ),
          onSelected: (selected) {
            if (selected == 'Change Theme')
              dispatch(HomePageActionCreator.themeChanged());
          },
          itemBuilder: (ctx) {
            return <PopupMenuItem<String>>[
              PopupMenuItem<String>(
                value: 'Change Theme',
                child: Text('Change Theme'),
              )
            ];
          }),
    );
  }

  Widget _buildLocationCell() {
    Widget _child = state.city == null
        ? Container(
            key: ValueKey(state.city),
            margin: EdgeInsets.only(left: Adapt.px(50)),
            padding: EdgeInsets.fromLTRB(
                0, Adapt.px(45), Adapt.px(45), Adapt.px(45)),
            width: Adapt.px(95),
            height: Adapt.px(140),
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.white),
            ),
          )
        : Container(
            key: ValueKey(state.city),
            height: Adapt.px(140),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding:
                      EdgeInsets.only(left: Adapt.px(50), bottom: Adapt.px(15)),
                  child: Text(
                    '${state.city},',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: Adapt.px(45),
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: Adapt.px(50), bottom: Adapt.px(15)),
                  child: Text(
                    '${state.country}',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: Adapt.px(45),
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          );
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 300),
      child: _child,
    );
  }

  Widget _buildDayWeatherCell(HourlyData d) {
    return Container(
      margin: EdgeInsets.only(right: Adapt.px(30)),
      padding: EdgeInsets.symmetric(vertical: Adapt.px(20)),
      decoration: BoxDecoration(
          color: Color(0xFF376BEE),
          borderRadius: BorderRadius.circular(Adapt.px(60))),
      width: Adapt.px(120),
      height: Adapt.px(220),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Text(
            DateTime.fromMillisecondsSinceEpoch(d.time * 1000).hour.toString(),
            style: TextStyle(color: Colors.white, fontSize: Adapt.px(22)),
          ),
          WeatherIcon(
            icon: d.icon,
            color: Colors.white,
            size: Adapt.px(50),
          ),
          Text(
            '${d.apparentTemperature.floor()}°',
            style: TextStyle(color: Colors.white, fontSize: Adapt.px(22)),
          )
        ],
      ),
    );
  }

  Widget _buildShimmerCell() {
    return Shimmer.fromColors(
      baseColor: Color(0xFF376BEE),
      highlightColor: Color(0xDD376BEE),
      child: Container(
        margin: EdgeInsets.only(right: Adapt.px(30)),
        padding: EdgeInsets.symmetric(vertical: Adapt.px(20)),
        decoration: BoxDecoration(
            color: Color(0xFF376BEE),
            borderRadius: BorderRadius.circular(Adapt.px(60))),
        width: Adapt.px(120),
        height: Adapt.px(220),
      ),
    );
  }

  Widget _buildMiddleBody() {
    return Container(
      height: Adapt.screenH() / 2.3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: Text(
              'Today',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: Adapt.px(60),
                  fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(
            height: Adapt.px(20),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              WeatherIcon(
                icon: state.weather?.currently?.icon ?? 'clear-day',
                size: Adapt.px(140),
              ),
              SizedBox(
                width: Adapt.px(20),
              ),
              RichText(
                  text: TextSpan(children: <InlineSpan>[
                TextSpan(
                    text:
                        '${state.weather?.currently?.apparentTemperature?.floor() ?? 0}',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: Adapt.px(90),
                        fontWeight: FontWeight.bold,
                        letterSpacing: Adapt.px(10))),
                TextSpan(
                    text: '°',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: Adapt.px(90),
                        fontWeight: FontWeight.w300,
                        letterSpacing: Adapt.px(10))),
              ]))
            ],
          ),
          SizedBox(height: Adapt.px(20)),
          Container(
            alignment: Alignment.center,
            child: Text(
              '${state.weather != null ? state.weather.daily.data[0].summary : ''}',
              style: TextStyle(
                color: Colors.white,
                fontSize: Adapt.px(35),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchCell() {
    var _selectTextStyle = TextStyle(
        color: Colors.white,
        fontSize: Adapt.px(35),
        fontWeight: FontWeight.w500);
    var _unSelectTextStyle =
        TextStyle(color: Colors.grey[300], fontSize: Adapt.px(35));
    return Padding(
      padding: EdgeInsets.only(left: Adapt.px(50)),
      child: Row(
        children: <Widget>[
          InkWell(
            onTap: () => dispatch(HomePageActionCreator.isTodaychanged(true)),
            child: Text(
              'Today',
              style: state.isToday ? _selectTextStyle : _unSelectTextStyle,
            ),
          ),
          SizedBox(
            width: Adapt.px(40),
          ),
          InkWell(
              onTap: () =>
                  dispatch(HomePageActionCreator.isTodaychanged(false)),
              child: Text(
                'Tomorrow',
                style: state.isToday ? _unSelectTextStyle : _selectTextStyle,
              )),
          SizedBox(
            width: Adapt.px(40),
          ),
          InkWell(
            onTap: () => dispatch(HomePageActionCreator.futureWeatherCilcked()),
            child: Text(
              'Next 7 Days',
              style: _unSelectTextStyle,
            ),
          ),
          SizedBox(
            width: Adapt.px(10),
          ),
          Icon(
            Icons.arrow_forward,
            color: Colors.grey[400],
            size: Adapt.px(30),
          )
        ],
      ),
    );
  }

  return Scaffold(
      key: ValueKey('theme1'),
      body: Container(
        width: Adapt.screenW(),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[Color(0xFF2C52ED), Color(0xFF6996FE)],
                stops: <double>[0.0, 1.0])),
        child: SafeArea(
          bottom: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildMenuButton(),
              _buildLocationCell(),
              SizedBox(
                height: Adapt.px(15),
              ),
              Padding(
                padding: EdgeInsets.only(left: Adapt.px(50)),
                child: Text(
                  DateFormat.MMMEd().format(DateTime.now()),
                  style: TextStyle(color: Colors.white),
                ),
              ),
              _buildMiddleBody(),
              _buildSwitchCell(),
              SizedBox(
                height: Adapt.px(50),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  margin: EdgeInsets.fromLTRB(
                      Adapt.px(50), 0, Adapt.px(50), Adapt.px(50)),
                  padding: EdgeInsets.all(Adapt.px(50)),
                  //width: Adapt.px(2000),
                  height: Adapt.px(320),
                  decoration: BoxDecoration(
                      color: Color(0xFF6A97FF),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: Color(0xFF5F8BF6),
                            blurRadius: Adapt.px(20),
                            offset: Offset(Adapt.px(20), Adapt.px(20)))
                      ],
                      borderRadius: BorderRadius.circular(Adapt.px(50))),
                  child: Row(
                    children: state.weather != null
                        ? state.weather.hourly.data
                            .where((d) {
                              return state.isToday
                                  ? d.time < _todaySinceEpoch
                                  : d.time >= _todaySinceEpoch;
                            })
                            .map(_buildDayWeatherCell)
                            .toList()
                        : <Widget>[
                            _buildShimmerCell(),
                            _buildShimmerCell(),
                            _buildShimmerCell(),
                            _buildShimmerCell(),
                            _buildShimmerCell()
                          ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ));
}
