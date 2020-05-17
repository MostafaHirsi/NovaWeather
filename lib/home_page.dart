import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nova_weather/enums/weather_status.dart';
import 'package:nova_weather/presenters/weather_presenter.dart';

import 'interfaces/weather_forecast_view.dart';
import 'theme/loading_indicator.dart';
import 'views/weather_page_view.dart';

class HomePage extends StatefulWidget {
  final WeatherPresenter presenter;

  const HomePage({Key key, this.presenter}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    implements WeatherForecastViewInterface {
  @override
  void initState() {
    super.initState();
    widget.presenter.forecastView = this;
    widget.presenter.retrieveWeatherUpdate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: buildBackgroundDecoration(),
        child: buildOverallView(),
      ),
    );
  }

  Widget buildOverallView() {
    WeatherStatus weatherStatus = widget.presenter.weatherStatus;
    switch (weatherStatus) {
      case WeatherStatus.WeatherStatusSuccess:
        return WeatherPageView(
          weatherForecastModel: widget.presenter.weatherForecastModel,
          updateWeather: widget.presenter.retrieveWeatherUpdate,
          locationModel: widget.presenter.locationModel,
        );
        break;
      case WeatherStatus.WeatherStatusLoading:
        return LoadingIndicator();
        break;
      case WeatherStatus.WeatherStatusFailed:
        return buildPlaceHolder(isError: true);
        break;
      case WeatherStatus.WeatherStatusInitial:
      default:
        return buildPlaceHolder();
    }
  }

  GestureDetector buildPlaceHolder({bool isError = false}) {
    return GestureDetector(
      onTap: () {
        widget.presenter.retrieveWeatherUpdate();
      },
      child: Container(
        alignment: Alignment.center,
        color: Colors.transparent,
        constraints: BoxConstraints.expand(),
        child: Text(!isError
            ? "Tap to load weather data."
            : "Could not retrieve weather info, please try again"),
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
}
