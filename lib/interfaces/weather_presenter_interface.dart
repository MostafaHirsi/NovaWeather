import 'package:nova_weather/enums/weather_status.dart';
import 'package:nova_weather/models/location_model.dart';

abstract class WeatherPresenterInterface {

  Future<void> retrieveWeatherUpdate();

  WeatherStatus weatherStatus;

  LocationModel locationModel;
  
}
