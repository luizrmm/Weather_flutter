import 'package:equatable/equatable.dart';

class Weather extends Equatable {
  final int temperature;
  final String time;
  final String description;
  final String currently;
  final String conditionSlug;
  final String cityName;

  Weather(
      {required this.temperature,
      required this.time,
      required this.description,
      required this.currently,
      required this.conditionSlug,
      required this.cityName});

  @override
  List<Object?> get props =>
      [temperature, time, description, currently, conditionSlug, cityName];
}
