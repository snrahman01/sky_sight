import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sky_sight/models/weather_response_model.dart';
import 'weather_event.dart';
import 'weather_state.dart';
import '../../repositories/weather_repository.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;

  WeatherBloc({required this.weatherRepository}) : super(WeatherInitial()) {
    on<WeatherUnitChanged>(_onWeatherUnitChanged);
    on<WeatherRequested>((event, emit) async {
      emit(WeatherLoadInProgress());

      try {
        final WeatherResponse weather = await weatherRepository
            .getWeatherDetails(event.lat, event.lon, event.unit);
        emit(WeatherLoadSuccess(
          weather: weather,
          lat: event.lat,
          lon: event.lon,
          unit: event.unit
        ));
      } catch (_) {
        emit(WeatherLoadFailure(
            lat: event.lat,
            lon: event.lon,
            unit: event.unit));
      }
    });
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
        emit(WeatherLoadFailure(unit: event.unit, lat: lat, lon: lon));
      }
    }
  }
}
