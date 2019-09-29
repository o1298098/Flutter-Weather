import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';

import 'dart:convert' show json;
import 'dart:ui' as ui;

import 'package:weather/models/darksky_weather_model.dart';

class ApiHelper {
  static const String _host = 'https://api.darksky.net/forecast/';
  static const String _appkey = 'bebf569a9bfaa6d6876967c647cc196e';
  static String _language = ui.window.locale.languageCode;

  static Future<WeatherModel> getWeather(double lan, double lon,
      {String language, String exclude, String extend}) async {
    WeatherModel model;
    String param = '/$lan,$lon?lang=$_language&units=auto';
    var r = await _httpGet(param);
    if (r != null) model = WeatherModel(r);
    return model;
  }

  static Future<Object> _httpGet(String param,
      {bool cached = true,
      cacheDuration = const Duration(hours: 1),
      maxStale = const Duration(days: 30)}) async {
    try {
      var dio = new Dio();
      if (cached)
        dio.interceptors.add(DioCacheManager(CacheConfig()).interceptor);
      var response = await dio.get(
        '$_host$_appkey$param',
        options: buildCacheOptions(
          cacheDuration,
          maxStale: maxStale,
        ),
      );
      return response.data;
    } on DioError catch (e) {
      return null;
    }
  }

  static Future<Object> _httpPost(String params, dynamic formData) async {
    try {
      var dio = new Dio();
      dio.options.headers = {
        'ContentType': 'application/json;charset=utf-8',
      };
      var response = await dio.post(params, data: formData);
      return response.data;
    } on DioError catch (e) {
      return null;
    }
  }
}
