import 'package:equatable/equatable.dart';
import 'package:sky_sight/models/city_coordinate_model.dart';

abstract class CityState extends Equatable {
  const CityState();

  @override
  List<Object?> get props => [];
}

class CityInitial extends CityState {}

class CityNameLoadInProgress extends CityState {}

class CityNameLoadSuccess extends CityState {
  final CityCoordinate city;

  const CityNameLoadSuccess({required this.city});

  @override
  List<Object> get props => [city];
}

class CityNameLoadFailure extends CityState {}
