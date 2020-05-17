import 'package:flutter/widgets.dart';
import 'package:http/http.dart';

import 'presenters/weather_presenter.dart';
import 'providers/open_weather_provider.dart';

class Injector extends InheritedWidget {
  OpenWeatherProvider openWeatherProvider;
  WeatherPresenter weatherPresenter;

  Injector({
    Key key,
    @required Widget child,
  })  : assert(child != null),
        super(key: key, child: child) {
    Client httpClient = Client();
    openWeatherProvider = OpenWeatherProvider(httpClient);
    weatherPresenter = WeatherPresenter(openWeatherProvider);
  }

  static Injector of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Injector>();
  }

  @override
  bool updateShouldNotify(Injector old) {
    return true;
  }
}
