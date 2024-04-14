import 'package:equatable/equatable.dart';
import '../../constants/units.dart';
import '../../models/weather_response_model.dart';

abstract class WeatherState extends Equatable {
  final double? lat;
  final double? lon;
  final Units? unit;

  const WeatherState({this.lat, this.lon, this.unit});

  @override
  List<Object?> get props => [lat, lon, unit];
}

class WeatherInitial extends WeatherState {
  const WeatherInitial({double? lat, double? lon}) : super(lat: lat, lon: lon);
}

class WeatherLoadInProgress extends WeatherState {}

class WeatherLoadSuccess extends WeatherState {
  final WeatherResponse weather;
  const WeatherLoadSuccess({
    required this.weather,
    required Units unit,
    required double lat,
    required double lon,
  }) : super(lat: lat, lon: lon, unit: unit);

  @override
  List<Object?> get props => super.props..addAll([weather, unit]);
}

class WeatherLoadFailure extends WeatherState {
  const WeatherLoadFailure({
    Units? unit,
    double? lat,
    double? lon,
  }) : super(lat: lat, lon: lon, unit: unit);
}
