import 'dart:convert' show json;

class WeatherModel {
  int offset;
  double latitude;
  double longitude;
  String timezone;
  Currently currently;
  Daily daily;
  Flags flags;
  Hourly hourly;
  Minutely minutely;

  WeatherModel.fromParams(
      {this.offset,
      this.latitude,
      this.longitude,
      this.timezone,
      this.currently,
      this.daily,
      this.flags,
      this.hourly,
      this.minutely});

  factory WeatherModel(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String
          ? new WeatherModel.fromJson(json.decode(jsonStr))
          : new WeatherModel.fromJson(jsonStr);

  WeatherModel.fromJson(jsonRes) {
    offset = jsonRes['offset'];
    latitude = jsonRes['latitude'];
    longitude = jsonRes['longitude'];
    timezone = jsonRes['timezone'];
    currently = jsonRes['currently'] == null
        ? null
        : new Currently.fromJson(jsonRes['currently']);
    daily =
        jsonRes['daily'] == null ? null : new Daily.fromJson(jsonRes['daily']);
    flags =
        jsonRes['flags'] == null ? null : new Flags.fromJson(jsonRes['flags']);
    hourly = jsonRes['hourly'] == null
        ? null
        : new Hourly.fromJson(jsonRes['hourly']);
    minutely = jsonRes['minutely'] == null
        ? null
        : new Minutely.fromJson(jsonRes['minutely']);
  }

  @override
  String toString() {
    return '{"offset": $offset,"latitude": $latitude,"longitude": $longitude,"timezone": ${timezone != null ? '${json.encode(timezone)}' : 'null'},"currently": $currently,"daily": $daily,"flags": $flags,"hourly": $hourly,"minutely": $minutely}';
  }
}

class Minutely {
  String icon;
  String summary;
  List<MinutelyData> data;

  Minutely.fromParams({this.icon, this.summary, this.data});

  Minutely.fromJson(jsonRes) {
    icon = jsonRes['icon'];
    summary = jsonRes['summary'];
    data = jsonRes['data'] == null ? null : [];

    for (var dataItem in data == null ? [] : jsonRes['data']) {
      data.add(dataItem == null ? null : new MinutelyData.fromJson(dataItem));
    }
  }

  @override
  String toString() {
    return '{"icon": ${icon != null ? '${json.encode(icon)}' : 'null'},"summary": ${summary != null ? '${json.encode(summary)}' : 'null'},"data": $data}';
  }
}

class MinutelyData {
  int precipIntensity;
  int precipProbability;
  int time;

  MinutelyData.fromParams(
      {this.precipIntensity, this.precipProbability, this.time});

  MinutelyData.fromJson(jsonRes) {
    precipIntensity = jsonRes['precipIntensity'];
    precipProbability = jsonRes['precipProbability'];
    time = jsonRes['time'];
  }

  @override
  String toString() {
    return '{"precipIntensity": $precipIntensity,"precipProbability": $precipProbability,"time": $time}';
  }
}

class Hourly {
  String icon;
  String summary;
  List<HourlyData> data;

  Hourly.fromParams({this.icon, this.summary, this.data});

  Hourly.fromJson(jsonRes) {
    icon = jsonRes['icon'];
    summary = jsonRes['summary'];
    data = jsonRes['data'] == null ? null : [];

    for (var dataItem in data == null ? [] : jsonRes['data']) {
      data.add(dataItem == null ? null : new HourlyData.fromJson(dataItem));
    }
  }

  @override
  String toString() {
    return '{"icon": ${icon != null ? '${json.encode(icon)}' : 'null'},"summary": ${summary != null ? '${json.encode(summary)}' : 'null'},"data": $data}';
  }
}

class HourlyData {
  double ozone;
  double precipIntensity;
  double precipProbability;
  int time;
  int uvIndex;
  int windBearing;
  double apparentTemperature;
  double cloudCover;
  double dewPoint;
  double humidity;
  double pressure;
  double temperature;
  double visibility;
  double windGust;
  double windSpeed;
  String icon;
  String precipType;
  String summary;

  HourlyData.fromParams(
      {this.ozone,
      this.precipIntensity,
      this.precipProbability,
      this.time,
      this.uvIndex,
      this.windBearing,
      this.apparentTemperature,
      this.cloudCover,
      this.dewPoint,
      this.humidity,
      this.pressure,
      this.temperature,
      this.visibility,
      this.windGust,
      this.windSpeed,
      this.icon,
      this.precipType,
      this.summary});

  HourlyData.fromJson(jsonRes) {
    ozone = double.parse(jsonRes['ozone'].toString() ?? '0.0');
    precipIntensity =
        double.parse(jsonRes['precipIntensity'].toString() ?? '0.0');
    precipProbability =
        double.parse(jsonRes['precipProbability'].toString() ?? '0.0');
    time = jsonRes['time'];
    uvIndex = jsonRes['uvIndex'];
    windBearing = jsonRes['windBearing'];
    apparentTemperature =
        double.parse(jsonRes['apparentTemperature'].toString() ?? '0.0');
    cloudCover = double.parse(jsonRes['cloudCover'].toString() ?? '0.0');
    dewPoint = double.parse(jsonRes['dewPoint'].toString() ?? '0.0');
    humidity = double.parse(jsonRes['humidity'].toString() ?? '0.0');
    pressure = double.parse(jsonRes['pressure'].toString() ?? '0.0');
    temperature = double.parse(jsonRes['temperature'].toString() ?? '0.0');
    visibility = double.parse(jsonRes['visibility'].toString() ?? '0.0');
    windGust = double.parse(jsonRes['windGust'].toString() ?? '0.0');
    windSpeed = double.parse(jsonRes['windSpeed'].toString() ?? '0.0');
    icon = jsonRes['icon'];
    precipType = jsonRes['precipType'];
    summary = jsonRes['summary'];
  }

  @override
  String toString() {
    return '{"ozone": $ozone,"precipIntensity": $precipIntensity,"precipProbability": $precipProbability,"time": $time,"uvIndex": $uvIndex,"windBearing": $windBearing,"apparentTemperature": $apparentTemperature,"cloudCover": $cloudCover,"dewPoint": $dewPoint,"humidity": $humidity,"pressure": $pressure,"temperature": $temperature,"visibility": $visibility,"windGust": $windGust,"windSpeed": $windSpeed,"icon": ${icon != null ? '${json.encode(icon)}' : 'null'},"precipType": ${precipType != null ? '${json.encode(precipType)}' : 'null'},"summary": ${summary != null ? '${json.encode(summary)}' : 'null'}}';
  }
}

class Flags {
  double nearestStation;
  String units;
  List<String> sources;

  Flags.fromParams({this.nearestStation, this.units, this.sources});

  Flags.fromJson(jsonRes) {
    nearestStation = jsonRes['nearest-station'];
    units = jsonRes['units'];
    sources = jsonRes['sources'] == null ? null : [];

    for (var sourcesItem in sources == null ? [] : jsonRes['sources']) {
      sources.add(sourcesItem);
    }
  }

  @override
  String toString() {
    return '{"nearest-station": $nearestStation,"units": ${units != null ? '${json.encode(units)}' : 'null'},"sources": $sources}';
  }
}

class Daily {
  String icon;
  String summary;
  List<DailyData> data;

  Daily.fromParams({this.icon, this.summary, this.data});

  Daily.fromJson(jsonRes) {
    icon = jsonRes['icon'];
    summary = jsonRes['summary'];
    data = jsonRes['data'] == null ? null : [];

    for (var dataItem in data == null ? [] : jsonRes['data']) {
      data.add(dataItem == null ? null : new DailyData.fromJson(dataItem));
    }
  }

  @override
  String toString() {
    return '{"icon": ${icon != null ? '${json.encode(icon)}' : 'null'},"summary": ${summary != null ? '${json.encode(summary)}' : 'null'},"data": $data}';
  }
}

class DailyData {
  int apparentTemperatureHighTime;
  int apparentTemperatureLowTime;
  int apparentTemperatureMaxTime;
  int apparentTemperatureMinTime;
  int precipIntensityMaxTime;
  int sunriseTime;
  int sunsetTime;
  int temperatureHighTime;
  int temperatureLowTime;
  int temperatureMaxTime;
  int temperatureMinTime;
  int time;
  int uvIndex;
  int uvIndexTime;
  int windBearing;
  int windGustTime;
  double apparentTemperatureHigh;
  double apparentTemperatureLow;
  double apparentTemperatureMax;
  double apparentTemperatureMin;
  double cloudCover;
  double dewPoint;
  double humidity;
  double moonPhase;
  double ozone;
  double precipIntensity;
  double precipIntensityMax;
  double precipProbability;
  double pressure;
  double temperatureHigh;
  double temperatureLow;
  double temperatureMax;
  double temperatureMin;
  double visibility;
  double windGust;
  double windSpeed;
  String icon;
  String precipType;
  String summary;

  DailyData.fromParams(
      {this.apparentTemperatureHighTime,
      this.apparentTemperatureLowTime,
      this.apparentTemperatureMaxTime,
      this.apparentTemperatureMinTime,
      this.precipIntensityMaxTime,
      this.sunriseTime,
      this.sunsetTime,
      this.temperatureHighTime,
      this.temperatureLowTime,
      this.temperatureMaxTime,
      this.temperatureMinTime,
      this.time,
      this.uvIndex,
      this.uvIndexTime,
      this.windBearing,
      this.windGustTime,
      this.apparentTemperatureHigh,
      this.apparentTemperatureLow,
      this.apparentTemperatureMax,
      this.apparentTemperatureMin,
      this.cloudCover,
      this.dewPoint,
      this.humidity,
      this.moonPhase,
      this.ozone,
      this.precipIntensity,
      this.precipIntensityMax,
      this.precipProbability,
      this.pressure,
      this.temperatureHigh,
      this.temperatureLow,
      this.temperatureMax,
      this.temperatureMin,
      this.visibility,
      this.windGust,
      this.windSpeed,
      this.icon,
      this.precipType,
      this.summary});

  DailyData.fromJson(jsonRes) {
    apparentTemperatureHighTime = jsonRes['apparentTemperatureHighTime'];
    apparentTemperatureLowTime = jsonRes['apparentTemperatureLowTime'];
    apparentTemperatureMaxTime = jsonRes['apparentTemperatureMaxTime'];
    apparentTemperatureMinTime = jsonRes['apparentTemperatureMinTime'];
    precipIntensityMaxTime = jsonRes['precipIntensityMaxTime'];
    sunriseTime = jsonRes['sunriseTime'];
    sunsetTime = jsonRes['sunsetTime'];
    temperatureHighTime = jsonRes['temperatureHighTime'];
    temperatureLowTime = jsonRes['temperatureLowTime'];
    temperatureMaxTime = jsonRes['temperatureMaxTime'];
    temperatureMinTime = jsonRes['temperatureMinTime'];
    time = jsonRes['time'];
    uvIndex = jsonRes['uvIndex'];
    uvIndexTime = jsonRes['uvIndexTime'];
    windBearing = jsonRes['windBearing'];
    windGustTime = jsonRes['windGustTime'];
    apparentTemperatureHigh =
        double.parse(jsonRes['apparentTemperatureHigh'].toString() ?? '0.0');
    apparentTemperatureLow =
        double.parse(jsonRes['apparentTemperatureLow'].toString() ?? '0.0');
    apparentTemperatureMax =
        double.parse(jsonRes['apparentTemperatureMax'].toString() ?? '0.0');
    apparentTemperatureMin =
        double.parse(jsonRes['apparentTemperatureMin'].toString() ?? '0.0');
    cloudCover = double.parse(jsonRes['cloudCover'].toString() ?? '0.0');
    dewPoint = double.parse(jsonRes['dewPoint'].toString() ?? '0.0');
    humidity = double.parse(jsonRes['humidity'].toString() ?? '0.0');
    moonPhase = double.parse(jsonRes['moonPhase'].toString() ?? '0.0');
    ozone = double.parse(jsonRes['ozone'].toString() ?? '0.0');
    precipIntensity =
        double.parse(jsonRes['precipIntensity'].toString() ?? '0.0');
    precipIntensityMax =
        double.parse(jsonRes['precipIntensityMax'].toString() ?? '0.0');
    precipProbability =
        double.parse(jsonRes['precipProbability'].toString() ?? '0.0');
    pressure = double.parse(jsonRes['pressure'].toString() ?? '0.0');
    temperatureHigh =
        double.parse(jsonRes['temperatureHigh'].toString() ?? '0.0');
    temperatureLow =
        double.parse(jsonRes['temperatureLow'].toString() ?? '0.0');
    temperatureMax =
        double.parse(jsonRes['temperatureMax'].toString() ?? '0.0');
    temperatureMin =
        double.parse(jsonRes['temperatureMin'].toString() ?? '0.0');
    visibility = double.parse(jsonRes['visibility'].toString() ?? '0.0');
    windGust = double.parse(jsonRes['windGust'].toString() ?? '0.0');
    windSpeed = double.parse(jsonRes['windSpeed'].toString() ?? '0.0');
    icon = jsonRes['icon'];
    precipType = jsonRes['precipType'];
    summary = jsonRes['summary'];
  }

  @override
  String toString() {
    return '{"apparentTemperatureHighTime": $apparentTemperatureHighTime,"apparentTemperatureLowTime": $apparentTemperatureLowTime,"apparentTemperatureMaxTime": $apparentTemperatureMaxTime,"apparentTemperatureMinTime": $apparentTemperatureMinTime,"precipIntensityMaxTime": $precipIntensityMaxTime,"sunriseTime": $sunriseTime,"sunsetTime": $sunsetTime,"temperatureHighTime": $temperatureHighTime,"temperatureLowTime": $temperatureLowTime,"temperatureMaxTime": $temperatureMaxTime,"temperatureMinTime": $temperatureMinTime,"time": $time,"uvIndex": $uvIndex,"uvIndexTime": $uvIndexTime,"windBearing": $windBearing,"windGustTime": $windGustTime,"apparentTemperatureHigh": $apparentTemperatureHigh,"apparentTemperatureLow": $apparentTemperatureLow,"apparentTemperatureMax": $apparentTemperatureMax,"apparentTemperatureMin": $apparentTemperatureMin,"cloudCover": $cloudCover,"dewPoint": $dewPoint,"humidity": $humidity,"moonPhase": $moonPhase,"ozone": $ozone,"precipIntensity": $precipIntensity,"precipIntensityMax": $precipIntensityMax,"precipProbability": $precipProbability,"pressure": $pressure,"temperatureHigh": $temperatureHigh,"temperatureLow": $temperatureLow,"temperatureMax": $temperatureMax,"temperatureMin": $temperatureMin,"visibility": $visibility,"windGust": $windGust,"windSpeed": $windSpeed,"icon": ${icon != null ? '${json.encode(icon)}' : 'null'},"precipType": ${precipType != null ? '${json.encode(precipType)}' : 'null'},"summary": ${summary != null ? '${json.encode(summary)}' : 'null'}}';
  }
}

class Currently {
  int nearestStormBearing;
  int nearestStormDistance;
  double precipIntensity;
  double precipProbability;
  int time;
  int uvIndex;
  int windBearing;
  double apparentTemperature;
  double cloudCover;
  double dewPoint;
  double humidity;
  double ozone;
  double pressure;
  double temperature;
  double visibility;
  double windGust;
  double windSpeed;
  String icon;
  String summary;

  String precipType;

  Currently.fromParams(
      {this.nearestStormBearing,
      this.nearestStormDistance,
      this.precipIntensity,
      this.precipProbability,
      this.time,
      this.uvIndex,
      this.windBearing,
      this.apparentTemperature,
      this.cloudCover,
      this.dewPoint,
      this.humidity,
      this.ozone,
      this.pressure,
      this.temperature,
      this.visibility,
      this.windGust,
      this.windSpeed,
      this.icon,
      this.summary,
      this.precipType});

  Currently.fromJson(jsonRes) {
    nearestStormBearing = jsonRes['nearestStormBearing'];
    nearestStormDistance = jsonRes['nearestStormDistance'];
    precipIntensity =
        double.parse(jsonRes['precipIntensity'].toString() ?? '0.0');
    precipProbability =
        double.parse(jsonRes['precipProbability'].toString() ?? '0.0');
    time = jsonRes['time'];
    uvIndex = jsonRes['uvIndex'];
    windBearing = jsonRes['windBearing'];
    apparentTemperature =
        double.parse(jsonRes['apparentTemperature'].toString() ?? '0.0');
    cloudCover = double.parse(jsonRes['cloudCover'].toString() ?? '0.0');
    dewPoint = double.parse(jsonRes['dewPoint'].toString() ?? '0.0');
    humidity = double.parse(jsonRes['humidity'].toString() ?? '0.0');
    ozone = double.parse(jsonRes['ozone'].toString() ?? '0.0');
    pressure = double.parse(jsonRes['pressure'].toString() ?? '0.0');
    temperature = double.parse(jsonRes['temperature'].toString() ?? '0.0');
    visibility = double.parse(jsonRes['visibility'].toString() ?? '0.0');
    windGust = double.parse(jsonRes['windGust'].toString() ?? '0.0');
    windSpeed = double.parse(jsonRes['windSpeed'].toString() ?? '0.0');
    icon = jsonRes['icon'];
    summary = jsonRes['summary'];

    precipType = jsonRes['precipType'];
  }

  @override
  String toString() {
    return '{"nearestStormBearing": $nearestStormBearing,"nearestStormDistance": $nearestStormDistance,"precipIntensity": $precipIntensity,"precipProbability": $precipProbability,"time": $time,"uvIndex": $uvIndex,"windBearing": $windBearing,"apparentTemperature": $apparentTemperature,"cloudCover": $cloudCover,"dewPoint": $dewPoint,"humidity": $humidity,"ozone": $ozone,"pressure": $pressure,"temperature": $temperature,"visibility": $visibility,"windGust": $windGust,"windSpeed": $windSpeed,"icon": ${icon != null ? '${json.encode(icon)}' : 'null'},"summary": ${summary != null ? '${json.encode(summary)}' : 'null'},"precipType": ${precipType != null ? '${json.encode(precipType)}' : 'null'}}';
  }
}
