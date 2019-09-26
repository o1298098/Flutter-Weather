import 'dart:convert' show json;

class YahooWeatherModel {
  List<Forecast> forecasts;
  CurrentObservation currentObservation;
  Location location;

  YahooWeatherModel.fromParams(
      {this.forecasts, this.currentObservation, this.location});

  factory YahooWeatherModel(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String
          ? new YahooWeatherModel.fromJson(json.decode(jsonStr))
          : new YahooWeatherModel.fromJson(jsonStr);

  YahooWeatherModel.fromJson(jsonRes) {
    forecasts = jsonRes['forecasts'] == null ? null : [];

    for (var forecastsItem in forecasts == null ? [] : jsonRes['forecasts']) {
      forecasts.add(
          forecastsItem == null ? null : new Forecast.fromJson(forecastsItem));
    }

    currentObservation = jsonRes['current_observation'] == null
        ? null
        : new CurrentObservation.fromJson(jsonRes['current_observation']);
    location = jsonRes['location'] == null
        ? null
        : new Location.fromJson(jsonRes['location']);
  }

  @override
  String toString() {
    return '{"forecasts": $forecasts,"current_observation": $currentObservation,"location": $location}';
  }
}

class Location {
  int woeid;
  double lat;
  double long;
  String city;
  String country;
  String region;
  String timezoneId;

  Location.fromParams(
      {this.woeid,
      this.lat,
      this.long,
      this.city,
      this.country,
      this.region,
      this.timezoneId});

  Location.fromJson(jsonRes) {
    woeid = jsonRes['woeid'];
    lat = jsonRes['lat'];
    long = jsonRes['long'];
    city = jsonRes['city'];
    country = jsonRes['country'];
    region = jsonRes['region'];
    timezoneId = jsonRes['timezone_id'];
  }

  @override
  String toString() {
    return '{"woeid": $woeid,"lat": $lat,"long": $long,"city": ${city != null ? '${json.encode(city)}' : 'null'},"country": ${country != null ? '${json.encode(country)}' : 'null'},"region": ${region != null ? '${json.encode(region)}' : 'null'},"timezone_id": ${timezoneId != null ? '${json.encode(timezoneId)}' : 'null'}}';
  }
}

class CurrentObservation {
  int pubDate;
  Astronomy astronomy;
  Atmosphere atmosphere;
  Condition condition;
  Wind wind;

  CurrentObservation.fromParams(
      {this.pubDate,
      this.astronomy,
      this.atmosphere,
      this.condition,
      this.wind});

  CurrentObservation.fromJson(jsonRes) {
    pubDate = jsonRes['pubDate'];
    astronomy = jsonRes['astronomy'] == null
        ? null
        : new Astronomy.fromJson(jsonRes['astronomy']);
    atmosphere = jsonRes['atmosphere'] == null
        ? null
        : new Atmosphere.fromJson(jsonRes['atmosphere']);
    condition = jsonRes['condition'] == null
        ? null
        : new Condition.fromJson(jsonRes['condition']);
    wind = jsonRes['wind'] == null ? null : new Wind.fromJson(jsonRes['wind']);
  }

  @override
  String toString() {
    return '{"pubDate": $pubDate,"astronomy": $astronomy,"atmosphere": $atmosphere,"condition": $condition,"wind": $wind}';
  }
}

class Wind {
  int chill;
  int direction;
  double speed;

  Wind.fromParams({this.chill, this.direction, this.speed});

  Wind.fromJson(jsonRes) {
    chill = jsonRes['chill'];
    direction = jsonRes['direction'];
    speed = jsonRes['speed'];
  }

  @override
  String toString() {
    return '{"chill": $chill,"direction": $direction,"speed": $speed}';
  }
}

class Condition {
  int code;
  int temperature;
  String text;

  Condition.fromParams({this.code, this.temperature, this.text});

  Condition.fromJson(jsonRes) {
    code = jsonRes['code'];
    temperature = jsonRes['temperature'];
    text = jsonRes['text'];
  }

  @override
  String toString() {
    return '{"code": $code,"temperature": $temperature,"text": ${text != null ? '${json.encode(text)}' : 'null'}}';
  }
}

class Atmosphere {
  int humidity;
  int rising;
  double pressure;
  double visibility;

  Atmosphere.fromParams(
      {this.humidity, this.rising, this.pressure, this.visibility});

  Atmosphere.fromJson(jsonRes) {
    humidity = jsonRes['humidity'];
    rising = jsonRes['rising'];
    pressure = jsonRes['pressure'];
    visibility = jsonRes['visibility'];
  }

  @override
  String toString() {
    return '{"humidity": $humidity,"rising": $rising,"pressure": $pressure,"visibility": $visibility}';
  }
}

class Astronomy {
  String sunrise;
  String sunset;

  Astronomy.fromParams({this.sunrise, this.sunset});

  Astronomy.fromJson(jsonRes) {
    sunrise = jsonRes['sunrise'];
    sunset = jsonRes['sunset'];
  }

  @override
  String toString() {
    return '{"sunrise": ${sunrise != null ? '${json.encode(sunrise)}' : 'null'},"sunset": ${sunset != null ? '${json.encode(sunset)}' : 'null'}}';
  }
}

class Forecast {
  int code;
  int date;
  int high;
  int low;
  String day;
  String text;

  Forecast.fromParams(
      {this.code, this.date, this.high, this.low, this.day, this.text});

  Forecast.fromJson(jsonRes) {
    code = jsonRes['code'];
    date = jsonRes['date'];
    high = jsonRes['high'];
    low = jsonRes['low'];
    day = jsonRes['day'];
    text = jsonRes['text'];
  }

  @override
  String toString() {
    return '{"code": $code,"date": $date,"high": $high,"low": $low,"day": ${day != null ? '${json.encode(day)}' : 'null'},"text": ${text != null ? '${json.encode(text)}' : 'null'}}';
  }
}
