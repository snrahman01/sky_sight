import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sky_sight/constants/units.dart';
import 'package:sky_sight/models/weather_response_model.dart';
import '../../services/location_service.dart';
import '../city_bloc/city_bloc.dart';
import '../city_bloc/city_state.dart';
import 'weather_event.dart';
import 'weather_state.dart';
import '../../repositories/weather_repository.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;

  WeatherBloc({required this.weatherRepository}) : super(WeatherInitial()) {
    on<WeatherUnitChanged>(_onWeatherUnitChanged);
    on<FetchWeather>(_onFetchWeather);
    //on<WeatherLoadForCurrentLocation>(_onLoadForCurrentLocation);
    on<WeatherRequested>((event, emit) async {
      emit(WeatherLoadInProgress());

      try {
        final WeatherResponse weather = await weatherRepository
            .getWeatherDetails(event.lat, event.lon, Units.metric);
        emit(WeatherLoadSuccess(
          weather: weather,
          lat: event.lat,
          lon: event.lon,
        ));
      } catch (_) {
        emit(WeatherLoadFailure());
      }
    });
  }

  Future<void> _fetchWeatherForCurrentLocation(
    Emitter<WeatherState> emit,
    SharedPreferences prefs,
  ) async {
    final location = await LocationService().getCurrentLocation();
    final weather = await weatherRepository.getWeatherDetails(
        location.lat, location.lon, Units.metric);
    await prefs.setStringList('savedCity', [
      location.country,
      location.name,
      location.lat.toString(),
      location.lon.toString()
    ]);
    emit(WeatherLoadSuccess(
        weather: weather, lat: location.lat, lon: location.lon));
  }

  void _onFetchWeather(FetchWeather event, Emitter<WeatherState> emit) async {
    try {
      emit(WeatherLoadInProgress());
      final WeatherResponse weather = await weatherRepository.getWeatherDetails(
          event.location.lat, event.location.lon, Units.metric);
      emit(WeatherLoadSuccess(
          weather: weather, lat: event.location.lat, lon: event.location.lon));
    } catch (e) {
      emit(WeatherLoadFailure());
    }
  }

  Future<void> _onWeatherUnitChanged(
    WeatherUnitChanged event,
    Emitter<WeatherState> emit,
  ) async {
    final double? lat = state.lat;
    final double? lon = state.lon;

    if (lat != null && lon != null) {
      try {
        emit(WeatherLoadInProgress());
        final WeatherResponse weather =
            await weatherRepository.getWeatherDetails(lat, lon, event.unit);
        emit(WeatherLoadSuccess(
            weather: weather, unit: event.unit, lat: lat, lon: lon));
      } catch (_) {
        emit(WeatherLoadFailure());
      }
    }
  }
}
