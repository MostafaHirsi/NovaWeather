import 'package:flutter/material.dart';
import 'package:nova_weather/models/weather_forecast.dart';

import 'current_weather/current_weather_view.dart';

class WeatherDataView extends StatelessWidget {
  final WeatherForecastModel weatherForecastModel;
  const WeatherDataView({Key key, this.weatherForecastModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Flexible(
          flex: 7,
          child: CurrentWeatherView(
            currentForecastModel: weatherForecastModel.current,
          ),
        ),
        Spacer(
          flex: 4,
        )
      ],
    );
  }
}
