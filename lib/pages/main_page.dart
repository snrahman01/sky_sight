import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sky_sight/bloc/city_bloc/city_event.dart';
import 'package:sky_sight/widgets/weather_success_widget.dart';
import '../bloc/city_bloc/city_bloc.dart';
import '../bloc/city_bloc/city_state.dart';
import '../bloc/city_search_bloc/city_search_bloc.dart';
import '../bloc/weather_bloc/weather_bloc.dart';
import '../bloc/weather_bloc/weather_event.dart';
import '../bloc/weather_bloc/weather_state.dart';
import '../constants/units.dart';
import '../repositories/city_repository.dart';
import '../repositories/weather_repository.dart';
import 'city_search_page.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return MultiBlocProvider(
      providers: [
        BlocProvider<WeatherBloc>(
          create: (context) =>
              WeatherBloc(weatherRepository: context.read<WeatherRepository>()),
        ),
        BlocProvider<CityBloc>(
          create: (context) {
            CityBloc cityBloc =
                CityBloc(RepositoryProvider.of<CityRepository>(context));
            cityBloc.add(LoadCityName());
            return cityBloc;
          },
        ),
      ],
      child: Scaffold(
          appBar: AppBar(
              flexibleSpace:
                  SafeArea(child: _cityNameWidget(context, screenSize))),
          body: _weatherBlocProvider()),
    );
  }

  Widget _cityNameWidget(BuildContext context, Size screenSize) {
    return BlocListener<CityBloc, CityState>(listener: (context, state) {
      if (state is CityNameLoadSuccess) {
        context.read<WeatherBloc>().add(
              WeatherRequested(lat: state.city.lat, lon: state.city.lon),
            );
      }
    }, child: BlocBuilder<CityBloc, CityState>(
      builder: (context, state) {
        return GestureDetector(
            onTap: () async {
              final selectedCity = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BlocProvider<CitySearchBloc>(
                    create: (BuildContext context) => CitySearchBloc(
                        weatherRepository: context.read<WeatherRepository>()),
                    child: SearchPage(),
                  ),
                ),
              );
              if (selectedCity != null) {
                context
                    .read<CityBloc>()
                    .add(UpdateCityName(city: selectedCity));
              }
            },
            child: Container(
              padding: const EdgeInsets.all(2.0),
              margin:
                  const EdgeInsets.only(top: 2, left: 12, right: 12, bottom: 2),
              decoration: BoxDecoration(
                  color: Colors.black12,
                  border: Border.all(color: Colors.grey, width: 1),
                  borderRadius: BorderRadius.circular(4)),
              width: screenSize.width,
              child: ListTile(
                leading: Icon(Icons.search),
                title: Text(
                  (state is CityNameLoadSuccess)
                      ? (state.city.name + ', ' + state.city.country)
                      : 'Select a Location',
                  style: TextStyle(fontSize: 18),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                trailing: _unitSelector(context),
              ),
            ));
      },
    ));
  }

  Widget _unitSelector(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        Units currentUnit = Units.metric;
        if (state is WeatherLoadSuccess) {
          currentUnit = state.unit;
        }

        return DropdownButton<Units>(
          value: currentUnit,
          items: Units.values.map<DropdownMenuItem<Units>>((Units unit) {
            return DropdownMenuItem<Units>(
              value: unit,
              child: Text(unit == Units.metric ? 'Celsius' : 'Fahrenheit'),
            );
          }).toList(),
          onChanged: (Units? newValue) {
            if (newValue != null) {
              context
                  .read<WeatherBloc>()
                  .add(WeatherUnitChanged(unit: newValue));
            }
          },
        );
      },
    );
  }

  Widget _weatherBlocProvider() {
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        return state is WeatherLoadInProgress
            ? Center(child: CircularProgressIndicator())
            : state is WeatherLoadSuccess
                ? GestureDetector(
                    onTap: () {
                      final cityState = context.read<CityBloc>().state;
                      if (cityState is CityNameLoadSuccess) {
                        context.read<WeatherBloc>().add(
                              WeatherRequested(
                                lat: cityState.city.lat,
                                lon: cityState.city.lon,
                              ),
                            );
                      }
                    },
                    child: WeatherSuccessWidget(
                      weatherList: state.weather.list,
                    ))
                : state is WeatherLoadFailure
                    ? Center(child: Text('Failed to Fetch Weather'))
                    : Center(child: Text('Please Select a Location'));
      },
    );
  }
}
