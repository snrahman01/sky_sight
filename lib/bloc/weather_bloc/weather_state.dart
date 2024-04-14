import 'package:equatable/equatable.dart';
import '../../constants/units.dart';
import '../../models/weather_response_model.dart';

abstract class WeatherState extends Equatable {
  final double? lat;
  final double? lon;

  const WeatherState({this.lat, this.lon});

  @override
  List<Object?> get props => [lat, lon];
}

class WeatherInitial extends WeatherState {
  const WeatherInitial({double? lat, double? lon}) : super(lat: lat, lon: lon);
}

class WeatherLoadInProgress extends WeatherState {}

class WeatherLoadSuccess extends WeatherState {
  final WeatherResponse weather;
  final Units unit;
  const WeatherLoadSuccess({
    required this.weather,
    this.unit = Units.metric,
    double? lat,
    double? lon,
  }) : super(lat: lat, lon: lon);

  WeatherLoadSuccess copyWith({
    WeatherResponse? weather,
    Units? unit,
    double? lat,
    double? lon,
  }) {
    return WeatherLoadSuccess(
      weather: weather ?? this.weather,
      unit: unit ?? this.unit,
      lat: lat ?? this.lat,
      lon: lon ?? this.lon,
    );
  }

  @override
  List<Object?> get props => super.props..addAll([weather, unit]);
}

class WeatherLoadFailure extends WeatherState {}
