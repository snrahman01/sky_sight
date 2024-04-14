abstract class CitySearchEvent {
  const CitySearchEvent();
}

class CitySearchQueryChanged extends CitySearchEvent {
  final String query;

  const CitySearchQueryChanged({required this.query});
}
