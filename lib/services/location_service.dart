import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sky_sight/models/city_coordinate_model.dart';

class LocationService {
  Future<CityCoordinate> _getAddressFromLatLng(Position position) async {
    return await placemarkFromCoordinates(position.latitude, position.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      return CityCoordinate(
          name: place.locality ?? '',
          lat: position.latitude,
          lon: position.longitude,
          country: place.country ?? '');
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<CityCoordinate> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition();
    return await _getAddressFromLatLng(position);
  }
}
