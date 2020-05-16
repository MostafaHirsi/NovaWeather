import 'package:nova_weather/models/weather_forecast.dart';

abstract class WeatherPresenterInterface {

  Future<WeatherForecastModel> retrieveWeatherUpdate();

  bool isRefreshing;
  
}
