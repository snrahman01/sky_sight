import 'package:sky_sight/constants/units.dart';
import '../models/city_coordinate_model.dart';
import '../models/weather_response_model.dart';
import '../network/api_endpoints.dart';
import '../network/dio_client.dart';

class WeatherRepository {
  final DioClient _dioClient;

  WeatherRepository(this._dioClient);

  Future<List<CityCoordinate>> searchCity(String cityName) async {
    final response = await _dioClient.get(
      ApiEndpoints.geo(cityName),
    );

    if (response.statusCode == 200) {
      return (response.data as List)
          .map((city) => CityCoordinate.fromJson(city))
          .toList();
    } else {
      throw Exception('Error fetching cities');
    }
  }

  Future<WeatherResponse> getWeatherDetails(
      double lat, double lon, Units unit) async {
    final response =
        await _dioClient.get(ApiEndpoints.forecast(lat, lon, unit));

    if (response.statusCode == 200) {
      return WeatherResponse.fromJson(response.data);
    } else {
      throw Exception('Error fetching weather details');
    }
  }
}
