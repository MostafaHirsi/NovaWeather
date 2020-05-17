import 'package:nova_weather/interfaces/weather_forecast_view.dart';
import 'package:nova_weather/presenters/weather_presenter.dart';

class MockWeatherForecastView implements WeatherForecastViewInterface {
  final WeatherPresenter weatherPresenter;

  MockWeatherForecastView(this.weatherPresenter) {
    weatherPresenter.forecastView = this;
  }

  @override
  void updateWeatherForecast() {}
}
