import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:nova_weather/models/weather_forecast.dart';

class OpenWeatherProvider {
  String apiKey = '0ca72a96d8d54ccc8a9dbe1c855191f1';
  final Client client;

  OpenWeatherProvider(this.client);

  Future<WeatherForecastModel> getOneCall(double lat, double long) async {
    Response response = await client.get(
        'https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$long&exclude=minutely,hourly&units=metric&appid=$apiKey');
    if (response.statusCode >= 200 && response.statusCode < 300) {
      Map<String, dynamic> responseBody = jsonDecode(response.body);
      WeatherForecastModel oneCallModel =
          WeatherForecastModel.fromJson(responseBody);
      return oneCallModel;
    }
    throw HttpException(
      response.reasonPhrase,
    );
  }
}
