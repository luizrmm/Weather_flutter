import 'package:flutter/foundation.dart';
import 'package:teste_flutter/features/weather/data/models/weather_enum.dart';
import 'package:teste_flutter/features/weather/domain/entities/weather.dart';

class WeatherModel extends Weather {
  WeatherModel(
      {@required int temperature,
      @required String time,
      @required String description,
      @required String currently,
      @required WeatherCondition conditionSlug,
      @required String cityName})
      : super(
            temperature: temperature,
            time: time,
            description: description,
            currently: currently,
            conditionSlug: conditionSlug,
            cityName: cityName);

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      temperature: json['results']["temp"],
      time: json['results']["time"],
      description: json['results']["description"],
      currently: json['results']["currently"],
      conditionSlug:
          _mapStringToWeatherCondition(json['results']["condition_slug"]),
      cityName: json['results']["city_name"],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['temp'] = this.temperature;
    data['time'] = this.time;
    data['description'] = this.description;
    data['currently'] = this.currently;
    data['condition_slug'] = _mapWeatherConditionToString(this.conditionSlug);
    data['city_name'] = this.cityName;
    return data;
  }

  static WeatherCondition _mapStringToWeatherCondition(String input) {
    WeatherCondition state;
    switch (input) {
      case 'rain':
      case 'storm':
        state = WeatherCondition.rain;
        break;
      case 'snow':
        state = WeatherCondition.snow;
        break;
      case 'fog':
        state = WeatherCondition.fog;
        break;
      case 'clear_day':
        state = WeatherCondition.clearDay;
        break;
      case 'clear_night':
        state = WeatherCondition.clearNight;
        break;
      case 'cloudly_day':
        state = WeatherCondition.partCloudDay;
        break;
      case 'cloudly_night':
        state = WeatherCondition.partCloudNight;
        break;
      case 'hail':
        state = WeatherCondition.sleet;
        break;
      default:
        state = WeatherCondition.cloudy;
    }
    return state;
  }

  static String _mapWeatherConditionToString(WeatherCondition input) {
    String state;
    switch (input) {
      case WeatherCondition.rain:
        state = 'rain';
        break;
      case WeatherCondition.snow:
        state = 'snow';
        break;
      case WeatherCondition.fog:
        state = 'fog';
        break;
      case WeatherCondition.clearDay:
        state = 'clear_day';
        break;
      case WeatherCondition.clearNight:
        state = "clear_night";
        break;
      case WeatherCondition.partCloudDay:
        state = 'cloudly_day';
        break;
      case WeatherCondition.partCloudNight:
        state = 'cloudly_night';
        break;
      case WeatherCondition.sleet:
        state = 'hail';
        break;
      default:
        state = 'cloud';
    }
    return state;
  }
}
