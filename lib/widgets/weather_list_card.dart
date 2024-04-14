import 'package:flutter/material.dart';
import '../models/weather_response_model.dart';

class WeatherListCard extends StatelessWidget {
  final ForecastItem currentForecastItem;

  WeatherListCard({required this.currentForecastItem});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Card(
        child: Container(
      margin: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(currentForecastItem.dayOfWeek.substring(0, 3)),
          Image.network(
            'http://openweathermap.org/img/wn/${currentForecastItem.iconCode}.png',
            width: screenSize.width * 0.2,
            height: screenSize.width * 0.2,
            fit: BoxFit.contain,
          ),
          Text(
              '${currentForecastItem.temperatureMin.toStringAsFixed(2)}°/ ${currentForecastItem.temperatureMax.toStringAsFixed(2)}°'),
        ],
      ),
    ));
  }
}
