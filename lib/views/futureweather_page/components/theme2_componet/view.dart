import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/actions/adapt.dart';
import 'package:weather/models/darksky_weather_model.dart';
import 'package:weather/widgets/weather_icon.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    Theme2State state, Dispatch dispatch, ViewService viewService) {
  final ThemeData _lightTheme = ThemeData.light().copyWith(
      backgroundColor: Colors.white,
      textSelectionColor: Colors.white,
      dividerColor: Colors.orange[200],
      primaryColor: Color(0xFFFF8B33),
      accentColor: Color(0xFFF2F5F7));
  final ThemeData _darkTheme = ThemeData.dark().copyWith(
      backgroundColor: Color(0xFF303030),
      textSelectionColor: Colors.white,
      dividerColor: Color(0xFF606060),
      primaryColor: Color(0xFF303030),
      accentColor: Color(0xFF505050));
  return Builder(builder: (BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final ThemeData _theme = mediaQuery.platformBrightness == Brightness.light
        ? _lightTheme
        : _darkTheme;
    Widget _buildTabCell(
      String title,
      int index,
    ) {
      return InkWell(
        onTap: () => state.tabController.animateTo(index / 3),
        child: SizedBox(
          width: Adapt.screenW() / 4,
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: _theme.textSelectionColor,
                fontSize: Adapt.px(30),
              ),
            ),
          ),
        ),
      );
    }

    Widget _buildTabController() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _buildTabCell('Temp', 0),
              _buildTabCell('Feel-like', 1),
              _buildTabCell('Precip', 2),
              _buildTabCell('Wind', 3),
            ],
          ),
          SizedBox(height: Adapt.px(10)),
          SlideTransition(
            position: Tween(begin: Offset.zero, end: Offset(3, 0))
                .animate(state.tabController),
            child: SizedBox(
              width: Adapt.screenW() / 4,
              child: Center(
                child: Container(
                  width: Adapt.px(10),
                  height: Adapt.px(10),
                  decoration: BoxDecoration(
                      color: _theme.textSelectionColor, shape: BoxShape.circle),
                ),
              ),
            ),
          )
        ],
      );
    }

    Widget _buildTableCell(DailyData d) {
      final int _index = state.daily.data.indexOf(d);
      final int _length = state.daily.data.length;
      final double _beginv = _index / _length * 0.5 + 0.05;
      final double _endv = (_index + 1) / _length * 0.5 + 0.2;
      final double _width = Adapt.screenW() / 4;
      final TextStyle _textStyle =
          TextStyle(color: _theme.textSelectionColor, fontSize: Adapt.px(35));
      final Animation<Offset> _slide =
          Tween(begin: Offset(0, 1), end: Offset.zero).animate(CurvedAnimation(
              parent: state.animationController,
              curve: Interval(_beginv, _endv, curve: Curves.ease)));
      final Animation<double> _op = Tween(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
              parent: state.animationController,
              curve: Interval(_beginv, _endv, curve: Curves.ease)));
      return SlideTransition(
          position: _slide,
          child: FadeTransition(
            opacity: _op,
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: _width,
                      padding: EdgeInsets.only(left: Adapt.px(60)),
                      child: Text(
                        DateFormat.E().format(
                            DateTime.fromMillisecondsSinceEpoch(d.time * 1000)),
                        style: _textStyle,
                      ),
                    ),
                    SizedBox(
                        width: _width,
                        child: Center(
                          child: WeatherIcon(
                            icon: d.icon,
                            color: _theme.textSelectionColor,
                          ),
                        )),
                    SizedBox(
                        width: _width,
                        child: Center(
                          child: Text(
                            '${d.temperatureLow.toStringAsFixed(0)}°',
                            style: _textStyle,
                          ),
                        )),
                    SizedBox(
                        width: _width,
                        child: Center(
                          child: Text(
                            '${d.temperatureHigh.toStringAsFixed(0)}°',
                            style: _textStyle,
                          ),
                        )),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Adapt.px(60)),
                  child: Divider(
                    color: _theme.dividerColor,
                    height: Adapt.px(60),
                  ),
                )
              ],
            ),
          ));
    }

    Widget _buildTable() {
      return Column(
        children: state.daily.data.getRange(1, 8).map(_buildTableCell).toList(),
      );
    }

    Widget _buildBackButton() {
      return ScaleTransition(
        scale: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: state.animationController,
            curve: Interval(0.7, 0.85, curve: Curves.ease))),
        child: InkWell(
          onTap: () => dispatch(Theme2ActionCreator.goBack()),
          child: Container(
            width: Adapt.px(100),
            height: Adapt.px(100),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.black.withAlpha(50),
                      offset: Offset(0, Adapt.px(10)),
                      blurRadius: Adapt.px(40),
                      spreadRadius: Adapt.px(1))
                ]),
            child: Icon(
              Icons.keyboard_arrow_down,
              size: Adapt.px(50),
              color: _theme.primaryColor,
            ),
          ),
        ),
      );
    }

    return Scaffold(
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
                    color: _theme.textTheme.body1.color,
                    fontSize: Adapt.px(30)),
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
                onSelected: (selected) {},
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
          child: SlideTransition(
            position: Tween<Offset>(begin: Offset(0, 1), end: Offset.zero)
                .animate(CurvedAnimation(
                    parent: state.animationController,
                    curve: Interval(0, 0.2, curve: Curves.ease))),
            child: Container(
              margin: EdgeInsets.only(top: Adapt.px(40)),
              //padding: EdgeInsets.symmetric(horizontal: Adapt.px(60)),
              decoration: BoxDecoration(
                  color: _theme.primaryColor,
                  borderRadius: BorderRadius.vertical(
                      top: Radius.circular(Adapt.px(80)))),
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: <Widget>[
                  SizedBox(height: Adapt.px(80)),
                  Padding(
                    padding: EdgeInsets.only(left: Adapt.px(60)),
                    child: Text(
                      'Next 7 Days',
                      style: TextStyle(
                          color: _theme.textSelectionColor,
                          fontSize: Adapt.px(50),
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(
                    height: Adapt.px(60),
                  ),
                  _buildTabController(),
                  SizedBox(
                    height: Adapt.px(80),
                  ),
                  _buildTable(),
                  SizedBox(
                    height: Adapt.px(50),
                  ),
                  _buildBackButton()
                ],
              ),
            ),
          ),
        ));
  });
}
