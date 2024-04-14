import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sky_sight/pages/main_page.dart';
import 'package:sky_sight/repositories/city_repository.dart';
import 'bloc/weather_bloc/weather_bloc.dart';
import 'datasource/local_datasource.dart';
import 'network/dio_client.dart';
import 'repositories/weather_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();
  final localDataSource = LocalDataSource(sharedPreferences: sharedPreferences);
  final cityRepository = CityRepository(localDataSource: localDataSource);
  runApp(MyApp(cityRepository: cityRepository,));
}

class MyApp extends StatelessWidget {

  final CityRepository cityRepository;

  MyApp({required this.cityRepository});
  @override
  Widget build(BuildContext context) {
    final DioClient dioClient = DioClient();

    final WeatherRepository weatherRepository = WeatherRepository(dioClient);

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<WeatherRepository>(
          create: (context) => weatherRepository,
        ),
        RepositoryProvider<CityRepository>(
          create: (context) => cityRepository,
        ),
        // Add more repositories if needed
      ],
      child: MaterialApp(
        title: 'Flutter Weather App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: BlocProvider(
          create: (context) => WeatherBloc(weatherRepository: weatherRepository),
          child: MainPage(),
        ),
      ),
    );
  }
}