import 'package:shared_preferences/shared_preferences.dart';
import 'package:sky_sight/models/city_coordinate_model.dart';

class LocalDataSource {
  final SharedPreferences sharedPreferences;

  LocalDataSource({required this.sharedPreferences});

  Future<void> saveCity(CityCoordinate city) async {
    await sharedPreferences.setStringList('savedCity', [
      city.country,
      city.name,
      city.lat.toString(),
      city.lon.toString(),
    ]);
  }

  List<String>? getSavedCity() {
    return sharedPreferences.getStringList('savedCity');
  }

  Future<void> clearSavedCity() async {
    await sharedPreferences.remove('savedCity');
  }
}