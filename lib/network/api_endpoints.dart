import 'package:sky_sight/constants/units.dart';
import 'package:sky_sight/constants/values.dart';

import '../config.dart';

class ApiEndpoints {
  static const baseUrl = 'http://api.openweathermap.org';
  static String geo(String query) =>
      '/geo/1.0/direct?q=$query&appid=${Config.OPEN_WEATHER_MAP_API_KEY}&limit=$MAX_SEARCH_COUNTRY_LIMIT';
  static String forecast(double lat, double lon, Units units) =>
      '/data/2.5/forecast?lat=$lat&lon=$lon&units=${units.name}&appid=${Config.OPEN_WEATHER_MAP_API_KEY}';
}
