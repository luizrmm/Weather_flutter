import 'package:teste_flutter/features/weather/domain/entities/weather.dart';

class WeatherModel extends Weather {
  WeatherModel(
      {required temperature,
      required time,
      required description,
      required currently,
      required conditionSlug,
      required cityName})
      : super(
            temperature: temperature,
            time: time,
            description: description,
            currently: currently,
            conditionSlug: conditionSlug,
            cityName: cityName);

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      temperature: json["temp"],
      time: json["time"],
      description: json["description"],
      currently: json["currently"],
      conditionSlug: json["condition_slug"],
      cityName: json["city_name"],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['temp'] = this.temperature;
    data['time'] = this.time;
    data['description'] = this.description;
    data['currently'] = this.currently;
    data['condition_slug'] = this.conditionSlug;
    data['city_name'] = this.cityName;
    return data;
  }
}
