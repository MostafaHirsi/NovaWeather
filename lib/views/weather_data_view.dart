import 'package:flutter/material.dart';
import 'package:nova_weather/models/daily_forecast.dart';
import 'package:nova_weather/models/weather_forecast.dart';
import 'package:nova_weather/views/daily_weather/daily_weather_view.dart';

import 'current_weather/current_weather_view.dart';

class WeatherDataView extends StatelessWidget {
  final WeatherForecastModel weatherForecastModel;
  final Function updateWeather;

  WeatherDataView({Key key, this.weatherForecastModel, this.updateWeather})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Spacer(
          flex: 8,
        ),
        Flexible(
          flex: 60,
          child: CurrentWeatherView(
            currentForecastModel: weatherForecastModel.current,
            updateWeather: updateWeather,
          ),
        ),
        Flexible(
          flex: 32,
          child: buildDailyForecastList(context),
        ),
        Spacer(
          flex: 12,
        ),
      ],
    );
  }

  Widget buildDailyForecastList(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(
        vertical: 15,
      ),
      margin: EdgeInsets.symmetric(
        horizontal: 10,
      ),
      decoration: BoxDecoration(
        color: Colors.white24,
        borderRadius: BorderRadius.all(
          Radius.circular(
            12,
          ),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          buildDailyForecastLabel(context),
          buildDailyForecastListBuilder(),
        ],
      ),
    );
  }

  Widget buildDailyForecastListBuilder() {
    return Flexible(
      child: ListView.builder(
        itemCount: 5,
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemBuilder: (listContext, index) {
          DailyForecastModel dailyForecastModel =
              weatherForecastModel.daily[index + 1];
          return DailyForecastView(
            dailyForecastModel: dailyForecastModel,
          );
        },
      ),
    );
  }

  Widget buildDailyForecastLabel(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(left: 15, top: 8, bottom: 15),
      child: Text(
        "Next 5 days",
        style: Theme.of(context).textTheme.subhead,
      ),
    );
  }
}
