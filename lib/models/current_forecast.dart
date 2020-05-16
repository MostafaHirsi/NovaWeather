import 'package:equatable/equatable.dart';
import 'package:nova_weather/models/temperature.dart';
import 'package:nova_weather/models/weather_description.dart';

class CurrentForecastModel extends Equatable {
  DateTime dt;
  TemperatureModel temp;
  int humidity;
  List<WeatherDescriptionModel> weather;

  CurrentForecastModel({this.dt, this.temp, this.humidity, this.weather});

  CurrentForecastModel.fromJson(
      Map<String, dynamic> json, TemperatureModel temp) {
    dt = DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000);
    this.temp = temp;
    humidity = json['humidity'];
    if (json['weather'] != null) {
      weather = new List<WeatherDescriptionModel>();
      json['weather'].forEach((v) {
        weather.add(new WeatherDescriptionModel.fromJson(v));
      });
    }
  }

  @override
  List<Object> get props => [dt, temp, humidity, weather];
}
