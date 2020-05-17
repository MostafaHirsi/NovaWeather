import 'package:flutter/material.dart';
import 'package:nova_weather/injector.dart';
import 'package:nova_weather/presenters/weather_presenter.dart';
import 'home_page.dart';

void main() {
  runApp(
    Injector(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    WeatherPresenter weatherPresenter = Injector.of(context).weatherPresenter;
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
