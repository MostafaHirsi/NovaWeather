import 'package:nova_weather/interfaces/weather_presenter_interface.dart';
import 'package:nova_weather/models/weather_forecast.dart';
import 'package:nova_weather/providers/open_weather_provider.dart';
import 'package:nova_weather/views/weather_forecast_view.dart';

class WeatherPresenter implements WeatherPresenterInterface {
  final OpenWeatherProvider openWeatherProvider;
  WeatherForecastModel weatherForecastModel;
  WeatherForecastView forecastView;

  WeatherPresenter(this.openWeatherProvider);

  @override
  Future<WeatherForecastModel> retrieveWeatherUpdate() async {
    weatherForecastModel =
        await openWeatherProvider.getOneCall(51.5074, 0.1278);
    forecastView.updateWeatherForecast();
  }
}
