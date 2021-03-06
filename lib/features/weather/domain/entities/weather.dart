import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:teste_flutter/features/weather/data/models/weather_enum.dart';

class Weather extends Equatable {
  final int temperature;
  final String time;
  final String description;
  final String currently;
  final WeatherCondition conditionSlug;
  final String cityName;

  Weather(
      {@required this.temperature,
      @required this.time,
      @required this.description,
      @required this.currently,
      @required this.conditionSlug,
      @required this.cityName});

  @override
  List<Object> get props =>
      [temperature, time, description, currently, conditionSlug, cityName];
}
