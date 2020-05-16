import 'package:equatable/equatable.dart';

import 'temperature.dart';
import 'weather_description.dart';

class DailyForecastModel extends Equatable {
  DateTime dt;
  TemperatureModel temp;
  List<WeatherDescriptionModel> weather;

  DailyForecastModel({this.dt, this.temp, this.weather});

  DailyForecastModel.fromJson(Map<String, dynamic> json) {
    dt = DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000);
    temp = json['temp'] != null
        ? new TemperatureModel.fromJson(json['temp'])
        : null;
    if (json['weather'] != null) {
      weather = new List<WeatherDescriptionModel>();
      json['weather'].forEach((v) {
        weather.add(new WeatherDescriptionModel.fromJson(v));
      });
    }
  }

  @override
  List<Object> get props => [dt, temp, weather];
}
