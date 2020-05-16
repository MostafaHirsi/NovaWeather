import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';
import 'package:nova_weather/models/current_forecast.dart';
import 'package:nova_weather/models/daily_forecast.dart';
import 'package:nova_weather/models/temperature.dart';
import 'package:nova_weather/models/weather_description.dart';
import 'package:nova_weather/models/weather_forecast.dart';
import 'package:nova_weather/providers/open_weather_provider.dart';

import '../mocks/mock_client.dart';

main() {
  group('Open Weather Model Test: ', () {
    String apiKey = '0ca72a96d8d54ccc8a9dbe1c855191f1';
    double mockLat = 33.441792;
    double mockLong = -94.037689;

    double errorLat = 0;
    double errorLong = 0;
    String response = 'invalid location';
    HttpException responseException = HttpException(response);

    Map<String, dynamic> rawOpenWeather = {
      "current": {
        "dt": 1589633683,
        "sunrise": 1589627695,
        "sunset": 1589677822,
        "temp": 19.47,
        "feels_like": 20.23,
        "pressure": 1011,
        "humidity": 93,
        "dew_point": 18.31,
        "uvi": 11,
        "clouds": 90,
        "visibility": 16093,
        "wind_speed": 3.1,
        "wind_deg": 60,
        "weather": [
          {
            "id": 804,
            "main": "Clouds",
            "description": "overcast clouds",
            "icon": "04d"
          }
        ]
      },
      "daily": [
        {
          "dt": 1589652000,
          "sunrise": 1589627695,
          "sunset": 1589677822,
          "temp": {
            "day": 20.92,
            "min": 19.01,
            "max": 20.94,
            "night": 19.07,
            "eve": 19.3,
            "morn": 19.47
          },
          "feels_like": {
            "day": 22.35,
            "night": 18.51,
            "eve": 20.03,
            "morn": 20.97
          },
          "pressure": 1009,
          "humidity": 96,
          "dew_point": 20.26,
          "wind_speed": 3.42,
          "wind_deg": 147,
          "weather": [
            {
              "id": 502,
              "main": "Rain",
              "description": "heavy intensity rain",
              "icon": "10d"
            }
          ],
          "clouds": 98,
          "rain": 41.14,
          "uvi": 11
        },
        {
          "dt": 1589738400,
          "sunrise": 1589714056,
          "sunset": 1589764267,
          "temp": {
            "day": 26.22,
            "min": 16.17,
            "max": 27.43,
            "night": 16.17,
            "eve": 23.88,
            "morn": 17.93
          },
          "feels_like": {
            "day": 25.38,
            "night": 15.59,
            "eve": 24.28,
            "morn": 15.02
          },
          "pressure": 1012,
          "humidity": 66,
          "dew_point": 19.38,
          "wind_speed": 6.05,
          "wind_deg": 290,
          "weather": [
            {
              "id": 501,
              "main": "Rain",
              "description": "moderate rain",
              "icon": "10d"
            }
          ],
          "clouds": 79,
          "rain": 4.97,
          "uvi": 10.1
        }
      ],
    };

    Client mockClient;
    OpenWeatherProvider openWeatherProvider;

    setUp(() {
      mockClient = MockClient();
      Response mockResponse = Response(jsonEncode(rawOpenWeather), 200);
      when(mockClient.get(
              'https://api.openweathermap.org/data/2.5/onecall?lat=$mockLat&lon=$mockLong&exclude=minutely,hourly&appid=$apiKey'))
          .thenAnswer((invocation) => Future.value(mockResponse));

      when(mockClient.get(
              'https://api.openweathermap.org/data/2.5/onecall?lat=$errorLat&lon=$errorLong&exclude=minutely,hourly&appid=$apiKey'))
          .thenThrow(responseException);

      openWeatherProvider = new OpenWeatherProvider(mockClient);
    });

    test('Retrieve and serialise one call models', () async {
      WeatherForecastModel oneCallModel =
          await openWeatherProvider.getOneCall(33.441792, -94.037689);
      DailyForecastModel daily = oneCallModel.daily[1];
      testCurrentWeather(oneCallModel);
      testTomorrowForecast(daily);
    });

    test('Attempt to retrieve and serialise one call models and fail',
        () async {
      expect(
        () async => await openWeatherProvider.getOneCall(errorLat, errorLong),
        // throwsA(comparisonException),
        throwsA(
          predicate(
              (e) => e is HttpException && e.message == 'invalid location'),
        ),
      );
    });
  });
}

void testCurrentWeather(WeatherForecastModel oneCallModel) {
  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(1589633683 * 1000);
  int humidityComparison = 93;
  CurrentForecastModel currentWeather = oneCallModel.current;
  TemperatureModel temp = TemperatureModel(max: 20.94, min: 19.01, day: 20.92);
  WeatherDescriptionModel weather = WeatherDescriptionModel(
      description: 'overcast clouds', main: 'Clouds', icon: '04d', id: 804);
  expect(currentWeather.dt, dateTime);
  expect(currentWeather.humidity, humidityComparison);
  expect(currentWeather.temp, temp);
  expect(currentWeather.weather, [weather]);
}

void testTomorrowForecast(DailyForecastModel forecast) {
  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(1589738400 * 1000);
  TemperatureModel temp = TemperatureModel(min: 16.17, max: 27.43, day: 26.22);
  WeatherDescriptionModel weather = WeatherDescriptionModel(
      description: 'moderate rain', main: 'Rain', icon: '10d', id: 501);
  expect(forecast.dt, dateTime);
  expect(forecast.temp, temp);
  expect(forecast.weather, [weather]);
}
