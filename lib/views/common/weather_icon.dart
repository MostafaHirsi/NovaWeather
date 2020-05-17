import 'package:flutter/material.dart';
import 'package:nova_weather/models/weather_description.dart';

class WeatherIcon extends StatelessWidget {
  final double scale;
  final WeatherDescriptionModel weatherDescriptionModel;
  const WeatherIcon({Key key, this.weatherDescriptionModel, this.scale = 1.2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String weatherIcon = weatherDescriptionModel.icon;
    return Container(
      child: Image.asset(
        'assets/icons/$weatherIcon@2x.png',
        filterQuality: FilterQuality.high,
        scale: scale,
      ),
    );
  }
}
