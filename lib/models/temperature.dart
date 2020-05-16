import 'package:equatable/equatable.dart';

class TemperatureModel extends Equatable {
  double day;
  double min;
  double max;

  TemperatureModel({this.day, this.min, this.max});

  TemperatureModel.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    min = json['min'];
    max = json['max'];
  }

  @override
  List<Object> get props => [day, min, max];
}
