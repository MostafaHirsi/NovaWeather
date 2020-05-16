import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nova_weather/presenters/weather_presenter.dart';
import 'package:nova_weather/views/weather_forecast_view.dart';

import 'theme/colors.dart';

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
      body: Container(
        decoration: buildBackgroundDecoration(),
        child: isRefreshing()
            ? Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(
                    Colors.white,
                  ),
                ),
              )
            : buildOverallView(),
      ),
    );
  }

  Widget buildOverallView() {
    return hasData()
        ? Center(
            child: Text("DATA RETRIEVED"),
          )
        : buildPlaceHolder();
  }

  GestureDetector buildPlaceHolder() {
    return GestureDetector(
      onTap: widget.presenter.retrieveWeatherUpdate,
      child: Container(
        alignment: Alignment.center,
        color: Colors.transparent,
        constraints: BoxConstraints.expand(),
        child: Text("Tap to load weather sfsdfa data."),
      ),
    );
  }

  BoxDecoration buildBackgroundDecoration() {
    return BoxDecoration(
      gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF376EEF),
            Color(0xFF749FFE),
          ],
          stops: [
            0.1,
            0.6
          ]),
    );
  }

  @override
  void updateWeatherForecast() {
    setState(() {});
  }

  @override
  bool hasData() => widget.presenter.weatherForecastModel != null;

  @override
  bool isRefreshing() => widget.presenter.isRefreshing;
}
