import 'package:dio/dio.dart';
import 'dart:convert' show ascii, base64Encode, json;
import 'package:crypto/crypto.dart';
import 'package:weather/models/yahoo_weather_model.dart';

//import 'package:dio_http_cache/dio_http_cache.dart';

class ApiHelper {
  static const String cURL =
      "https://weather-ydn-yql.media.yahoo.com/forecastrss";
  static const String _cAppID = "ku5fPY36";
  static const String _cConsumerKey =
      "dj0yJmk9eHR4OUloYVM4YXZNJmQ9WVdrOWEzVTFabEJaTXpZbWNHbzlNQS0tJnM9Y29uc3VtZXJzZWNyZXQmc3Y9MCZ4PTY4";
  static const String _cConsumerSecret =
      "1054d05a2e51083ca6cbb2ca7c260acd1ea2b70b";
  static const String _cOAuthVersion = "1.0";
  static const String _cOAuthSignMethod = "HMAC-SHA1";
  static const String _cUnitID = "u=c";
  static const String _cFormat = "json";

  static Future<YahooWeatherModel> getWeatherByLatAndLon(
      double latitude, double longitude) async {
    YahooWeatherModel model;
    String param = 'lat=$latitude&lon=$longitude';
    var r = await _httpGet(param);
    if (r != null) model = YahooWeatherModel(r);
    return model;
  }

  static Future<YahooWeatherModel> getWeatherByWoeid(int woeid) async {
    YahooWeatherModel model;
    String param = 'woeid=$woeid';
    var r = await _httpGet(param);
    if (r != null) model = YahooWeatherModel(r);
    return model;
  }

  static String _getAuth(String params) {
    var _lNonce = base64Encode(
        ascii.encode(DateTime.now().millisecondsSinceEpoch.toString()));
    var _lTimes = (DateTime.now().millisecondsSinceEpoch / 1000).floor();
    var _lCKey = '$_cConsumerSecret&';
    List<String> paramArray = [
      'format=$_cFormat',
      'oauth_consumer_key=$_cConsumerKey',
      'oauth_nonce=$_lNonce',
      'oauth_signature_method=$_cOAuthSignMethod',
      'oauth_timestamp=$_lTimes',
      'oauth_version=$_cOAuthVersion',
      _cUnitID,
      params,
    ];
    paramArray.sort();
    var _lSign = paramArray.join('&');
    //'format=$_cFormat&oauth_consumer_key=$_cConsumerKey&oauth_nonce=$_lNonce&oauth_signature_method=$_cOAuthSignMethod&oauth_timestamp=$_lTimes&oauth_version=$_cOAuthVersion&$_cUnitID&$params';

    _lSign = 'GET&${Uri.encodeComponent(cURL)}&${Uri.encodeComponent(_lSign)}';
    var _input = Hmac(sha1, ascii.encode(_lCKey));
    var _digest = _input.convert(ascii.encode(_lSign));
    _lSign = base64Encode(_digest.bytes);

    return 'OAuth oauth_consumer_key="$_cConsumerKey",oauth_nonce="$_lNonce", oauth_timestamp="$_lTimes", oauth_signature_method="$_cOAuthSignMethod",oauth_signature="$_lSign", oauth_version="$_cOAuthVersion"';
  }

  static Future<Object> _httpGet(String param,
      {bool cached = true,
      cacheDuration = const Duration(hours: 0),
      maxStale = const Duration(days: 30)}) async {
    try {
      String lURL = cURL + '?' + param + "&" + _cUnitID + "&format=" + _cFormat;
      var dio = new Dio();
      /*if (cached)
        dio.interceptors.add(DioCacheManager(CacheConfig()).interceptor);*/
      dio.options.headers.addAll({
        "Content-Type": "application/" + _cFormat,
        "X-Yahoo-App-Id": _cAppID,
        "Authorization": _getAuth(param)
      });
      print(dio.options.headers.toString());
      var response = await dio.get(
        lURL,
        /* options: buildCacheOptions(
          cacheDuration,
          maxStale: maxStale,
        ),*/
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
