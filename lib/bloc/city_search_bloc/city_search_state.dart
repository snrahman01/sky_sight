import 'package:sky_sight/models/city_coordinate_model.dart';

abstract class CitySearchState {
  const CitySearchState();
}

class CitySearchInitial extends CitySearchState {}

class CitySearchLoadInProgress extends CitySearchState {}

class CitySearchLoadSuccess extends CitySearchState {
  final List<CityCoordinate> cities;

  const CitySearchLoadSuccess({required this.cities});
}

class CitySearchLoadFailure extends CitySearchState {
  final String error;

  const CitySearchLoadFailure({required this.error});
}
