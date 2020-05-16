import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:nova_weather/presenters/weather_presenter.dart';
import 'package:nova_weather/providers/open_weather_provider.dart';
import 'home_page.dart';
import 'theme/colors.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.now();
    bool isDay = dateTime.hour < 21;
    Client httpClientProvider = Client();
    OpenWeatherProvider openWeatherProvider =
        OpenWeatherProvider(httpClientProvider);
    WeatherPresenter weatherPresenter = WeatherPresenter(openWeatherProvider);
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
        canvasColor:
            !isDay ? AppColors.themeColorLight : AppColors.themeColorDark,
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
