import 'package:equatable/equatable.dart';

class WeatherDescriptionModel extends Equatable {
  int id;
  String main;
  String description;
  String icon;

  WeatherDescriptionModel({this.id, this.main, this.description, this.icon});

  WeatherDescriptionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    main = json['main'];
    description = json['description'];
    icon = json['icon'];
  }

  @override
  List<Object> get props => [id, main, description, icon];
}
