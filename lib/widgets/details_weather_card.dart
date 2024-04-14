import 'package:flutter/material.dart';
import '../models/weather_response_model.dart';

class DetailsWeatherCard extends StatelessWidget {
  final ForecastItem currentForecastItem;

  DetailsWeatherCard({required this.currentForecastItem});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return OrientationBuilder(builder: (context, orientation) {
      bool isLandscape = orientation == Orientation.landscape;
      return isLandscape
          ? landscapeView(context, screenSize)
          : portraitView(context);
    });
  }

  Widget portraitView(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
              child: Text(
            currentForecastItem.dayOfWeek,
            style: Theme.of(context).textTheme.headlineLarge,
          )),
          Text(currentForecastItem.weatherMain),
          Image.network(
            'http://openweathermap.org/img/wn/${currentForecastItem.iconCode}.png',
            width: double.infinity,
            height: 150,
            fit: BoxFit.contain,
          ),
          Center(
              child: Text(
            '${currentForecastItem.temperature.toStringAsFixed(2)}°',
            style: Theme.of(context).textTheme.headlineLarge,
          )),
          Text('Humidity: ${currentForecastItem.humidity}%'),
          Text('Pressure: ${currentForecastItem.pressure} hPa'),
          Text('Wind: ${currentForecastItem.windSpeed} Km/h'),
        ],
      ),
    );
  }

  Widget landscapeView(BuildContext context, Size size) {
    return Container(
      margin: EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(children: [
            Center(
                child: Text(
              currentForecastItem.dayOfWeek,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium, // Optional: style for better visibility
            )),
            Text(currentForecastItem.weatherMain),
            Image.network(
              'http://openweathermap.org/img/wn/${currentForecastItem.iconCode}.png',
              width: size.height * 0.3,
              height: size.height * 0.3,
              fit: BoxFit.contain,
            )
          ]),
          Center(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                Text(
                    'Temp: ${currentForecastItem.temperature.toStringAsFixed(2)}°'),
                Text('Humidity: ${currentForecastItem.humidity}%'),
                Text('Pressure: ${currentForecastItem.pressure} hPa'),
                Text('Wind: ${currentForecastItem.windSpeed} Km/h')
              ])),
        ],
      ),
    );
  }
}
