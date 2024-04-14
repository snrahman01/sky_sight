import 'package:equatable/equatable.dart';
import 'package:sky_sight/models/city_coordinate_model.dart';
import '../../constants/units.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [];
}

class WeatherRequested extends WeatherEvent {
  final double lat;
  final double lon;
  final Units unit;

  const WeatherRequested({required this.lat, required this.lon, required this.unit});

  @override
  List<Object> get props => [lat, lon, unit];
}

class FetchWeather extends WeatherEvent {
  final CityCoordinate location;

  const FetchWeather({required this.location});
}

class WeatherUnitChanged extends WeatherEvent {
  final Units unit;

  WeatherUnitChanged({required this.unit});
}
