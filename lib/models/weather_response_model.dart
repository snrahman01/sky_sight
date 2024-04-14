import 'package:intl/intl.dart';

class WeatherResponse {
  final String cod;
  final int message;
  final int cnt;
  final List<ForecastItem> list;
  final City city;

  WeatherResponse({
    required this.cod,
    required this.message,
    required this.cnt,
    required this.list,
    required this.city,
  });

  factory WeatherResponse.fromJson(Map<String, dynamic> json) {
    return WeatherResponse(
      cod: json['cod'],
      message: json['message'],
      cnt: json['cnt'],
      list:
          (json['list'] as List).map((i) => ForecastItem.fromJson(i)).toList(),
      city: City.fromJson(json['city']),
    );
  }
}

class ForecastItem {
  final String dayOfWeek;
  final String iconCode;
  final num temperature;
  final num temperatureMin;
  final num temperatureMax;
  final int humidity;
  final int pressure;
  final num windSpeed;
  final String weatherMain;

  ForecastItem({
    required this.dayOfWeek,
    required this.iconCode,
    required this.temperature,
    required this.temperatureMin,
    required this.temperatureMax,
    required this.humidity,
    required this.pressure,
    required this.windSpeed,
    required this.weatherMain,
  });

  factory ForecastItem.fromJson(Map<String, dynamic> json) {
    final date = DateTime.parse(json['dt_txt']);
    return ForecastItem(
      dayOfWeek: _formatDayOfWeek(date),
      iconCode: json['weather'][0]['icon'],
      temperature: json['main']['temp'],
      temperatureMin: json['main']['temp_min'],
      temperatureMax: json['main']['temp_max'],
      humidity: json['main']['humidity'],
      pressure: json['main']['pressure'],
      windSpeed: json['wind']['speed'],
      weatherMain: json['weather'][0]['main'],
    );
  }

  static String _formatDayOfWeek(DateTime date) {
    return DateFormat('EEEE').format(date);
  }
}

class MainDetails {
  final double temp;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final int pressure;
  final int seaLevel;
  final int grndLevel;
  final int humidity;
  final double tempKf;

  MainDetails({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.seaLevel,
    required this.grndLevel,
    required this.humidity,
    required this.tempKf,
  });

  factory MainDetails.fromJson(Map<String, dynamic> json) {
    return MainDetails(
      temp: json['temp'].toDouble(),
      feelsLike: json['feels_like'].toDouble(),
      tempMin: json['temp_min'].toDouble(),
      tempMax: json['temp_max'].toDouble(),
      pressure: json['pressure'],
      seaLevel: json['sea_level'],
      grndLevel: json['grnd_level'],
      humidity: json['humidity'],
      tempKf: json['temp_kf'].toDouble(),
    );
  }
}

class WeatherDescription {
  final int id;
  final String main;
  final String description;
  final String icon;

  WeatherDescription({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  factory WeatherDescription.fromJson(Map<String, dynamic> json) {
    return WeatherDescription(
      id: json['id'],
      main: json['main'],
      description: json['description'],
      icon: json['icon'],
    );
  }
}

class Clouds {
  final int all;

  Clouds({required this.all});

  factory Clouds.fromJson(Map<String, dynamic> json) {
    return Clouds(
      all: json['all'],
    );
  }
}

class Wind {
  final double speed;
  final int deg;
  final double gust;

  Wind({
    required this.speed,
    required this.deg,
    required this.gust,
  });

  factory Wind.fromJson(Map<String, dynamic> json) {
    return Wind(
      speed: json['speed'].toDouble(),
      deg: json['deg'],
      gust: json['gust'].toDouble(),
    );
  }
}

class Rain {
  final double h3;

  Rain({required this.h3});

  factory Rain.fromJson(Map<String, dynamic> json) {
    return Rain(
      h3: json['3h'].toDouble(),
    );
  }
}

class City {
  final int id;
  final String name;
  final Coord coord;
  final String country;
  final int population;
  final int timezone;
  final int sunrise;
  final int sunset;

  City({
    required this.id,
    required this.name,
    required this.coord,
    required this.country,
    required this.population,
    required this.timezone,
    required this.sunrise,
    required this.sunset,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json['id'],
      name: json['name'],
      coord: Coord.fromJson(json['coord']),
      country: json['country'],
      population: json['population'],
      timezone: json['timezone'],
      sunrise: json['sunrise'],
      sunset: json['sunset'],
    );
  }
}

class Coord {
  final double lat;
  final double lon;

  Coord({required this.lat, required this.lon});

  factory Coord.fromJson(Map<String, dynamic> json) {
    return Coord(
      lat: json['lat'].toDouble(),
      lon: json['lon'].toDouble(),
    );
  }
}
