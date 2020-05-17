import 'package:equatable/equatable.dart';

class TemperatureModel extends Equatable {
  double day;
  double min;
  double max;

  TemperatureModel({this.day, this.min, this.max});

  TemperatureModel.fromJson(Map<String, dynamic> json) {
    day = json['day'].toDouble();
    min = json['min'].toDouble();
    max = json['max'].toDouble();
  }

  @override
  List<Object> get props => [day, min, max];
}
