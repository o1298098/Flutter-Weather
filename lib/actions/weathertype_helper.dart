class WeatherTypeHelper {
  static String getWeatherType(String icon) {
    switch (icon) {
      case 'clear-day':
        return 'Clear';
      case 'clear-night':
        return 'Clear';
      case 'cloudy':
        return 'Cloudy';
      case 'partly-cloudy-day':
        return 'Partly cloudy';
      case 'partly-cloudy-night':
        return 'Partly cloudy';
      case 'rain':
        return 'Rain';
      case 'sleet':
        return 'Sleet';
      case 'snow':
        return 'Sonw';
      case 'wind':
        return 'Wind';
      default:
        return '-';
    }
  }
}
