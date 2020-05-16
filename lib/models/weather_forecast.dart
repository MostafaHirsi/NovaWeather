import 'package:equatable/equatable.dart';

import 'current_forecast.dart';
import 'daily_forecast.dart';

class WeatherForecastModel extends Equatable {
  CurrentForecastModel current;
  List<DailyForecastModel> daily;

  WeatherForecastModel({this.current, this.daily});

  WeatherForecastModel.fromJson(Map<String, dynamic> json) {
    if (json['daily'] != null) {
      daily = new List<DailyForecastModel>();
      json['daily'].forEach((v) {
        daily.add(new DailyForecastModel.fromJson(v));
      });
      current = json['current'] != null
          ? new CurrentForecastModel.fromJson(json['current'], daily.first.temp)
          : null;
    }
  }

  @override
  List<Object> get props => [current, daily];
}
