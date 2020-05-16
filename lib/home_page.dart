import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nova_weather/presenters/weather_presenter.dart';
import 'package:nova_weather/views/weather_forecast_view.dart';

class HomePage extends StatefulWidget {
  final WeatherPresenter presenter;

  const HomePage({Key key, this.presenter}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> implements WeatherForecastView {
  @override
  void initState() {
    super.initState();
    widget.presenter.forecastView = this;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: widget.presenter.retrieveWeatherUpdate,
        child: Center(
          child: Text("Tap to load weather data."),
        ),
      ),
    );
  }

  @override
  void updateWeatherForecast() {
    setState(() {});
  }

  @override
  bool hasData() => widget.presenter.weatherForecastModel != null;
}
