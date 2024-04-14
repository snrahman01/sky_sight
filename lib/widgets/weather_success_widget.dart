import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sky_sight/models/weather_response_model.dart';
import 'package:sky_sight/widgets/weather_list_card.dart';
import '../bloc/city_bloc/city_bloc.dart';
import '../bloc/city_bloc/city_state.dart';
import '../bloc/weather_bloc/weather_bloc.dart';
import '../bloc/weather_bloc/weather_event.dart';
import 'details_weather_card.dart';

class WeatherSuccessWidget extends StatelessWidget {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  List<ForecastItem> weatherList;

  WeatherSuccessWidget({required this.weatherList});

  Future<void> _onRefresh(BuildContext context) async {
    final cityState = context.read<CityBloc>().state;
    if (cityState is CityNameLoadSuccess) {
      context.read<WeatherBloc>().add(
            WeatherRequested(
              lat: cityState.city.lat,
              lon: cityState.city.lon,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return OrientationBuilder(
      builder: (context, orientation) {
        bool isLandscape = orientation == Orientation.landscape;

        return isLandscape
            ? _buildLandscapeLayout(context, screenSize)
            : _buildPortraitLayout(context);
      },
    );
  }

  _buildPortraitLayout(BuildContext context) {
    return RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: () => _onRefresh(context),
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            if (weatherList.isNotEmpty)
              DetailsWeatherCard(currentForecastItem: weatherList.first),
            if (weatherList.length > 1)
              Container(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: weatherList.length - 1,
                  itemBuilder: (context, index) {
                    return WeatherListCard(
                        currentForecastItem: weatherList[index + 1]);
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildLandscapeLayout(BuildContext context, Size screenSize) {
    return RefreshIndicator(
        onRefresh: () => _onRefresh(context),
        child: CustomScrollView(slivers: [
          SliverToBoxAdapter(
              child: SizedBox(
            height: screenSize.height * 0.7, // Adjust the height as needed
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: weatherList.length,
              itemBuilder: (context, index) {
                if (index == 0) {
                  // The first item takes half the width of the screen
                  return SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    child: DetailsWeatherCard(
                        currentForecastItem: weatherList[index]),
                  );
                } else {
                  // The rest of the items take a fixed width
                  return SizedBox(
                    width: 200, // Adjust the width as needed
                    child: WeatherListCard(
                        currentForecastItem: weatherList[index]),
                  );
                }
              },
            ),
          )),
        ]));
  }
}
