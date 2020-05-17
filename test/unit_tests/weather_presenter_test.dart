import 'package:flutter_test/flutter_test.dart';
import 'package:nova_weather/enums/weather_status.dart';
import 'package:nova_weather/interfaces/weather_forecast_view.dart';
import 'package:nova_weather/models/current_forecast.dart';
import 'package:nova_weather/models/daily_forecast.dart';
import 'package:nova_weather/models/location_model.dart';
import 'package:nova_weather/models/temperature.dart';
import 'package:nova_weather/models/weather_description.dart';
import 'package:nova_weather/models/weather_forecast.dart';
import 'package:nova_weather/presenters/weather_presenter.dart';
import 'package:nova_weather/providers/open_weather_provider.dart';
import '../mocks/mock_open_weather_provider.dart';
import '../mocks/mock_weather_forecast_view.dart';

main() {
  group('Weather Presenter Test: ', () {
    double mockLat = 33.441792;
    double mockLong = -94.037689;

    double errorLat = 0;
    double errorLong = 0;

    LocationModel mockLocation =
        LocationModel("Birmingham", "United Kingdom", mockLat, mockLong);
    LocationModel errorLocation =
        LocationModel("Nowhere", "United Kingdom", errorLat, errorLong);

    OpenWeatherProvider openWeatherProvider;
    WeatherPresenter weatherPresenter;
    WeatherForecastViewInterface mockWeatherForecastView;

    setUp(() {
      openWeatherProvider = new MockOpenWeatherProvider();

      weatherPresenter = WeatherPresenter(
        openWeatherProvider,
      );
      weatherPresenter.forecastView = mockWeatherForecastView;
      mockWeatherForecastView = MockWeatherForecastView(weatherPresenter);
    });

    test('Status of presenter should be successful after api call', () async {
      weatherPresenter.locationModel = mockLocation;
      weatherPresenter.retrieveWeatherUpdate();
      await expectLater(weatherPresenter.weatherStatus,
              WeatherStatus.WeatherStatusLoading)
          .then((value) {});
      expectLater(
          weatherPresenter.weatherStatus, WeatherStatus.WeatherStatusSuccess);
      testCurrentWeather(weatherPresenter.weatherForecastModel);
      DailyForecastModel daily = weatherPresenter.weatherForecastModel.daily[1];
      testTomorrowForecast(daily);
    });

    test('Status of presenter should be failed after api call', () {
      weatherPresenter.locationModel = errorLocation;
      weatherPresenter.retrieveWeatherUpdate();
      expectLater(weatherPresenter.weatherStatus,
              WeatherStatus.WeatherStatusLoading)
          .then((value) {
        expectLater(weatherPresenter.weatherForecastModel, null);
        expectLater(
            weatherPresenter.weatherStatus, WeatherStatus.WeatherStatusFailed);
      });
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
