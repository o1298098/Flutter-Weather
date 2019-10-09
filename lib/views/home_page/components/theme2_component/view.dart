import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:weather/actions/adapt.dart';
import 'package:weather/actions/weathertype_helper.dart';
import 'package:weather/actions/weekday.dart';
import 'package:weather/views/home_page/action.dart';
import 'package:weather/widgets/weather_icon.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    Theme2State state, Dispatch dispatch, ViewService viewService) {
  final ThemeData _lightTheme = ThemeData.light().copyWith(
      backgroundColor: Colors.white,
      primaryColor: Color(0xFFFF8B33),
      accentColor: Color(0xFFF2F5F7));
  final ThemeData _darkTheme = ThemeData.dark().copyWith(
      backgroundColor: Color(0xFF303030),
      primaryColor: Color(0xFF808080),
      accentColor: Color(0xFF505050));
  return Builder(builder: (BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final ThemeData _theme = mediaQuery.platformBrightness == Brightness.light
        ? _lightTheme
        : _darkTheme;
    String _getTime(int time) {
      var date = DateTime.fromMillisecondsSinceEpoch(time);

      return DateFormat(DateFormat.HOUR_MINUTE)
          .format(date)
          .split(' ')[0]
          .toString();
    }

    bool _isPm(int time) {
      var date = DateTime.fromMillisecondsSinceEpoch(time);
      return date.hour > 12;
    }

    Widget _buildHeader() {
      var _currentlyTime = (state.weather?.currently?.time ?? 0) * 1000;
      return Row(
        key: ValueKey('header'),
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          SizedBox(
            width: Adapt.px(260),
            height: Adapt.px(360),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  DateFormat.EEEE().format(DateTime.now()),
                  style: TextStyle(
                      fontSize: Adapt.px(35), color: Colors.grey[400]),
                ),
                Text(
                  '${state.weather?.currently != null ? WeatherTypeHelper.getWeatherType(state.weather.currently.icon) : '-'}',
                  style: TextStyle(
                      fontSize: Adapt.px(35), color: Colors.grey[400]),
                ),
                SizedBox(height: Adapt.px(20)),
                WeatherIcon(
                  icon: state.weather?.currently?.icon ?? 'clear-day',
                  size: Adapt.px(90),
                ),
                RichText(
                  text: TextSpan(
                      style: TextStyle(
                        color: _theme.textTheme.body1.color,
                        letterSpacing: Adapt.px(10),
                        fontSize: Adapt.px(140),
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text:
                              '${state.weather?.currently?.temperature?.floor() ?? '-'}',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        TextSpan(
                          text: '°',
                          style: TextStyle(fontWeight: FontWeight.w300),
                        )
                      ]),
                ),
              ],
            ),
          ),
          SizedBox(
            width: Adapt.px(20),
          ),
          Container(
            width: Adapt.px(100),
            height: Adapt.px(340),
            margin: EdgeInsets.only(bottom: Adapt.px(20)),
            alignment: Alignment.bottomCenter,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Adapt.px(50)),
              color: _theme.accentColor,
            ),
            child: Container(
              height: Adapt.px(120),
              width: Adapt.px(100),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: _theme.primaryColor,
                borderRadius: BorderRadius.circular(Adapt.px(50)),
              ),
              child: Text(
                '${state.weather?.currently?.apparentTemperature?.floor() ?? '-'}°',
                style:
                    TextStyle(color: Color(0xFFF2F5F7), fontSize: Adapt.px(30)),
              ),
            ),
          ),
          Expanded(
            child: SizedBox(),
          ),
          Container(
            margin: EdgeInsets.only(bottom: Adapt.px(20)),
            height: Adapt.px(340),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  _getTime(_currentlyTime),
                  style: TextStyle(fontSize: Adapt.px(24)),
                ),
                Text(
                  _isPm(_currentlyTime) ? 'pm' : 'am',
                  style: TextStyle(
                      fontSize: Adapt.px(35), fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: Adapt.px(30),
                ),
                Container(
                  width: Adapt.px(50),
                  height: Adapt.px(5),
                  color: _theme.accentColor,
                ),
                SizedBox(
                  height: Adapt.px(30),
                ),
                Text(
                  DateFormat.E().format(
                      DateTime.fromMillisecondsSinceEpoch(_currentlyTime)),
                  style: TextStyle(fontSize: Adapt.px(24)),
                ),
                Text(
                  DateFormat.d().format(
                      DateTime.fromMillisecondsSinceEpoch(_currentlyTime)),
                  style: TextStyle(
                      fontSize: Adapt.px(35), fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ],
      );
    }

    Widget _buildGridCell(Widget icon, String title, String value) {
      return Container(
        key: ValueKey('GridCell$value'),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Adapt.px(30)),
            border: Border.all(color: Colors.grey[400])),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            icon,
            SizedBox(height: Adapt.px(15)),
            Text(
              title,
              style: TextStyle(fontSize: Adapt.px(30)),
            ),
            SizedBox(height: Adapt.px(15)),
            Text(
              value,
              style: TextStyle(fontSize: Adapt.px(28), color: Colors.grey),
            ),
          ],
        ),
      );
    }

    Widget _buildWeekdayShimmerCell() {
      return Container(
        key: ValueKey('GridCell${DateTime.now().millisecondsSinceEpoch}'),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Adapt.px(30)),
            border: Border.all(color: Colors.grey[400])),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            WeatherIcon(icon: 'clear-day'),
            SizedBox(height: Adapt.px(15)),
            Text(
              '-~-',
              style: TextStyle(fontSize: Adapt.px(30)),
            ),
            SizedBox(height: Adapt.px(15)),
            Text(
              '-',
              style: TextStyle(fontSize: Adapt.px(28), color: Colors.grey),
            ),
          ],
        ),
      );
    }

    Widget _buildGridView() {
      var _currently = state?.weather?.currently;
      var _daily = state.weather?.daily?.data;
      return GridView.count(
        //key: ValueKey('Grid'),
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 3,
        mainAxisSpacing: Adapt.px(80),
        childAspectRatio: 1 / 1.3,
        crossAxisSpacing: Adapt.px(30),
        shrinkWrap: true,
        children: <Widget>[
          _buildGridCell(Icon(FontAwesomeIcons.wind, color: Colors.blue[400]),
              'Wind', '${_currently?.windSpeed ?? '-'} Km/h'),
          _buildGridCell(
              Icon(FontAwesome5.getIconData('tint', weight: IconWeight.Solid),
                  color: Colors.purple[900]),
              'Humidity',
              '${((_currently?.humidity ?? 0) * 100).floor()}%'),
          _buildGridCell(
              Icon(FontAwesomeIcons.tachometerAlt, color: Colors.redAccent),
              'Pressure',
              '${_currently?.pressure?.floor() ?? '-'} hPa'),
          _daily != null
              ? _buildGridCell(
                  WeatherIcon(icon: _daily[0].icon),
                  '${_daily[0].temperatureLow.floor()}°~${_daily[0].temperatureHigh.floor()}°',
                  Weekday.getWeekdayString(_daily[0].time))
              : _buildWeekdayShimmerCell(),
          _daily != null
              ? _buildGridCell(
                  WeatherIcon(icon: _daily[1].icon),
                  '${_daily[1].temperatureLow.floor()}°~${_daily[1].temperatureHigh.floor()}°',
                  Weekday.getWeekdayString(_daily[1].time))
              : _buildWeekdayShimmerCell(),
          _daily != null
              ? _buildGridCell(
                  WeatherIcon(icon: _daily[2].icon),
                  '${_daily[2].temperatureLow.floor()}°~${_daily[2].temperatureHigh.floor()}°',
                  Weekday.getWeekdayString(_daily[2].time))
              : _buildWeekdayShimmerCell(),
        ],
      );
    }

    Widget _buildNextButton() {
      return InkWell(
        key: ValueKey('NextButton'),
        onTap: () => dispatch(HomePageActionCreator.futureWeatherCilcked()),
        child: Container(
          width: Adapt.px(100),
          height: Adapt.px(100),
          decoration: BoxDecoration(
              color: _theme.primaryColor,
              shape: BoxShape.circle,
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: _theme.primaryColor.withAlpha(100),
                    offset: Offset(0, Adapt.px(10)),
                    blurRadius: Adapt.px(40),
                    spreadRadius: Adapt.px(1))
              ]),
          child: Icon(
            Icons.keyboard_arrow_up,
            size: Adapt.px(60),
            color: Colors.white,
          ),
        ),
      );
    }

    return Scaffold(
        key: ValueKey("theme2"),
        appBar: AppBar(
          brightness: Brightness.light,
          automaticallyImplyLeading: false,
          backgroundColor: _theme.accentColor,
          centerTitle: false,
          elevation: 0.0,
          title: Row(
            children: <Widget>[
              SizedBox(
                width: Adapt.px(40),
              ),
              Icon(
                Icons.search,
                color: _theme.iconTheme.color,
              ),
              SizedBox(
                width: Adapt.px(20),
              ),
              Text(
                '${state.city}, ${state.country}',
                style: TextStyle(
                    fontSize: Adapt.px(30),
                    color: _theme.textTheme.body1.color),
              )
            ],
          ),
          actions: <Widget>[
            PopupMenuButton<String>(
                padding: EdgeInsets.zero,
                offset: Offset(0, Adapt.px(100)),
                icon: Icon(
                  Icons.menu,
                  color: _theme.iconTheme.color,
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
            SizedBox(
              width: Adapt.px(30),
            )
          ],
        ),
        body: Container(
            width: Adapt.screenW(),
            height: Adapt.screenH(),
            color: _theme.accentColor,
            child: Container(
              margin: EdgeInsets.only(top: Adapt.px(40)),
              padding: EdgeInsets.symmetric(horizontal: Adapt.px(60)),
              decoration: BoxDecoration(
                  color: _theme.backgroundColor,
                  borderRadius: BorderRadius.vertical(
                      top: Radius.circular(Adapt.px(80)))),
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: <Widget>[
                  SizedBox(
                    height: Adapt.px(80),
                  ),
                  _buildHeader(),
                  SizedBox(
                    height: Adapt.px(80),
                  ),
                  _buildGridView(),
                  SizedBox(
                    height: Adapt.px(80),
                  ),
                  _buildNextButton(),
                ],
              ),
            )));
  });
}
