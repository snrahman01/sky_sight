import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sky_sight/models/city_coordinate_model.dart';
import '../../repositories/city_repository.dart';
import '../../services/location_service.dart';
import 'city_event.dart';
import 'city_state.dart';

class CityBloc extends Bloc<CityEvent, CityState> {
  final CityRepository cityRepository;
  CityBloc(this.cityRepository) : super(CityInitial()) {
    on<LoadCityName>(_onLoadCityName);

    on<UpdateCityName>(_onUpdateCityName);
  }

  void _onLoadCityName(LoadCityName event, Emitter<CityState> emit) async {
    try {
      emit(CityNameLoadInProgress());
      List<String>? cityInfo = cityRepository.getSavedCity();
      CityCoordinate cityCoordinate;
      if (cityInfo == null || cityInfo[0].isEmpty) {
        cityCoordinate = await LocationService().getCurrentLocation();

        cityRepository.saveCity(cityCoordinate);
      } else if (double.tryParse(cityInfo[2]) != null &&
          double.tryParse(cityInfo[3]) != null) {
        cityCoordinate = CityCoordinate(
            name: cityInfo[1],
            lat: ((double.tryParse(cityInfo[2])) ?? 0),
            lon: ((double.tryParse(cityInfo[3])) ?? 0),
            country: cityInfo[0]);

        cityRepository.saveCity(cityCoordinate);
      } else {
        cityCoordinate = CityCoordinate(name: '', lat: 0, lon: 0, country: '');
      }
      emit(CityNameLoadSuccess(city: cityCoordinate));
    } catch (e) {
      emit(CityNameLoadFailure());
    }
  }

  Future<void> _onUpdateCityName(
      UpdateCityName event, Emitter<CityState> emit) async {
    try {
      final city = CityCoordinate(
          name: event.city.name,
          lat: event.city.lat,
          lon: event.city.lon,
          country: event.city.country);
      cityRepository.saveCity(city);

      cityRepository.saveCity(city);
      emit(CityNameLoadSuccess(city: event.city));
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
