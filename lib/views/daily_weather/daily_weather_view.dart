import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nova_weather/models/daily_forecast.dart';
import 'package:nova_weather/views/weather_icon.dart';

class DailyForecastView extends StatelessWidget {
  final DailyForecastModel dailyForecastModel;
  const DailyForecastView({Key key, this.dailyForecastModel}) : super(key: key);

  Widget build(BuildContext context) {
    var weatherModel = dailyForecastModel.weather.first;
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 10,
      ),
      padding: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: Colors.black38,
        borderRadius: BorderRadius.all(
          Radius.circular(
            120,
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Spacer(),
          buildDateTimeLabel(dailyForecastModel.dt, context),
          WeatherIcon(
            weatherDescriptionModel: weatherModel,
            scale: 1.5,
          ),
          buildTempLabel(dailyForecastModel.temp.day, context),
          Spacer(),
        ],
      ),
    );
  }

  Widget buildTempLabel(double temperature, BuildContext context) {
    String temperatureLabel = temperature.round().toString() + ' °';
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: Text(temperatureLabel),
    );
  }

  Widget buildDateTimeLabel(DateTime date, BuildContext context) {
    var formatter = new DateFormat('EEE');
    String day = formatter.format(date);
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: Text(day),
    );
  }
}
