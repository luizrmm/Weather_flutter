import 'package:flutter/material.dart';
import 'package:teste_flutter/features/weather/data/models/weather_enum.dart';

class WeatherConditionWidget extends StatelessWidget {
  final WeatherCondition condition;

  const WeatherConditionWidget({Key key, @required this.condition})
      : super(key: key);
  @override
  Widget build(BuildContext context) => _mapConditionToImage(condition);

  Image _mapConditionToImage(WeatherCondition condition) {
    Image image;
    switch (condition) {
      case WeatherCondition.clearNight:
        image = Image.asset('assets/clear_night.png');
        break;
      case WeatherCondition.clearDay:
        image = Image.asset('assets/clear-day.png');
        break;
      case WeatherCondition.cloudy:
        image = Image.asset('assets/cloudy.png');
        break;
      case WeatherCondition.fog:
        image = Image.asset('assets/fog.png');
        break;
      case WeatherCondition.partCloudDay:
        image = Image.asset('assets/partly-cloudy-day.png');
        break;
      case WeatherCondition.partCloudNight:
        image = Image.asset('assets/partly-cloudy-night.png');
        break;
      case WeatherCondition.rain:
        image = Image.asset('assets/rain.png');
        break;
      case WeatherCondition.sleet:
        image = Image.asset('assets/sleet.png');
        break;

      case WeatherCondition.snow:
        image = Image.asset('assets/snow.png');
        break;
      default:
        image = Image.asset('assets/wind.png');
    }
    return image;
  }
}
