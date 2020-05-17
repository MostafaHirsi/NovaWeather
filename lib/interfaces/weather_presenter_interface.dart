import 'package:nova_weather/enums/weather_status.dart';
import 'package:nova_weather/models/weather_forecast.dart';

abstract class WeatherPresenterInterface {

  Future<WeatherForecastModel> retrieveWeatherUpdate();

  WeatherStatus weatherStatus;
  
}
