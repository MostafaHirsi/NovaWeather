import 'package:nova_weather/enums/weather_status.dart';
import 'package:nova_weather/interfaces/weather_presenter_interface.dart';
import 'package:nova_weather/models/weather_forecast.dart';
import 'package:nova_weather/providers/open_weather_provider.dart';
import 'package:nova_weather/views/weather_forecast_view.dart';

class WeatherPresenter implements WeatherPresenterInterface {
  final OpenWeatherProvider openWeatherProvider;
  WeatherForecastModel weatherForecastModel;
  WeatherForecastView _forecastView;
  WeatherStatus _weatherStatus = WeatherStatus.WeatherStatusInitial;

  WeatherPresenter(this.openWeatherProvider);

  @override
  Future<WeatherForecastModel> retrieveWeatherUpdate() async {
    weatherStatus = WeatherStatus.WeatherStatusLoading;
    try {
      weatherForecastModel =
          await openWeatherProvider.getOneCall(51.5074, 0.1278);
      forecastView.updateWeatherForecast();
      weatherStatus = WeatherStatus.WeatherStatusSuccess;
    } catch (e) {
      weatherStatus = WeatherStatus.WeatherStatusFailed;
    }
  }

  @override
  WeatherStatus get weatherStatus => _weatherStatus;

  @override
  set weatherStatus(WeatherStatus newValue) {
    _weatherStatus = newValue;
    forecastView.updateWeatherForecast();
  }

  @override
  WeatherForecastView get forecastView => _forecastView;

  @override
  set forecastView(WeatherForecastView newValue) {
    _forecastView = newValue;
  }
}
