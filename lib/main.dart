import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:nova_weather/models/location_model.dart';
import 'package:nova_weather/presenters/weather_presenter.dart';
import 'home_page.dart';
import 'providers/open_weather_provider.dart';

// Other locations to play with
// "Melbourne", "Australia", 37.8136, 144.9631
// "New York", "United State", 40.7128, 74.0060

void main() {
  Client httpClient = Client();
  OpenWeatherProvider openWeatherProvider = OpenWeatherProvider(httpClient);
  WeatherPresenter weatherPresenter = WeatherPresenter(openWeatherProvider);
  weatherPresenter.locationModel =
      new LocationModel("London", "United Kingdom", 51.5074, 0.1278);
  runApp(
    MyApp(
      weatherPresenter: weatherPresenter,
    ),
  );
}

class MyApp extends StatelessWidget {
  final WeatherPresenter weatherPresenter;

  const MyApp({Key key, this.weatherPresenter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: Colors.white,
              decorationColor: Colors.white,
              displayColor: Colors.white,
            ),
        fontFamily: 'OpenSans',
        appBarTheme: AppBarTheme(
          color: Colors.transparent,
          elevation: 0,
        ),
      ),
      home: HomePage(
        presenter: weatherPresenter,
      ),
    );
  }
}
