import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import '../../models/city_coordinate_model.dart';
import '../../repositories/weather_repository.dart';
import 'city_search_event.dart';
import 'city_search_state.dart';

class CitySearchBloc extends Bloc<CitySearchEvent, CitySearchState> {
  final WeatherRepository weatherRepository;

  CitySearchBloc({required this.weatherRepository})
      : super(CitySearchInitial()) {
    on<CitySearchQueryChanged>(
      _onSearchQueryChanged,
      transformer: (events, mapper) => events
          .debounceTime(const Duration(milliseconds: 500))
          .switchMap(mapper),
    );
  }

  void _onSearchQueryChanged(
      CitySearchQueryChanged event, Emitter<CitySearchState> emit) async {
    if (event.query.isEmpty) {
      emit(CitySearchInitial());
      return;
    }

    emit(CitySearchLoadInProgress());
    try {
      final List<CityCoordinate> cities =
          await weatherRepository.searchCity(event.query);
      emit(CitySearchLoadSuccess(cities: cities));
    } catch (error) {
      emit(CitySearchLoadFailure(error: error.toString()));
    }
  }
}
