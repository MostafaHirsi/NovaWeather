import 'package:http/src/client.dart';
import 'package:nova_weather/models/current_forecast.dart';
import 'package:nova_weather/models/daily_forecast.dart';
import 'package:nova_weather/models/temperature.dart';
import 'package:nova_weather/models/weather_description.dart';
import 'package:nova_weather/models/weather_forecast.dart';
import 'package:nova_weather/providers/open_weather_provider.dart';

import 'mock_client.dart';

class MockOpenWeatherProvider implements OpenWeatherProvider {
  @override
  String apiKey;

  @override
  Client get client => MockClient();

  @override
  Future<WeatherForecastModel> getOneCall(double lat, double long) {
    WeatherForecastModel responseWeatherForecastModel = buildForecastModel();
    return Future.value(responseWeatherForecastModel);
  }

  WeatherForecastModel buildForecastModel() {
    CurrentForecastModel currentForecastModel = buildCurrentForecastModel();
    DailyForecastModel dailyForecastModel = buildDailyForecastModel();
    WeatherForecastModel weatherForecastModel = WeatherForecastModel(
        current: currentForecastModel,
        daily: [dailyForecastModel, dailyForecastModel]);
    return weatherForecastModel;
  }

  CurrentForecastModel buildCurrentForecastModel() {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(1589633683 * 1000);
    int humidityComparison = 93;
    WeatherDescriptionModel weather = WeatherDescriptionModel(
        description: 'overcast clouds', main: 'Clouds', icon: '04d', id: 804);
    TemperatureModel temp =
        TemperatureModel(max: 20.94, min: 19.01, day: 20.92);
    CurrentForecastModel currentForecastModel = CurrentForecastModel(
        dt: dateTime,
        humidity: humidityComparison,
        weather: [weather],
        temp: temp);
    return currentForecastModel;
  }

  DailyForecastModel buildDailyForecastModel() {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(1589738400 * 1000);
    TemperatureModel temp =
        TemperatureModel(min: 16.17, max: 27.43, day: 26.22);
    WeatherDescriptionModel weather = WeatherDescriptionModel(
        description: 'moderate rain', main: 'Rain', icon: '10d', id: 501);
    DailyForecastModel dailyForecastModel =
        DailyForecastModel(dt: dateTime, temp: temp, weather: [weather]);
    return dailyForecastModel;
  }
}
