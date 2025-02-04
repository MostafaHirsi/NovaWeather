import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nova_weather/models/current_forecast.dart';
import 'package:nova_weather/models/location_model.dart';
import 'package:nova_weather/views/common/weather_icon.dart';

class CurrentWeatherView extends StatelessWidget {
  final CurrentForecastModel currentForecastModel;
  final LocationModel locationModel;
  final Function updateWeather;

  const CurrentWeatherView(
      {Key key,
      this.currentForecastModel,
      this.updateWeather,
      this.locationModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              buildHeadlineLabel(locationModel.locationName, context),
              buildRefreshButton(),
            ],
          ),
          buildHeadlineLabel(locationModel.country, context),
          buildDateTimeLabel(context),
          Spacer(),
          buildHeadlineLabel('Today', context, center: true),
          buildTemperature(context),
          buildSubheadingLabel(currentForecastModel.weather.first.main, context,
              center: true),
          Spacer(),
        ],
      ),
    );
  }

  Widget buildRefreshButton() {
    return Container(
      child: IconButton(
        icon: Icon(
          Icons.refresh,
          color: Colors.white,
        ),
        onPressed: updateWeather,
      ),
    );
  }

  Widget buildTemperature(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          WeatherIcon(
            weatherDescriptionModel: currentForecastModel.weather.first,
          ),
          buildHeadlineLabel(
            '${currentForecastModel.temp.day.round()} °',
            context,
            bold: true,
          ),
        ],
      ),
    );
  }

  Widget buildDateTimeLabel(BuildContext context) {
    DateTime todayDate = DateTime.now();
    var formatter = new DateFormat('EEEE, d MMMM');
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: buildSubheadingLabel(formatter.format(todayDate), context),
    );
  }

  Widget buildHeadlineLabel(String label, BuildContext context,
      {bool bold = false, bool center = false}) {
    TextStyle textStyle = Theme.of(context).textTheme.headline;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      alignment: center ? Alignment.center : Alignment.centerLeft,
      child: buildLabel(center, label, context, bold, textStyle),
    );
  }

  Widget buildSubheadingLabel(String label, BuildContext context,
      {bool bold = false, bool center = false}) {
    TextStyle textStyle = Theme.of(context).textTheme.subhead;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      alignment: center ? Alignment.center : Alignment.centerLeft,
      child: buildLabel(center, label, context, bold, textStyle),
    );
  }

  Widget buildLabel(bool center, String label, BuildContext context, bool bold,
      TextStyle textStyle) {
    return Text(
      label,
      style: textStyle.copyWith(
        fontWeight: bold ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }
}
