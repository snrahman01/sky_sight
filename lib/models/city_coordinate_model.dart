class CityCoordinate {
  final String name;
  final double lat;
  final double lon;
  final String country;

  CityCoordinate({
    required this.name,
    required this.lat,
    required this.lon,
    required this.country,
  });

  factory CityCoordinate.fromJson(Map<String, dynamic> json) {
    return CityCoordinate(
      name: json['name'],
      lat: json['lat'],
      lon: json['lon'],
      country: json['country'],
    );
  }
}