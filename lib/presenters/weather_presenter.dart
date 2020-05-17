import 'package:nova_weather/enums/weather_status.dart';
import 'package:nova_weather/interfaces/weather_forecast_view.dart';
import 'package:nova_weather/interfaces/weather_presenter_interface.dart';
import 'package:nova_weather/models/location_model.dart';
import 'package:nova_weather/models/weather_forecast.dart';
import 'package:nova_weather/providers/open_weather_provider.dart';

class WeatherPresenter implements WeatherPresenterInterface {
  final OpenWeatherProvider openWeatherProvider;
  WeatherForecastModel weatherForecastModel;
  WeatherForecastViewInterface _forecastView;
  WeatherStatus _weatherStatus = WeatherStatus.WeatherStatusInitial;
  LocationModel _locationModel;

  WeatherPresenter(this.openWeatherProvider);

  @override
  Future<void> retrieveWeatherUpdate() async {
    weatherStatus = WeatherStatus.WeatherStatusLoading;
    try {
      weatherForecastModel = await openWeatherProvider.getOneCall(
          locationModel.lat, locationModel.long);
      forecastView.updateWeatherForecast();
      weatherStatus = WeatherStatus.WeatherStatusSuccess;
    } catch (e) {
      weatherStatus = WeatherStatus.WeatherStatusFailed;
    }
  }

  WeatherStatus get weatherStatus => _weatherStatus;

  set weatherStatus(WeatherStatus newValue) {
    _weatherStatus = newValue;
    forecastView.updateWeatherForecast();
  }

  WeatherForecastViewInterface get forecastView => _forecastView;

  set forecastView(WeatherForecastViewInterface newValue) {
    _forecastView = newValue;
  }

  LocationModel get locationModel => _locationModel;

  set locationModel(LocationModel newValue) {
    _locationModel = newValue;
  }
}
