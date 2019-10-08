import 'package:fish_redux/fish_redux.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:weather/actions/adapt.dart';
import 'package:weather/models/darksky_weather_model.dart';
import 'package:weather/views/home_page/action.dart';
import 'package:weather/widgets/custom_panel.dart';
import 'package:weather/widgets/hourly_cell.dart';
import 'package:weather/widgets/weather_icon.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    Theme3State state, Dispatch dispatch, ViewService viewService) {
  final ThemeData _lightTheme = ThemeData.light().copyWith(
      backgroundColor: Color(0xFFF4F4F4),
      primaryColor: Colors.white,
      cardColor: Color(0xFF778899));
  final ThemeData _darkTheme = ThemeData.dark();
  return Builder(builder: (BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final ThemeData _theme = mediaQuery.platformBrightness == Brightness.light
        ? _lightTheme
        : _darkTheme;

    Widget _buildBackGround() {
      double headerHeight = (Adapt.px(350)).floorToDouble();
      return Column(
        children: <Widget>[
          SizedBox(
            height: headerHeight,
          ),
          ClipPath(
              clipper: CustomPanelCliper(
                headerHeight: headerHeight,
              ),
              child: Container(
                height: headerHeight,
                color: _theme.primaryColor,
              )),
          Expanded(
            child: Container(
              color: _theme.primaryColor,
            ),
          )
        ],
      );
    }

    Widget _buildHeaderInfo() {
      return Column(
        children: <Widget>[
          WeatherIcon(
            icon: state.weather?.currently?.icon ?? 'clear-day',
            size: Adapt.px(80),
          ),
          SizedBox(
            height: Adapt.px(20),
          ),
          RichText(
            text: TextSpan(
                style: TextStyle(
                  color: _theme.textTheme.body1.color,
                  fontSize: Adapt.px(80),
                ),
                children: <TextSpan>[
                  TextSpan(
                    text:
                        '${state.weather?.currently?.temperature?.toStringAsFixed(1) ?? '-'}',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  TextSpan(
                    text: '°',
                    style: TextStyle(fontWeight: FontWeight.w300),
                  )
                ]),
          ),
          SizedBox(
            height: Adapt.px(10),
          ),
          Text(
            '${state.city}, ${state.country}',
            style: TextStyle(fontSize: Adapt.px(28)),
          ),
        ],
      );
    }

    Widget _buildTabController() {
      final TextStyle _selectTextStyle = TextStyle(fontWeight: FontWeight.w500);
      final TextStyle _unSelectTextStyle = TextStyle(color: Colors.grey);
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Today',
            style: _selectTextStyle,
          ),
          SizedBox(
            width: Adapt.px(50),
          ),
          Text(
            'Tomorrow',
            style: _unSelectTextStyle,
          ),
          SizedBox(
            width: Adapt.px(50),
          ),
          Text('After', style: _unSelectTextStyle)
        ],
      );
    }

    Widget _buildHourlyCell(
        HourlyCellType type, Color topColor, Color bottomColor, HourlyData d) {
      final double _height = Adapt.px(350);
      final double _width = (Adapt.screenW() - 70 - Adapt.px(40)) / 3;
      return HourlyCell(
        width: _width,
        height: _height,
        topColor: topColor,
        bottomColor: bottomColor,
        hourlyCellType: type,
        child: Container(
          padding: EdgeInsets.all(Adapt.px(50)),
          width: _width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                DateFormat(DateFormat.HOUR24_MINUTE)
                    .format(DateTime.fromMillisecondsSinceEpoch(d.time * 1000)),
                style: TextStyle(color: Colors.white, fontSize: Adapt.px(28)),
              ),
              SizedBox(height: Adapt.px(55)),
              WeatherIcon(
                icon: d.icon,
                color: Colors.white,
                size: Adapt.px(80),
              ),
              SizedBox(height: Adapt.px(50)),
              Text('${d.temperature.floor()}°',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: Adapt.px(30),
                      fontWeight: FontWeight.w600))
            ],
          ),
        ),
      );
    }

    Widget _buildHourlyGroup() {
      var _hourly = state.weather?.hourly;
      var _emtrydata = HourlyData.fromParams(
          icon: 'clear-day', time: 1570478400, temperature: 0);
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _buildHourlyCell(
              HourlyCellType.left,
              Color(0xFFF57F4C),
              Color(0xFFDF646D),
              _hourly != null ? state.weather.hourly.data[0] : _emtrydata),
          SizedBox(
            width: Adapt.px(20),
          ),
          _buildHourlyCell(
              HourlyCellType.middle,
              Color(0xFFAC5887),
              Color(0xFF806C91),
              _hourly != null ? state.weather.hourly.data[1] : _emtrydata),
          SizedBox(
            width: Adapt.px(20),
          ),
          _buildHourlyCell(
              HourlyCellType.right,
              Color(0xFF404D70),
              Color(0xFF293F50),
              _hourly != null ? state.weather.hourly.data[2] : _emtrydata),
        ],
      );
    }

    Widget _buildAdditionalInfo() {
      final TextStyle _titleStyle =
          TextStyle(fontWeight: FontWeight.bold, fontSize: Adapt.px(28));
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 35),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Additional Info',
              style: TextStyle(
                  fontSize: Adapt.px(35), fontWeight: FontWeight.bold),
            ),
            SizedBox(height: Adapt.px(40)),
            Row(
              children: <Widget>[
                SizedBox(
                  width: Adapt.px(150),
                  child: Text('Wind', style: _titleStyle),
                ),
                SizedBox(
                  width: Adapt.px(120),
                  child:
                      Text('${state.weather?.currently?.windSpeed ?? 0} km/h'),
                ),
                SizedBox(
                  width: Adapt.px(60),
                ),
                SizedBox(
                  width: Adapt.px(150),
                  child: Text('Humidity', style: _titleStyle),
                ),
                SizedBox(
                  width: Adapt.px(120),
                  child: Text(
                      '${((state.weather?.currently?.humidity ?? 0) * 100).floor()} %'),
                )
              ],
            ),
            SizedBox(
              height: Adapt.px(30),
            ),
            Row(
              children: <Widget>[
                SizedBox(
                  width: Adapt.px(150),
                  child: Text('Visibility', style: _titleStyle),
                ),
                SizedBox(
                  width: Adapt.px(120),
                  child: Text('${state.weather?.currently?.visibility} km'),
                ),
                SizedBox(
                  width: Adapt.px(60),
                ),
                SizedBox(
                  width: Adapt.px(150),
                  child: Text(
                    'UV',
                    style: _titleStyle,
                  ),
                ),
                SizedBox(
                  width: Adapt.px(120),
                  child: Text('${state.weather?.currently?.uvIndex}'),
                )
              ],
            ),
            SizedBox(height: Adapt.px(50)),
            state.weather?.hourly == null
                ? SizedBox(height: Adapt.px(300))
                : SizedBox(
                    height: Adapt.px(300),
                    child: SfCartesianChart(
                        plotAreaBorderWidth: 0.0,
                        primaryXAxis: NumericAxis(
                            isVisible: true,
                            placeLabelsNearAxisLine: false,
                            majorGridLines: MajorGridLines(width: 0.0),
                            axisLine: AxisLine(width: 0.0)),
                        primaryYAxis: NumericAxis(isVisible: false),
                        borderWidth: 0,
                        borderColor: Colors.transparent,
                        series: <ChartSeries>[
                          SplineSeries<HourlyData, double>(
                              color: _theme.cardColor,
                              dataLabelSettings: DataLabelSettings(
                                  isVisible: true,
                                  position: CartesianLabelPosition.bottom),
                              dataSource: state.weather?.hourly?.data
                                      ?.take(6)
                                      ?.toList() ??
                                  [],
                              xValueMapper: (HourlyData sales, _) =>
                                  DateTime.fromMillisecondsSinceEpoch(
                                          sales.time * 1000)
                                      .hour
                                      .toDouble(),
                              yValueMapper: (HourlyData sales, _) =>
                                  sales.temperature.floorToDouble(),
                              markerSettings: MarkerSettings(
                                  isVisible: true, borderWidth: 5)),
                        ])),
          ],
        ),
      );
    }

    Widget _buildBottomMenu() {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: Adapt.px(60)),
        child: Row(
          children: <Widget>[
            Icon(Feather.getIconData('home')),
            SizedBox(width: Adapt.px(10)),
            Text('Home', style: TextStyle(fontSize: Adapt.px(28))),
            Expanded(child: Container()),
            Icon(Feather.getIconData('sun')),
            SizedBox(width: Adapt.px(30)),
            Icon(Feather.getIconData('settings'))
          ],
        ),
      );
    }

    return Scaffold(
      key: ValueKey('theme3'),
      backgroundColor: _theme.backgroundColor,
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            color: _theme.iconTheme.color,
          ),
          onPressed: () => dispatch(HomePageActionCreator.themeChanged()),
        ),
        title: Text('Weather Forecast',
            style: TextStyle(color: _theme.textTheme.body1.color)),
      ),
      body: Stack(
        fit: StackFit.loose,
        children: <Widget>[
          _buildBackGround(),
          Container(
            width: Adapt.screenW(),
            child: ListView(
              children: <Widget>[
                _buildHeaderInfo(),
                SizedBox(height: Adapt.px(50)),
                _buildTabController(),
                SizedBox(height: Adapt.px(30)),
                _buildHourlyGroup(),
                SizedBox(height: Adapt.px(50)),
                _buildAdditionalInfo(),
                SizedBox(height: Adapt.px(50)),
                _buildBottomMenu()
              ],
            ),
          ),
        ],
      ),
    );
  });
}
