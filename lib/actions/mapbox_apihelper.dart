import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';

import 'dart:convert' show json;
import 'dart:ui' as ui;

import 'package:weather/models/mapbox_model.dart';

class MapBoxApi {
  static const String _host = 'https://api.mapbox.com';
  static const String _apikey =
      'pk.eyJ1IjoibzEyOTgwOTgiLCJhIjoiY2pnb3NmZXBkMHJrbTJycXZmb2hzYmRuNyJ9.tRoyRjsXFkyKInX9NQpeqQ';
  static String _language = ui.window.locale.languageCode;

  static Future<MapBoxModel> reverseGeocoding(double lan, double lon) async {
    MapBoxModel model;
    String param =
        '/geocoding/v5/mapbox.places/$lon,$lan.json?types=country,place&access_token=$_apikey';
    var r = await _httpGet(param);
    if (r != null) model = MapBoxModel(r);
    return model;
  }

  static Future<Object> _httpGet(String param,
      {bool cached = true,
      cacheDuration = const Duration(days: 10),
      maxStale = const Duration(days: 30)}) async {
    try {
      var dio = new Dio();
      if (cached)
        dio.interceptors.add(DioCacheManager(CacheConfig()).interceptor);
      var response = await dio.get(
        '$_host$param',
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
}
