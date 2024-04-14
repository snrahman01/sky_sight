import 'package:sky_sight/models/city_coordinate_model.dart';
import '../datasource/local_datasource.dart';

class CityRepository {
  final LocalDataSource localDataSource;

  CityRepository({required this.localDataSource});

  Future<void> saveCity(CityCoordinate city) async {
    await localDataSource.saveCity(city);
  }

  List<String>? getSavedCity() {
    return localDataSource.getSavedCity();
  }

  Future<void> clearSavedCity() async {
    await localDataSource.clearSavedCity();
  }
}
