import 'package:equatable/equatable.dart';
import 'package:sky_sight/models/city_coordinate_model.dart';

abstract class CityEvent extends Equatable {
  const CityEvent();

  @override
  List<Object> get props => [];
}

class LoadCityName extends CityEvent {}

class UpdateCityName extends CityEvent {
  final CityCoordinate city;

  const UpdateCityName({required this.city});

  @override
  List<Object> get props => [city];
}
